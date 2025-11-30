# 🧠 FIFO 8x8 Synchronous Buffer – Verilog Design & Testbench

This repository contains my implementation and verification of a **Synchronous FIFO (8x8)** using **Verilog**.  
The FIFO supports **full/empty/half-full/almost-full/almost-empty** status flags and includes a complete testbench for functional verification.

---

## 🔧 Key Features

### ✅ FIFO Specifications
- Depth: **8 entries**
- Data width: **8 bits**
- Synchronous FIFO (single clock)
- Supports:
  - **Write Enable (wr_en)**
  - **Read Enable (rd_en)**
  - **Full / Empty flags**
  - **Half Full**
  - **Almost Full**
  - **Almost Empty**
- Circular buffer implementation using pointers

### 🧪 Testbench Highlights
- Clock generator (20ns period)
- Reset logic
- Automatic **write phase**, filling FIFO with random data
- Automatic **read phase**, emptying FIFO
- `$monitor()` to print live FIFO status
- Waveform dump using `$dumpfile` + `$dumpvars`
- Displays write, read, pointer updates, flags, and internal count

---

