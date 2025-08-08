#include <core.p4>
#include <tna.p4>

header ethernet_t {
    bit<48> dstAddr;
    bit<48> srcAddr;
    bit<16> etherType;
}

header ipv4_t {
    bit<4>  version;
    bit<4>  ihl;
    bit<8>  diffserv;
    bit<16> totalLen;
    bit<16> identification;
    bit<3>  flags;
    bit<13> fragOffset;
    bit<8>  ttl;
    bit<8>  protocol;
    bit<16> hdrChecksum;
    bit<32> srcAddr;
    bit<32> dstAddr;
}

struct metadata_t {
    // Add your metadata here if needed
}

struct headers {
    ethernet_t ethernet;
    ipv4_t     ipv4;
}

// ***** INGRESS PARSER *****
parser IngressParser(packet_in pkt,
                    out headers hdr,
                    out metadata_t meta,
                    out ingress_intrinsic_metadata_t ig_intr_md) {
    state start {
        pkt.extract(ig_intr_md);
        pkt.advance(PORT_METADATA_SIZE);
        pkt.extract(hdr.ethernet);
        transition select(hdr.ethernet.etherType) {
            0x0800: parse_ipv4;
            default: accept;
        }
    }
    
    state parse_ipv4 {
        pkt.extract(hdr.ipv4);
        transition accept;
    }
}

// ***** INGRESS CONTROL *****
control Ingress(inout headers hdr,
               inout metadata_t meta,
               in ingress_intrinsic_metadata_t ig_intr_md,
               in ingress_intrinsic_metadata_from_parser_t ig_prsr_md,
               inout ingress_intrinsic_metadata_for_deparser_t ig_dprsr_md,
               inout ingress_intrinsic_metadata_for_tm_t ig_tm_md) {
    
    action drop() {
        ig_dprsr_md.drop_ctl = 1;
    }
    
    action ipv4_forward(PortId_t port) {
        ig_tm_md.ucast_egress_port = port;
        hdr.ipv4.ttl = hdr.ipv4.ttl - 1;
    }
    
    table ipv4_lpm {
        key = {
            hdr.ipv4.dstAddr: lpm;
        }
        actions = {
            ipv4_forward;
            drop;
            NoAction;
        }
        size = 1024;
        default_action = drop();
    }
    
    apply {
        if (hdr.ipv4.isValid()) {
            ipv4_lpm.apply();
        }
    }
}

// ***** INGRESS DEPARSER *****
control IngressDeparser(packet_out pkt,
                       inout headers hdr,
                       in metadata_t meta,
                       in ingress_intrinsic_metadata_for_deparser_t ig_dprsr_md) {
    apply {
        pkt.emit(hdr);
    }
}

// ***** EGRESS PARSER *****
parser EgressParser(packet_in pkt,
                   out headers hdr,
                   out metadata_t meta,
                   out egress_intrinsic_metadata_t eg_intr_md) {
    state start {
        pkt.extract(eg_intr_md);
        pkt.extract(hdr.ethernet);
        transition select(hdr.ethernet.etherType) {
            0x0800: parse_ipv4;
            default: accept;
        }
    }
    
    state parse_ipv4 {
        pkt.extract(hdr.ipv4);
        transition accept;
    }
}

// ***** EGRESS CONTROL *****
control Egress(inout headers hdr,
              inout metadata_t meta,
              in egress_intrinsic_metadata_t eg_intr_md,
              in egress_intrinsic_metadata_from_parser_t eg_prsr_md,
              inout egress_intrinsic_metadata_for_deparser_t eg_dprsr_md,
              inout egress_intrinsic_metadata_for_output_port_t eg_oport_md) {
    
    action rewrite_mac(bit<48> src_mac, bit<48> dst_mac) {
        hdr.ethernet.srcAddr = src_mac;
        hdr.ethernet.dstAddr = dst_mac;
    }
    
    table next_hop {
        key = {
            eg_intr_md.egress_port: exact;
        }
        actions = {
            rewrite_mac;
            NoAction;
        }
        size = 1024;
        default_action = NoAction();
    }
    
    apply {
        if (hdr.ipv4.isValid()) {
            next_hop.apply();
        }
    }
}

// ***** EGRESS DEPARSER *****
control EgressDeparser(packet_out pkt,
                      inout headers hdr,
                      in metadata_t meta,
                      in egress_intrinsic_metadata_for_deparser_t eg_dprsr_md) {
    apply {
        pkt.emit(hdr);
    }
}

// ***** SWITCH *****
Pipeline(
    IngressParser(),
    Ingress(),
    IngressDeparser(),
    EgressParser(),
    Egress(),
    EgressDeparser()
) pipe;

Switch(pipe) main;