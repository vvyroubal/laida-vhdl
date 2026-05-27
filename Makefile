IMAGE := laida-sim
BUILD := build
STOPTIME := 10us

.PHONY: sim clean docker-build docker-sim

sim:
	@echo "[02] binary_to_gray"
	@mkdir -p $(BUILD)/02 && cd $(BUILD)/02 && \
	  ghdl -a ../../02/binary_to_gray.vhd ../../02/tb_binary_to_gray.vhd && \
	  ghdl -e tb_binary_to_gray && \
	  ghdl -r tb_binary_to_gray --vcd=tb_binary_to_gray.vcd --stop-time=$(STOPTIME)

	@echo "[03] logic_function"
	@mkdir -p $(BUILD)/03 && cd $(BUILD)/03 && \
	  ghdl -a ../../03/logic_function.vhd ../../03/tb_logic_function.vhd && \
	  ghdl -e tb_logic_function && \
	  ghdl -r tb_logic_function --vcd=tb_logic_function.vcd --stop-time=$(STOPTIME)

	@echo "[03] majority"
	@mkdir -p $(BUILD)/03 && cd $(BUILD)/03 && \
	  ghdl -a ../../03/majority.vhd ../../03/tb_majority.vhd && \
	  ghdl -e tb_majority && \
	  ghdl -r tb_majority --vcd=tb_majority.vcd --stop-time=$(STOPTIME)

	@echo "[04] minimized_function"
	@mkdir -p $(BUILD)/04 && cd $(BUILD)/04 && \
	  ghdl -a ../../04/minimized_function.vhd ../../04/tb_minimized_function.vhd && \
	  ghdl -e tb_minimized_function && \
	  ghdl -r tb_minimized_function --vcd=tb_minimized_function.vcd --stop-time=$(STOPTIME)

	@echo "[06] full_adder"
	@mkdir -p $(BUILD)/06 && cd $(BUILD)/06 && \
	  ghdl -a ../../06/full_adder.vhd ../../06/tb_full_adder.vhd && \
	  ghdl -e tb_full_adder && \
	  ghdl -r tb_full_adder --vcd=tb_full_adder.vcd --stop-time=$(STOPTIME)

	@echo "[07] sr_latch"
	@mkdir -p $(BUILD)/07/sr_latch && cd $(BUILD)/07/sr_latch && \
	  ghdl -a ../../../07/sr_latch.vhd ../../../07/tb_sr_latch.vhd && \
	  ghdl -e tb_sr_latch && \
	  ghdl -r tb_sr_latch --vcd=tb_sr_latch.vcd --stop-time=$(STOPTIME)

	@echo "[07] sr_ff"
	@mkdir -p $(BUILD)/07/sr_ff && cd $(BUILD)/07/sr_ff && \
	  ghdl -a ../../../07/sr_ff.vhd ../../../07/tb_sr_ff.vhd && \
	  ghdl -e tb_sr_ff && \
	  ghdl -r tb_sr_ff --vcd=tb_sr_ff.vcd --stop-time=$(STOPTIME)

	@echo "[07] d_ff"
	@mkdir -p $(BUILD)/07/d_ff && cd $(BUILD)/07/d_ff && \
	  ghdl -a ../../../07/d_ff.vhd ../../../07/tb_d_ff.vhd && \
	  ghdl -e tb_d_ff && \
	  ghdl -r tb_d_ff --vcd=tb_d_ff.vcd --stop-time=$(STOPTIME)

	@echo "[07] d_ff_rst"
	@mkdir -p $(BUILD)/07/d_ff_rst && cd $(BUILD)/07/d_ff_rst && \
	  ghdl -a ../../../07/d_ff_rst.vhd ../../../07/tb_d_ff_rst.vhd && \
	  ghdl -e tb_d_ff_rst && \
	  ghdl -r tb_d_ff_rst --vcd=tb_d_ff_rst.vcd --stop-time=$(STOPTIME)

	@echo "[07] jk_ff"
	@mkdir -p $(BUILD)/07/jk_ff && cd $(BUILD)/07/jk_ff && \
	  ghdl -a ../../../07/jk_ff.vhd ../../../07/tb_jk_ff.vhd && \
	  ghdl -e tb_jk_ff && \
	  ghdl -r tb_jk_ff --vcd=tb_jk_ff.vcd --stop-time=$(STOPTIME)

	@echo "[07] t_ff"
	@mkdir -p $(BUILD)/07/t_ff && cd $(BUILD)/07/t_ff && \
	  ghdl -a ../../../07/t_ff.vhd ../../../07/tb_t_ff.vhd && \
	  ghdl -e tb_t_ff && \
	  ghdl -r tb_t_ff --vcd=tb_t_ff.vcd --stop-time=$(STOPTIME)

	@echo "[08] sequence_detector"
	@mkdir -p $(BUILD)/08 && cd $(BUILD)/08 && \
	  ghdl -a ../../08/sequence_detector.vhd ../../08/tb_sequence_detector.vhd && \
	  ghdl -e tb_sequence_detector && \
	  ghdl -r tb_sequence_detector --vcd=tb_sequence_detector.vcd --stop-time=$(STOPTIME)

	@echo "[09] binary_counter"
	@mkdir -p $(BUILD)/09/binary_counter && cd $(BUILD)/09/binary_counter && \
	  ghdl -a ../../../09/binary_counter.vhd ../../../09/tb_binary_counter.vhd && \
	  ghdl -e tb_binary_counter && \
	  ghdl -r tb_binary_counter --vcd=tb_binary_counter.vcd --stop-time=$(STOPTIME)

	@echo "[09] async_binary_counter"
	@mkdir -p $(BUILD)/09/async_binary_counter && cd $(BUILD)/09/async_binary_counter && \
	  ghdl -a ../../../09/async_binary_counter.vhd ../../../09/tb_async_binary_counter.vhd && \
	  ghdl -e tb_async_binary_counter && \
	  ghdl -r tb_async_binary_counter --vcd=tb_async_binary_counter.vcd --stop-time=$(STOPTIME)

	@echo "[09] ring_counter"
	@mkdir -p $(BUILD)/09/ring_counter && cd $(BUILD)/09/ring_counter && \
	  ghdl -a ../../../09/ring_counter.vhd ../../../09/tb_ring_counter.vhd && \
	  ghdl -e tb_ring_counter && \
	  ghdl -r tb_ring_counter --vcd=tb_ring_counter.vcd --stop-time=$(STOPTIME)

	@echo "[09] johnson_counter"
	@mkdir -p $(BUILD)/09/johnson_counter && cd $(BUILD)/09/johnson_counter && \
	  ghdl -a ../../../09/johnson_counter.vhd ../../../09/tb_johnson_counter.vhd && \
	  ghdl -e tb_johnson_counter && \
	  ghdl -r tb_johnson_counter --vcd=tb_johnson_counter.vcd --stop-time=$(STOPTIME)

	@echo "[09] modulo_counter"
	@mkdir -p $(BUILD)/09/modulo_counter && cd $(BUILD)/09/modulo_counter && \
	  ghdl -a ../../../09/modulo_counter.vhd ../../../09/tb_modulo_counter.vhd && \
	  ghdl -e tb_modulo_counter && \
	  ghdl -r tb_modulo_counter --vcd=tb_modulo_counter.vcd --stop-time=$(STOPTIME)

	@echo "[09] seq_gen"
	@mkdir -p $(BUILD)/09/seq_gen && cd $(BUILD)/09/seq_gen && \
	  ghdl -a ../../../09/seq_gen.vhd ../../../09/tb_seq_gen.vhd && \
	  ghdl -e tb_seq_gen && \
	  ghdl -r tb_seq_gen --vcd=tb_seq_gen.vcd --stop-time=$(STOPTIME)

	@echo "Sve simulacije završene. VCD datoteke u $(BUILD)/*/."

clean:
	rm -rf $(BUILD)

docker-build:
	docker build -t $(IMAGE) .

docker-sim:
	docker run --rm -v "$(PWD):/workspace" -w /workspace $(IMAGE) make sim
