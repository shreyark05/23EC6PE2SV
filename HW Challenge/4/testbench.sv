`timescale 1ns/1ps

module eth_packet_tb;

    EthPacket pkt;

    int tb_len;
    int tb_payload_size;

    // COVERAGE
    covergroup pkt_cov with function sample(int len, int size);

        coverpoint len {
            bins len_vals[] = {[4:8]};
        }

        coverpoint size {
            bins size_vals[] = {[4:8]};
        }

        cross len, size;

    endgroup

    pkt_cov cov = new();

    initial begin
        $dumpfile("eth_packet.vcd");
        $dumpvars(0, eth_packet_tb);

        // Force each len once → 100% bins
        for (int i = 4; i <= 8; i++) begin

            pkt = new();

            assert(pkt.randomize() with { len == i; });

            tb_len = pkt.len;
            tb_payload_size = pkt.payload.size();

            cov.sample(tb_len, tb_payload_size);

            $display("Len=%0d PayloadSize=%0d Payload=%p",
                     tb_len, tb_payload_size, pkt.payload);

            #10;
        end

        $display("\nCoverage = %0.2f %%", cov.get_coverage());
        $finish;
    end

endmodule
