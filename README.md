# MIPS Pipeline Processor

A complete 5-stage pipelined MIPS processor implementation in Verilog, designed to efficiently execute MIPS instruction set architecture (ISA) operations with hazard detection and forwarding mechanisms.

## Overview

This project implements a fully functional MIPS processor with a classic 5-stage pipeline architecture:
1. **Instruction Fetch (IF)** - Retrieves instructions from instruction memory
2. **Instruction Decode (ID)** - Decodes instruction and reads register values
3. **Execute (EX)** - Performs arithmetic and logic operations
4. **Memory (MEM)** - Accesses data memory for load/store operations
5. **Write Back (WB)** - Writes results back to registers

The processor includes sophisticated hazard resolution mechanisms to handle data dependencies and control flow changes.

## Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                    MIPS 5-Stage Pipeline                    │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐           │
│  │  IF  │──│  ID  │──│  EX  │──│ MEM  │──│  WB  │           │
│  └──────┘  └──────┘  └──────┘  └──────┘  └──────┘           │
│     │        │        │        │        │                    │
│     │        └────────┼────────┼────────┤ Forwarding Unit   │
│     │                 │        │                             │
│     └─────────────────┼────────┤ Branch Forwarding           │
│                       │                                      │
│            Hazard Detection & Stalling                       │
│                                                               │
└─────────────────────────────────────────────────────────────┘
```

## Key Components

### Core Pipeline Stages

| Component | File | Function |
|-----------|------|----------|
| **Program Counter** | `pc.v` | Manages instruction address and handles jumps/branches |
| **Instruction Memory** | `Instruction_memory.v` | Stores and retrieves MIPS instructions |
| **Register File** | `registermem.v` | Manages 32 general-purpose registers (MIPS $0-$31) |
| **ALU** | `ALU.v` | Performs arithmetic and logical operations |
| **Data Memory** | `Datamem.v` | Stores and retrieves data for load/store operations |

### Pipeline Registers

| Register | File | Purpose |
|----------|------|---------|
| **IF/ID** | `IF_ID.v` | Holds instruction and address between IF and ID stages |
| **ID/EX** | `ID_EX.v` | Carries decoded instruction data and control signals |
| **EX/MEM** | `EX_MEM.v` | Passes ALU results and memory control signals |
| **MEM/WB** | `MEM_WB.v` | Holds data destined for register writeback |

### Hazard Resolution

| Component | File | Purpose |
|-----------|------|---------|
| **Hazard Detection Unit** | `hazar_detection_unit.v` | Detects data and control hazards, triggers pipeline stalls |
| **Forwarding Unit** | `forwarding_unit.v` | Resolves data hazards by forwarding ALU results |
| **Branch Forwarding Unit** | `Branch_forwarding_unit.v` | Handles branch condition early determination |
| **Store Forwarding Unit** | `SW_fowarding_unit.v` | Manages memory write dependencies |
| **Branch Comparator** | `Branch_comparator.v` | Determines branch outcomes early |

### Control Logic

| Component | File | Purpose |
|-----------|------|---------|
| **Control Unit** | `Controlunit.v` | Generates control signals based on opcode |
| **ALU Control** | `Alu_control.v` | Determines ALU operation from control signals and function field |

### Integration

| File | Purpose |
|------|---------|
| **Integration.v** | Top-level module connecting all components |
| **integration.bit** | FPGA bitstream for hardware deployment |

## Supported Instructions

The processor implements the following MIPS instruction types:

### R-Type Instructions
- `ADD`, `SUB`, `AND`, `OR`, `XOR` (Opcode: 000001)
- `SLT` (Set Less Than) - Opcode: 111000
- `SLL` (Shift Left Logical) - Opcode: 111010

### I-Type Instructions
- `LW` (Load Word) - Opcode: 100011
- `SW` (Store Word) - Opcode: 101011
- `BEQ` (Branch if Equal) - Opcode: 000100
- `ADDI` (Add Immediate) - Opcode: 101000

### J-Type Instructions
- `JUMP` - Opcode: 001100

## Hazard Handling

### Data Hazards
The processor uses two complementary mechanisms:

1. **Forwarding**: Passes ALU results directly to dependent instructions, avoiding stalls
2. **Stalling**: When forwarding is insufficient (e.g., load-use hazards), the pipeline stalls until data is available

### Control Hazards
Branch outcomes are determined in the EX stage through early comparison, minimizing pipeline flushes. The processor supports both taken and not-taken branch predictions.

## Control Signals

| Signal | Function |
|--------|----------|
| `reg_dst` | Selects register destination (rd or rt) |
| `reg_write` | Enables register file write |
| `alu_src` | Selects ALU source (register or immediate) |
| `mem_read` | Enables data memory read |
| `mem_write` | Enables data memory write |
| `mem_to_reg` | Routes data back to registers (ALU or memory) |
| `pc_src` | Selects PC source (next instruction, branch, or jump) |
| `jump` | Indicates jump instruction |
| `branch` | Indicates branch instruction |
| `alu_op[2:0]` | Specifies ALU operation |

## Getting Started

### Prerequisites
- Verilog simulator (ModelSim, IcarusVerilog, or similar)
- FPGA tools (Xilinx ISE/Vivado) for hardware deployment

### Simulation
1. Load all `.v` files into your simulator
2. Use `Integration.v` as the top-level module
3. Apply clock pulses to simulate instruction execution
4. Monitor `pc_out` (program counter) and `instruction` (fetched instruction) outputs

### Hardware Deployment
1. Use the provided `integration.bit` bitstream to program your FPGA
2. Modify instruction memory contents to load custom MIPS programs
3. Monitor outputs on connected displays or logic analyzer

## System Signals

```
Input:
  clk          - System clock
  rst          - Active-high reset
  forwarding   - Enable/disable forwarding mechanism
  stalling     - Enable/disable stall insertion

Output:
  pc_out[31:0]     - Current program counter value
  instruction[31:0] - Currently fetched instruction
```

## Features

- **5-Stage Pipeline Architecture**: Maximizes throughput for instruction-level parallelism
- **Advanced Hazard Detection**: Automatically detects and resolves data and control dependencies
- **Dynamic Forwarding**: Eliminates unnecessary stalls through result forwarding
- **Branch Optimization**: Early branch condition evaluation in EX stage
- **Configurable Hazard Handling**: Toggle forwarding and stalling mechanisms for comparison
- **FPGA Deployable**: Includes bitstream for hardware implementation

## File Structure

```
Mips-pipeline-processor/
├── Integration.v                 (Top-level module)
├── pc.v                          (Program counter)
├── Instruction_memory.v          (Instruction ROM)
├── IF_ID.v                       (Pipeline register)
├── Controlunit.v                 (Control logic)
├── registermem.v                 (Register file)
├── ID_EX.v                       (Pipeline register)
├── Alu_control.v                 (ALU control)
├── ALU.v                         (Arithmetic logic unit)
├── EX_MEM.v                      (Pipeline register)
├── Datamem.v                     (Data memory)
├── Branch_forwarding_unit.v      (Branch hazard resolution)
├── forwarding_unit.v             (Data forwarding)
├── SW_fowarding_unit.v           (Store forwarding)
├── Branch_comparator.v           (Branch condition evaluation)
├── hazar_detection_unit.v        (Hazard detection)
├── MEM_WB.v                      (Pipeline register)
└── integration.bit               (FPGA bitstream)
```

## Design Considerations

- **Pipeline Depth**: 5 stages optimizes frequency and throughput for typical MIPS programs
- **Hazard Resolution**: Combination of forwarding and stalling handles most common scenarios
- **Clock Speed**: Designed for standard FPGA clock frequencies (100+ MHz)
- **Memory Size**: Easily configurable for different instruction/data memory depths

## Future Enhancements
- Multi-cycle operations support
- Exception handling
- Cache memory integration
- Performance monitoring counters
- Branch prediction unit

## License

This project is open source and available for educational and research purposes.

## Author

Ameer Hamza (@ameerhamza929)