IMAGE := laida-sim
BUILD := build
STOPTIME := 10us
GHDL_FLAGS := --std=08

.DEFAULT_GOAL := sim
.PHONY: sim clean docker-build docker-sim

sim:
	@echo "[02] binary_to_gray"
	@mkdir -p $(BUILD)/02 && cd $(BUILD)/02 && \
	  ghdl -a $(GHDL_FLAGS) ../../02/binary_to_gray.vhd ../../02/tb_binary_to_gray.vhd && \
	  ghdl -e $(GHDL_FLAGS) tb_binary_to_gray && \
	  ghdl -r $(GHDL_FLAGS) tb_binary_to_gray --vcd=tb_binary_to_gray.vcd --stop-time=$(STOPTIME)

	@echo "[03] logic_function"
	@mkdir -p $(BUILD)/03 && cd $(BUILD)/03 && \
	  ghdl -a $(GHDL_FLAGS) ../../03/logic_function.vhd ../../03/tb_logic_function.vhd && \
	  ghdl -e $(GHDL_FLAGS) tb_logic_function && \
	  ghdl -r $(GHDL_FLAGS) tb_logic_function --vcd=tb_logic_function.vcd --stop-time=$(STOPTIME)

	@echo "[03] majority"
	@mkdir -p $(BUILD)/03 && cd $(BUILD)/03 && \
	  ghdl -a $(GHDL_FLAGS) ../../03/majority.vhd ../../03/tb_majority.vhd && \
	  ghdl -e $(GHDL_FLAGS) tb_majority && \
	  ghdl -r $(GHDL_FLAGS) tb_majority --vcd=tb_majority.vcd --stop-time=$(STOPTIME)

	@echo "[04] minimized_function"
	@mkdir -p $(BUILD)/04 && cd $(BUILD)/04 && \
	  ghdl -a $(GHDL_FLAGS) ../../04/minimized_function.vhd ../../04/tb_minimized_function.vhd && \
	  ghdl -e $(GHDL_FLAGS) tb_minimized_function && \
	  ghdl -r $(GHDL_FLAGS) tb_minimized_function --vcd=tb_minimized_function.vcd --stop-time=$(STOPTIME)

	@echo "[06] full_adder"
	@mkdir -p $(BUILD)/06 && cd $(BUILD)/06 && \
	  ghdl -a $(GHDL_FLAGS) ../../06/full_adder.vhd ../../06/tb_full_adder.vhd && \
	  ghdl -e $(GHDL_FLAGS) tb_full_adder && \
	  ghdl -r $(GHDL_FLAGS) tb_full_adder --vcd=tb_full_adder.vcd --stop-time=$(STOPTIME)

	@echo "[07] sr_latch"
	@mkdir -p $(BUILD)/07/sr_latch && cd $(BUILD)/07/sr_latch && \
	  ghdl -a $(GHDL_FLAGS) ../../../07/sr_latch.vhd ../../../07/tb_sr_latch.vhd && \
	  ghdl -e $(GHDL_FLAGS) tb_sr_latch && \
	  ghdl -r $(GHDL_FLAGS) tb_sr_latch --vcd=tb_sr_latch.vcd --stop-time=$(STOPTIME)

	@echo "[07] sr_ff"
	@mkdir -p $(BUILD)/07/sr_ff && cd $(BUILD)/07/sr_ff && \
	  ghdl -a $(GHDL_FLAGS) ../../../07/sr_ff.vhd ../../../07/tb_sr_ff.vhd && \
	  ghdl -e $(GHDL_FLAGS) tb_sr_ff && \
	  ghdl -r $(GHDL_FLAGS) tb_sr_ff --vcd=tb_sr_ff.vcd --stop-time=$(STOPTIME)

	@echo "[07] d_ff"
	@mkdir -p $(BUILD)/07/d_ff && cd $(BUILD)/07/d_ff && \
	  ghdl -a $(GHDL_FLAGS) ../../../07/d_ff.vhd ../../../07/tb_d_ff.vhd && \
	  ghdl -e $(GHDL_FLAGS) tb_d_ff && \
	  ghdl -r $(GHDL_FLAGS) tb_d_ff --vcd=tb_d_ff.vcd --stop-time=$(STOPTIME)

	@echo "[07] d_ff_rst"
	@mkdir -p $(BUILD)/07/d_ff_rst && cd $(BUILD)/07/d_ff_rst && \
	  ghdl -a $(GHDL_FLAGS) ../../../07/d_ff_rst.vhd ../../../07/tb_d_ff_rst.vhd && \
	  ghdl -e $(GHDL_FLAGS) tb_d_ff_rst && \
	  ghdl -r $(GHDL_FLAGS) tb_d_ff_rst --vcd=tb_d_ff_rst.vcd --stop-time=$(STOPTIME)

	@echo "[07] jk_ff"
	@mkdir -p $(BUILD)/07/jk_ff && cd $(BUILD)/07/jk_ff && \
	  ghdl -a $(GHDL_FLAGS) ../../../07/jk_ff.vhd ../../../07/tb_jk_ff.vhd && \
	  ghdl -e $(GHDL_FLAGS) tb_jk_ff && \
	  ghdl -r $(GHDL_FLAGS) tb_jk_ff --vcd=tb_jk_ff.vcd --stop-time=$(STOPTIME)

	@echo "[07] t_ff"
	@mkdir -p $(BUILD)/07/t_ff && cd $(BUILD)/07/t_ff && \
	  ghdl -a $(GHDL_FLAGS) ../../../07/t_ff.vhd ../../../07/tb_t_ff.vhd && \
	  ghdl -e $(GHDL_FLAGS) tb_t_ff && \
	  ghdl -r $(GHDL_FLAGS) tb_t_ff --vcd=tb_t_ff.vcd --stop-time=$(STOPTIME)

	@echo "[07] d_from_jk (ovisi o jk_ff)"
	@mkdir -p $(BUILD)/07/d_from_jk && cd $(BUILD)/07/d_from_jk && \
	  ghdl -a $(GHDL_FLAGS) ../../../07/jk_ff.vhd ../../../07/d_from_jk.vhd ../../../07/tb_d_from_jk.vhd && \
	  ghdl -e $(GHDL_FLAGS) tb_d_from_jk && \
	  ghdl -r $(GHDL_FLAGS) tb_d_from_jk --vcd=tb_d_from_jk.vcd --stop-time=$(STOPTIME)

	@echo "[07] jk_from_sr (ovisi o sr_ff)"
	@mkdir -p $(BUILD)/07/jk_from_sr && cd $(BUILD)/07/jk_from_sr && \
	  ghdl -a $(GHDL_FLAGS) ../../../07/sr_ff.vhd ../../../07/jk_from_sr.vhd ../../../07/tb_jk_from_sr.vhd && \
	  ghdl -e $(GHDL_FLAGS) tb_jk_from_sr && \
	  ghdl -r $(GHDL_FLAGS) tb_jk_from_sr --vcd=tb_jk_from_sr.vcd --stop-time=$(STOPTIME)

	@echo "[07] t_from_jk (ovisi o jk_ff)"
	@mkdir -p $(BUILD)/07/t_from_jk && cd $(BUILD)/07/t_from_jk && \
	  ghdl -a $(GHDL_FLAGS) ../../../07/jk_ff.vhd ../../../07/t_from_jk.vhd ../../../07/tb_t_from_jk.vhd && \
	  ghdl -e $(GHDL_FLAGS) tb_t_from_jk && \
	  ghdl -r $(GHDL_FLAGS) tb_t_from_jk --vcd=tb_t_from_jk.vcd --stop-time=$(STOPTIME)

	@echo "[08] sequence_detector"
	@mkdir -p $(BUILD)/08 && cd $(BUILD)/08 && \
	  ghdl -a $(GHDL_FLAGS) ../../08/sequence_detector.vhd ../../08/tb_sequence_detector.vhd && \
	  ghdl -e $(GHDL_FLAGS) tb_sequence_detector && \
	  ghdl -r $(GHDL_FLAGS) tb_sequence_detector --vcd=tb_sequence_detector.vcd --stop-time=$(STOPTIME)

	@echo "[09] binary_counter"
	@mkdir -p $(BUILD)/09/binary_counter && cd $(BUILD)/09/binary_counter && \
	  ghdl -a $(GHDL_FLAGS) ../../../09/binary_counter.vhd ../../../09/tb_binary_counter.vhd && \
	  ghdl -e $(GHDL_FLAGS) tb_binary_counter && \
	  ghdl -r $(GHDL_FLAGS) tb_binary_counter --vcd=tb_binary_counter.vcd --stop-time=$(STOPTIME)

	@echo "[09] async_binary_counter"
	@mkdir -p $(BUILD)/09/async_binary_counter && cd $(BUILD)/09/async_binary_counter && \
	  ghdl -a $(GHDL_FLAGS) ../../../09/async_binary_counter.vhd ../../../09/tb_async_binary_counter.vhd && \
	  ghdl -e $(GHDL_FLAGS) tb_async_binary_counter && \
	  ghdl -r $(GHDL_FLAGS) tb_async_binary_counter --vcd=tb_async_binary_counter.vcd --stop-time=$(STOPTIME)

	@echo "[09] ring_counter"
	@mkdir -p $(BUILD)/09/ring_counter && cd $(BUILD)/09/ring_counter && \
	  ghdl -a $(GHDL_FLAGS) ../../../09/ring_counter.vhd ../../../09/tb_ring_counter.vhd && \
	  ghdl -e $(GHDL_FLAGS) tb_ring_counter && \
	  ghdl -r $(GHDL_FLAGS) tb_ring_counter --vcd=tb_ring_counter.vcd --stop-time=$(STOPTIME)

	@echo "[09] johnson_counter"
	@mkdir -p $(BUILD)/09/johnson_counter && cd $(BUILD)/09/johnson_counter && \
	  ghdl -a $(GHDL_FLAGS) ../../../09/johnson_counter.vhd ../../../09/tb_johnson_counter.vhd && \
	  ghdl -e $(GHDL_FLAGS) tb_johnson_counter && \
	  ghdl -r $(GHDL_FLAGS) tb_johnson_counter --vcd=tb_johnson_counter.vcd --stop-time=$(STOPTIME)

	@echo "[09] modulo_counter"
	@mkdir -p $(BUILD)/09/modulo_counter && cd $(BUILD)/09/modulo_counter && \
	  ghdl -a $(GHDL_FLAGS) ../../../09/modulo_counter.vhd ../../../09/tb_modulo_counter.vhd && \
	  ghdl -e $(GHDL_FLAGS) tb_modulo_counter && \
	  ghdl -r $(GHDL_FLAGS) tb_modulo_counter --vcd=tb_modulo_counter.vcd --stop-time=$(STOPTIME)

	@echo "[09] seq_gen"
	@mkdir -p $(BUILD)/09/seq_gen && cd $(BUILD)/09/seq_gen && \
	  ghdl -a $(GHDL_FLAGS) ../../../09/seq_gen.vhd ../../../09/tb_seq_gen.vhd && \
	  ghdl -e $(GHDL_FLAGS) tb_seq_gen && \
	  ghdl -r $(GHDL_FLAGS) tb_seq_gen --vcd=tb_seq_gen.vcd --stop-time=$(STOPTIME)

	@echo "[09] semafor"
	@mkdir -p $(BUILD)/09/semafor && cd $(BUILD)/09/semafor && \
	  ghdl -a $(GHDL_FLAGS) ../../../09/semafor.vhd ../../../09/tb_semafor.vhd && \
	  ghdl -e $(GHDL_FLAGS) tb_semafor && \
	  ghdl -r $(GHDL_FLAGS) tb_semafor --vcd=tb_semafor.vcd --stop-time=$(STOPTIME)

	@echo "[09] uart_rx"
	@mkdir -p $(BUILD)/09/uart_rx && cd $(BUILD)/09/uart_rx && \
	  ghdl -a $(GHDL_FLAGS) ../../../09/uart_rx.vhd ../../../09/tb_uart_rx.vhd && \
	  ghdl -e $(GHDL_FLAGS) tb_uart_rx && \
	  ghdl -r $(GHDL_FLAGS) tb_uart_rx --vcd=tb_uart_rx.vcd --stop-time=$(STOPTIME)

	@echo "Sve simulacije završene. VCD datoteke u $(BUILD)/*/."

clean:
	rm -rf $(BUILD)

docker-build:
	docker build -t $(IMAGE) .

docker-sim:
	docker run --rm -v "$(PWD):/workspace" -w /workspace $(IMAGE) make sim
