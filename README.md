# 📘 D Flip-Flop (Positive Edge Triggered) – Verilog

## 🔹 Overview

This project implements a **positive edge-triggered D Flip-Flop (DFF)** in Verilog along with a **self-checking testbench**.

A D Flip-Flop stores the input value (`D`) at the **rising edge of the clock** and holds it until the next clock event.

---

## 🔹 Features

* Positive edge-triggered operation
* Complement output (`Qbar_o`)
* Non-blocking assignment for sequential logic
* Self-checking testbench
* Clock generation included
* Functional verification using expected values

---

## 🔹 Module Description

### 📌 Inputs

* `D_i` → Data input
* `clk_i` → Clock input

### 📌 Outputs

* `Q_o` → Stored output
* `Qbar_o` → Complement of output

---

## 🔹 Working Principle

### 🔸 Flip-Flop Operation

* On **posedge of clock**:

  ```
  Q_o <= D_i
  ```
* At all other times:

  ```
  Q_o holds previous value
  ```

### 🔸 Complement Output

```
Qbar_o = ~Q_o
```

---

## 🔹 Timing Behavior

| Clock Edge | D Input | Q Output             |
| ---------- | ------- | -------------------- |
| Rising ↑   | 0       | 0                    |
| Rising ↑   | 1       | 1                    |
| No edge    | X       | Holds previous value |

---

## 🔹 Design Details

### 🔸 Sequential Logic

```id="dff_seq"
always @(posedge clk_i)
   Q_o <= D_i;
```

* Uses **non-blocking assignment (`<=`)**
* Ensures proper sequential behavior

---

## 🔹 Testbench Details

The testbench (`tb_Dff`) verifies correct operation using:

### 🔸 Components

* Clock generator (`repeat` loop)
* Input stimulus with different timing cases
* Self-checking mechanism
* Output monitoring

---

## 🔹 Verification Strategy

### 🔸 Expected Value Tracking

* `D_pre` stores value of `D` at clock edge:

  ```
  always @(posedge clk_ti)
     D_pre <= D_ti;
  ```

### 🔸 Self-Checking Task

* Compares:

  * Expected (`D_pre`)
  * Actual (`Q_to`)

---

## 🔹 Important Observation ⚠️

> Current testbench may show mismatches because:

* `check()` is not strictly synchronized with clock edges
* Verification should ideally occur **right after posedge clock**

### ✔️ Recommended Fix

* Call `check()` only after `posedge clk_ti`
* Or use event-based checking:

```verilog id="dff_fix"
@(posedge clk_ti);
#1 check();
```

---

## 🔹 Simulation

### ▶️ Tools

* ModelSim / QuestaSim
* Xilinx Vivado
* Icarus Verilog + GTKWave

### ▶️ Run (Icarus Verilog Example)

```bash id="dff_run"
iverilog -o Dff.vvp Dff.v tb_Dff.v
vvp Dff.vvp
gtkwave Dff.vcd
```

---

## 🔹 Output

* Console output using `$monitor`
* Error messages for mismatches
* Final statistics:

  ```
  Checks: X | Pass: Y | Fail: Z
  ```
* Waveform dump file:

  ```
  Dff.vcd
  ```

---

## 🔹 Sample Output Format

```id="dff_sample"
Time: 10 | D: 1, Clock: 1 | Q: 1, Qn: 0
```

---

## 🔹 Applications

* Registers and memory elements
* Data synchronization circuits
* Shift registers
* Sequential digital systems

---

## 🔹 Design Insights

* Use **non-blocking assignments** in sequential logic
* Always align testbench checks with clock edges
* Flip-flops are fundamental building blocks in digital design

---

## 🔹 File Structure

```id="dff_struct"
├── Dff.v          # D Flip-Flop Design
├── tb_Dff.v       # Testbench
├── Dff.vcd        # Waveform output (generated)
└── README.txt     # Documentation
```
