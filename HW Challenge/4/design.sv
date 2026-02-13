class EthPacket;

    rand int len;
    rand bit [7:0] payload[];

    constraint len_range { len inside {[4:8]}; }
    constraint size_match { payload.size() == len; }

endclass
