Spring Cloud Gateway Benchmark
=======

TL;DR

Proxy | Avg Latency | Avg Req/Sec/Thread | Total Req/Sec
-- | -- | -- | --
gateway | 2.24ms | 9.60k | 95,210.52
envoy | 1.78ms | 12.66k | 125,956.64
linkered | 2.96ms | 8.20k | 81,624.88
zuul | 9.46ms | 2.66k | 26,416.49
none | 1.48ms | 27.34k | 271,890.67

## Terminal 1 (simple webserver)

```bash
cd static
./webserver # or ./webserver.darwin-amd64 on a mac
```

## Terminal 2 (zuul)
```bash
cd zuul
./mvnw clean package
java -jar target/zuul-0.0.1-SNAPSHOT.jar 
```

## Terminal 3 (gateway)
```bash
cd gateway
./mvnw clean package
java -jar target/gateway-0.0.1-SNAPSHOT.jar 
```

## Terminal 4 (linkerd)
```bash
cd linkerd
java -jar linkerd-1.3.4.jar linkerd.yaml
```

## Terminal 5 (envoy)
```bash
cd envoy

envoy --version
# envoy  version: d362e791eb9e4efa8d87f6d878740e72dc8330ac/1.18.2/clean-getenvoy-76c310e-envoy/RELEASE/BoringSSL

envoy -c envoy.yaml
```


## Terminal N (wrk)

### install `wrk`
Ubuntu: `sudo apt install wrk`

Mac: `brew install wrk`

NOTE: run each one multiple times to warm up jvm


#### Hardware Reference

```
sudo dmidecode 
# dmidecode 3.2
Getting SMBIOS data from sysfs.
SMBIOS 2.8 present.
64 structures occupying 2705 bytes.
Table at 0xCDC0B000.

Handle 0x0000, DMI type 0, 26 bytes
BIOS Information
  Vendor: American Megatrends Inc.
  Version: 2.30
  Release Date: 08/31/2020
  Address: 0xF0000
  Runtime Size: 64 kB
  ROM Size: 32 MB
  Characteristics:
    PCI is supported
    BIOS is upgradeable
    BIOS shadowing is allowed
    Boot from CD is supported
    Selectable boot is supported
    BIOS ROM is socketed
    EDD is supported
    5.25"/1.2 MB floppy services are supported (int 13h)
    3.5"/720 kB floppy services are supported (int 13h)
    3.5"/2.88 MB floppy services are supported (int 13h)
    Print screen service is supported (int 5h)
    8042 keyboard services are supported (int 9h)
    Serial services are supported (int 14h)
    Printer services are supported (int 17h)
    ACPI is supported
    USB legacy is supported
    BIOS boot specification is supported
    Targeted content distribution is supported
    UEFI is supported
  BIOS Revision: 5.17

Handle 0x0001, DMI type 1, 27 bytes
System Information
  Manufacturer: Micro-Star International Co., Ltd.
  Product Name: MS-7C95
  Version: 1.0
  Serial Number: To be filled by O.E.M.
  UUID: 0a019e0b-a34a-e718-a14d-2cf05d97029b
  Wake-up Type: Power Switch
  SKU Number: To be filled by O.E.M.
  Family: To be filled by O.E.M.

Handle 0x0002, DMI type 2, 15 bytes
Base Board Information
  Manufacturer: Micro-Star International Co., Ltd.
  Product Name: B550M PRO-VDH WIFI (MS-7C95)
  Version: 1.0
  Serial Number: 07C9511_K81E683679
  Asset Tag: To be filled by O.E.M.
  Features:
    Board is a hosting board
    Board is replaceable
  Location In Chassis: To be filled by O.E.M.
  Chassis Handle: 0x0003
  Type: Motherboard
  Contained Object Handles: 0

Handle 0x0003, DMI type 3, 22 bytes
Chassis Information
  Manufacturer: Micro-Star International Co., Ltd.
  Type: Desktop
  Lock: Not Present
  Version: 1.0
  Serial Number: To be filled by O.E.M.
  Asset Tag: To be filled by O.E.M.
  Boot-up State: Safe
  Power Supply State: Safe
  Thermal State: Safe
  Security Status: None
  OEM Information: 0x00000000
  Height: Unspecified
  Number Of Power Cords: 1
  Contained Elements: 0
  SKU Number: To be filled by O.E.M.

Handle 0x0004, DMI type 9, 17 bytes
System Slot Information
  Designation: J6B2
  Type: x16 PCI Express
  Current Usage: In Use
  Length: Long
  ID: 0
  Characteristics:
    3.3 V is provided
    Opening is shared
    PME signal is supported
  Bus Address: 0000:00:01.0

Handle 0x0005, DMI type 9, 17 bytes
System Slot Information
  Designation: J6B1
  Type: x1 PCI Express
  Current Usage: In Use
  Length: Short
  ID: 1
  Characteristics:
    3.3 V is provided
    Opening is shared
    PME signal is supported
  Bus Address: 0000:00:1c.3

Handle 0x0006, DMI type 9, 17 bytes
System Slot Information
  Designation: J6D1
  Type: x1 PCI Express
  Current Usage: In Use
  Length: Short
  ID: 2
  Characteristics:
    3.3 V is provided
    Opening is shared
    PME signal is supported
  Bus Address: 0000:00:1c.4

Handle 0x0007, DMI type 9, 17 bytes
System Slot Information
  Designation: J7B1
  Type: x1 PCI Express
  Current Usage: In Use
  Length: Short
  ID: 3
  Characteristics:
    3.3 V is provided
    Opening is shared
    PME signal is supported
  Bus Address: 0000:00:1c.5

Handle 0x0008, DMI type 9, 17 bytes
System Slot Information
  Designation: J8B4
  Type: x1 PCI Express
  Current Usage: In Use
  Length: Short
  ID: 4
  Characteristics:
    3.3 V is provided
    Opening is shared
    PME signal is supported
  Bus Address: 0000:00:1c.6

Handle 0x0009, DMI type 9, 17 bytes
System Slot Information
  Designation: J8D1
  Type: x1 PCI Express
  Current Usage: In Use
  Length: Short
  ID: 5
  Characteristics:
    3.3 V is provided
    Opening is shared
    PME signal is supported
  Bus Address: 0000:00:1c.7

Handle 0x000A, DMI type 9, 17 bytes
System Slot Information
  Designation: J8B3
  Type: 32-bit PCI
  Current Usage: In Use
  Length: Short
  ID: 6
  Characteristics:
    3.3 V is provided
    Opening is shared
    PME signal is supported
  Bus Address: 0000:00:1e.0

Handle 0x000B, DMI type 11, 5 bytes
OEM Strings
  String 1: To be filled by O.E.M.

Handle 0x000C, DMI type 12, 5 bytes
System Configuration Options
  Option 1: To be filled by O.E.M.

Handle 0x000D, DMI type 32, 20 bytes
System Boot Information
  Status: No errors detected

Handle 0x000E, DMI type 18, 23 bytes
32-bit Memory Error Information
  Type: OK
  Granularity: Unknown
  Operation: Unknown
  Vendor Syndrome: Unknown
  Memory Array Address: Unknown
  Device Address: Unknown
  Resolution: Unknown

Handle 0x000F, DMI type 16, 23 bytes
Physical Memory Array
  Location: System Board Or Motherboard
  Use: System Memory
  Error Correction Type: None
  Maximum Capacity: 128 GB
  Error Information Handle: 0x000E
  Number Of Devices: 4

Handle 0x0010, DMI type 19, 31 bytes
Memory Array Mapped Address
  Starting Address: 0x00000000000
  Ending Address: 0x000CFFFFFFF
  Range Size: 3328 MB
  Physical Array Handle: 0x000F
  Partition Width: 4

Handle 0x0011, DMI type 19, 31 bytes
Memory Array Mapped Address
  Starting Address: 0x00100000000
  Ending Address: 0x0202FFFFFFF
  Range Size: 127744 MB
  Physical Array Handle: 0x000F
  Partition Width: 4

Handle 0x0012, DMI type 7, 19 bytes
Cache Information
  Socket Designation: L1 - Cache
  Configuration: Enabled, Not Socketed, Level 1
  Operational Mode: Write Back
  Location: Internal
  Installed Size: 768 kB
  Maximum Size: 768 kB
  Supported SRAM Types:
    Pipeline Burst
  Installed SRAM Type: Pipeline Burst
  Speed: 1 ns
  Error Correction Type: Multi-bit ECC
  System Type: Unified
  Associativity: 8-way Set-associative

Handle 0x0013, DMI type 7, 19 bytes
Cache Information
  Socket Designation: L2 - Cache
  Configuration: Enabled, Not Socketed, Level 2
  Operational Mode: Write Back
  Location: Internal
  Installed Size: 6144 kB
  Maximum Size: 6144 kB
  Supported SRAM Types:
    Pipeline Burst
  Installed SRAM Type: Pipeline Burst
  Speed: 1 ns
  Error Correction Type: Multi-bit ECC
  System Type: Unified
  Associativity: 8-way Set-associative

Handle 0x0014, DMI type 7, 19 bytes
Cache Information
  Socket Designation: L3 - Cache
  Configuration: Enabled, Not Socketed, Level 3
  Operational Mode: Write Back
  Location: Internal
  Installed Size: 65536 kB
  Maximum Size: 65536 kB
  Supported SRAM Types:
    Pipeline Burst
  Installed SRAM Type: Pipeline Burst
  Speed: 1 ns
  Error Correction Type: Multi-bit ECC
  System Type: Unified
  Associativity: 16-way Set-associative

Handle 0x0015, DMI type 4, 48 bytes
Processor Information
  Socket Designation: AM4
  Type: Central Processor
  Family: Zen
  Manufacturer: Advanced Micro Devices, Inc.
  ID: 10 0F 87 00 FF FB 8B 17
  Signature: Family 23, Model 113, Stepping 0
  Flags:
    FPU (Floating-point unit on-chip)
    VME (Virtual mode extension)
    DE (Debugging extension)
    PSE (Page size extension)
    TSC (Time stamp counter)
    MSR (Model specific registers)
    PAE (Physical address extension)
    MCE (Machine check exception)
    CX8 (CMPXCHG8 instruction supported)
    APIC (On-chip APIC hardware supported)
    SEP (Fast system call)
    MTRR (Memory type range registers)
    PGE (Page global enable)
    MCA (Machine check architecture)
    CMOV (Conditional move instruction supported)
    PAT (Page attribute table)
    PSE-36 (36-bit page size extension)
    CLFSH (CLFLUSH instruction supported)
    MMX (MMX technology supported)
    FXSR (FXSAVE and FXSTOR instructions supported)
    SSE (Streaming SIMD extensions)
    SSE2 (Streaming SIMD extensions 2)
    HTT (Multi-threading)
  Version: AMD Ryzen 9 3900XT 12-Core Processor           
  Voltage: 1.1 V
  External Clock: 100 MHz
  Max Speed: 4775 MHz
  Current Speed: 3800 MHz
  Status: Populated, Enabled
  Upgrade: Socket AM4
  L1 Cache Handle: 0x0012
  L2 Cache Handle: 0x0013
  L3 Cache Handle: 0x0014
  Serial Number: Unknown
  Asset Tag: Unknown
  Part Number: Unknown
  Core Count: 12
  Core Enabled: 12
  Thread Count: 24
  Characteristics:
    64-bit capable
    Multi-Core
    Hardware Thread
    Execute Protection
    Enhanced Virtualization
    Power/Performance Control

Handle 0x0016, DMI type 18, 23 bytes
32-bit Memory Error Information
  Type: OK
  Granularity: Unknown
  Operation: Unknown
  Vendor Syndrome: Unknown
  Memory Array Address: Unknown
  Device Address: Unknown
  Resolution: Unknown

Handle 0x0017, DMI type 17, 40 bytes
Memory Device
  Array Handle: 0x000F
  Error Information Handle: 0x0016
  Total Width: 64 bits
  Data Width: 64 bits
  Size: 32 GB
  Form Factor: DIMM
  Set: None
  Locator: DIMM 0
  Bank Locator: P0 CHANNEL A
  Type: DDR4
  Type Detail: Synchronous Unbuffered (Unregistered)
  Speed: 3200 MT/s
  Manufacturer: Unknown
  Serial Number: 00000000
  Asset Tag: Not Specified
  Part Number: CMK64GX4M2E3200C16
  Rank: 2
  Configured Memory Speed: 3200 MT/s
  Minimum Voltage: 1.2 V
  Maximum Voltage: 1.2 V
  Configured Voltage: 1.2 V

Handle 0x0018, DMI type 20, 35 bytes
Memory Device Mapped Address
  Starting Address: 0x00000000000
  Ending Address: 0x01FFFFFFFFF
  Range Size: 128 GB
  Physical Device Handle: 0x0017
  Memory Array Mapped Address Handle: 0x0011
  Partition Row Position: Unknown
  Interleave Position: Unknown
  Interleaved Data Depth: Unknown

Handle 0x0019, DMI type 18, 23 bytes
32-bit Memory Error Information
  Type: OK
  Granularity: Unknown
  Operation: Unknown
  Vendor Syndrome: Unknown
  Memory Array Address: Unknown
  Device Address: Unknown
  Resolution: Unknown

Handle 0x001A, DMI type 17, 40 bytes
Memory Device
  Array Handle: 0x000F
  Error Information Handle: 0x0019
  Total Width: 64 bits
  Data Width: 64 bits
  Size: 32 GB
  Form Factor: DIMM
  Set: None
  Locator: DIMM 1
  Bank Locator: P0 CHANNEL A
  Type: DDR4
  Type Detail: Synchronous Unbuffered (Unregistered)
  Speed: 3200 MT/s
  Manufacturer: Unknown
  Serial Number: 00000000
  Asset Tag: Not Specified
  Part Number: CMK64GX4M2E3200C16
  Rank: 2
  Configured Memory Speed: 3200 MT/s
  Minimum Voltage: 1.2 V
  Maximum Voltage: 1.2 V
  Configured Voltage: 1.2 V

Handle 0x001B, DMI type 20, 35 bytes
Memory Device Mapped Address
  Starting Address: 0x00000000000
  Ending Address: 0x01FFFFFFFFF
  Range Size: 128 GB
  Physical Device Handle: 0x001A
  Memory Array Mapped Address Handle: 0x0011
  Partition Row Position: Unknown
  Interleave Position: Unknown
  Interleaved Data Depth: Unknown

Handle 0x001C, DMI type 18, 23 bytes
32-bit Memory Error Information
  Type: OK
  Granularity: Unknown
  Operation: Unknown
  Vendor Syndrome: Unknown
  Memory Array Address: Unknown
  Device Address: Unknown
  Resolution: Unknown

Handle 0x001D, DMI type 17, 40 bytes
Memory Device
  Array Handle: 0x000F
  Error Information Handle: 0x001C
  Total Width: 64 bits
  Data Width: 64 bits
  Size: 32 GB
  Form Factor: DIMM
  Set: None
  Locator: DIMM 0
  Bank Locator: P0 CHANNEL B
  Type: DDR4
  Type Detail: Synchronous Unbuffered (Unregistered)
  Speed: 3200 MT/s
  Manufacturer: Unknown
  Serial Number: 00000000
  Asset Tag: Not Specified
  Part Number: CMK64GX4M2E3200C16
  Rank: 2
  Configured Memory Speed: 3200 MT/s
  Minimum Voltage: 1.2 V
  Maximum Voltage: 1.2 V
  Configured Voltage: 1.2 V

Handle 0x001E, DMI type 20, 35 bytes
Memory Device Mapped Address
  Starting Address: 0x00000000000
  Ending Address: 0x01FFFFFFFFF
  Range Size: 128 GB
  Physical Device Handle: 0x001D
  Memory Array Mapped Address Handle: 0x0011
  Partition Row Position: Unknown
  Interleave Position: Unknown
  Interleaved Data Depth: Unknown

Handle 0x001F, DMI type 18, 23 bytes
32-bit Memory Error Information
  Type: OK
  Granularity: Unknown
  Operation: Unknown
  Vendor Syndrome: Unknown
  Memory Array Address: Unknown
  Device Address: Unknown
  Resolution: Unknown

Handle 0x0020, DMI type 17, 40 bytes
Memory Device
  Array Handle: 0x000F
  Error Information Handle: 0x001F
  Total Width: 64 bits
  Data Width: 64 bits
  Size: 32 GB
  Form Factor: DIMM
  Set: None
  Locator: DIMM 1
  Bank Locator: P0 CHANNEL B
  Type: DDR4
  Type Detail: Synchronous Unbuffered (Unregistered)
  Speed: 3200 MT/s
  Manufacturer: Unknown
  Serial Number: 00000000
  Asset Tag: Not Specified
  Part Number: CMK64GX4M2E3200C16
  Rank: 2
  Configured Memory Speed: 3200 MT/s
  Minimum Voltage: 1.2 V
  Maximum Voltage: 1.2 V
  Configured Voltage: 1.2 V

Handle 0x0021, DMI type 20, 35 bytes
Memory Device Mapped Address
  Starting Address: 0x00000000000
  Ending Address: 0x01FFFFFFFFF
  Range Size: 128 GB
  Physical Device Handle: 0x0020
  Memory Array Mapped Address Handle: 0x0011
  Partition Row Position: Unknown
  Interleave Position: Unknown
  Interleaved Data Depth: Unknown

Handle 0x0022, DMI type 8, 9 bytes
Port Connector Information
  Internal Reference Designator: J1500
  Internal Connector Type: None
  External Reference Designator: USB 3.2
  External Connector Type: Access Bus (USB)
  Port Type: USB

Handle 0x0023, DMI type 8, 9 bytes
Port Connector Information
  Internal Reference Designator: J1501
  Internal Connector Type: None
  External Reference Designator: USB 3.2
  External Connector Type: Access Bus (USB)
  Port Type: USB

Handle 0x0024, DMI type 8, 9 bytes
Port Connector Information
  Internal Reference Designator: J1502
  Internal Connector Type: None
  External Reference Designator: USB-C
  External Connector Type: Access Bus (USB)
  Port Type: USB

Handle 0x0025, DMI type 8, 9 bytes
Port Connector Information
  Internal Reference Designator: J1506
  Internal Connector Type: None
  External Reference Designator: USB 3.2
  External Connector Type: Access Bus (USB)
  Port Type: USB

Handle 0x0026, DMI type 8, 9 bytes
Port Connector Information
  Internal Reference Designator: J1507
  Internal Connector Type: None
  External Reference Designator: USB 3.2
  External Connector Type: Access Bus (USB)
  Port Type: USB

Handle 0x0027, DMI type 8, 9 bytes
Port Connector Information
  Internal Reference Designator: J1301
  Internal Connector Type: None
  External Reference Designator: USB 3.2
  External Connector Type: Access Bus (USB)
  Port Type: USB

Handle 0x0028, DMI type 8, 9 bytes
Port Connector Information
  Internal Reference Designator: J1301
  Internal Connector Type: None
  External Reference Designator: Network
  External Connector Type: RJ-45
  Port Type: Network Port

Handle 0x0029, DMI type 8, 9 bytes
Port Connector Information
  Internal Reference Designator: J1704
  Internal Connector Type: SAS/SATA Plug Receptacle
  External Reference Designator: iSATA
  External Connector Type: None
  Port Type: SATA

Handle 0x002A, DMI type 8, 9 bytes
Port Connector Information
  Internal Reference Designator: J1705
  Internal Connector Type: SAS/SATA Plug Receptacle
  External Reference Designator: iSATA
  External Connector Type: None
  Port Type: SATA

Handle 0x002B, DMI type 8, 9 bytes
Port Connector Information
  Internal Reference Designator: J1700
  Internal Connector Type: SAS/SATA Plug Receptacle
  External Reference Designator: iSATA
  External Connector Type: None
  Port Type: SATA

Handle 0x002C, DMI type 8, 9 bytes
Port Connector Information
  Internal Reference Designator: J1702
  Internal Connector Type: SAS/SATA Plug Receptacle
  External Reference Designator: iSATA
  External Connector Type: None
  Port Type: SATA

Handle 0x002D, DMI type 8, 9 bytes
Port Connector Information
  Internal Reference Designator: J1703
  Internal Connector Type: SAS/SATA Plug Receptacle
  External Reference Designator: iSATA
  External Connector Type: None
  Port Type: SATA

Handle 0x002E, DMI type 8, 9 bytes
Port Connector Information
  Internal Reference Designator: J1706
  Internal Connector Type: SAS/SATA Plug Receptacle
  External Reference Designator: iSATA
  External Connector Type: None
  Port Type: SATA

Handle 0x002F, DMI type 8, 9 bytes
Port Connector Information
  Internal Reference Designator: J1100
  Internal Connector Type: None
  External Reference Designator: HDMI
  External Connector Type: None
  Port Type: Video Port

Handle 0x0030, DMI type 8, 9 bytes
Port Connector Information
  Internal Reference Designator: J1101
  Internal Connector Type: None
  External Reference Designator: HDMI
  External Connector Type: None
  Port Type: Video Port

Handle 0x0031, DMI type 8, 9 bytes
Port Connector Information
  Internal Reference Designator: J1102
  Internal Connector Type: None
  External Reference Designator: DP
  External Connector Type: None
  Port Type: Video Port

Handle 0x0032, DMI type 8, 9 bytes
Port Connector Information
  Internal Reference Designator: J2100
  Internal Connector Type: None
  External Reference Designator: Front Audio
  External Connector Type: Mini Jack (headphones)
  Port Type: Audio Port

Handle 0x0033, DMI type 8, 9 bytes
Port Connector Information
  Internal Reference Designator: J2101
  Internal Connector Type: None
  External Reference Designator: Audio Jack
  External Connector Type: Mini Jack (headphones)
  Port Type: Audio Port

Handle 0x0034, DMI type 8, 9 bytes
Port Connector Information
  Internal Reference Designator: J2102
  Internal Connector Type: None
  External Reference Designator: HD Audio HDR
  External Connector Type: Mini Jack (headphones)
  Port Type: Audio Port

Handle 0x0035, DMI type 9, 17 bytes
System Slot Information
  Designation: J10
  Type: x16 PCI Express x16
  Current Usage: In Use
  Length: Short
  ID: 12
  Characteristics:
    3.3 V is provided
    PME signal is supported
  Bus Address: 0000:00:03.1

Handle 0x0036, DMI type 9, 17 bytes
System Slot Information
  Designation: J3700 M.2 Slot
  Type: x1 PCI Express x1
  Current Usage: Available
  Length: Short
  ID: 14
  Characteristics:
    3.3 V is provided
    PME signal is supported
  Bus Address: 0000:00:1f.7

Handle 0x0037, DMI type 9, 17 bytes
System Slot Information
  Designation: J3708 PCIE x4 slot from Promontory
  Type: x4 PCI Express x4
  Current Usage: Available
  Length: Short
  ID: 128
  Characteristics:
    3.3 V is provided
    PME signal is supported
  Bus Address: 0000:00:1f.7

Handle 0x0038, DMI type 9, 17 bytes
System Slot Information
  Designation: J3703 PCIE x1 slot from Promontory
  Type: x1 PCI Express x1
  Current Usage: Available
  Length: Short
  ID: 134
  Characteristics:
    3.3 V is provided
    PME signal is supported
  Bus Address: 0000:00:1f.7

Handle 0x0039, DMI type 9, 17 bytes
System Slot Information
  Designation: J3702 PCIE x1 slot from Promontory
  Type: x1 PCI Express x1
  Current Usage: Available
  Length: Short
  ID: 135
  Characteristics:
    3.3 V is provided
    PME signal is supported
  Bus Address: 0000:00:1f.7

Handle 0x003A, DMI type 9, 17 bytes
System Slot Information
  Designation: J3707 PCIE x4 slot from Promontory
  Type: x4 PCI Express x4
  Current Usage: In Use
  Length: Short
  ID: 132
  Characteristics:
    3.3 V is provided
    PME signal is supported
  Bus Address: 0000:02:00.2

Handle 0x003B, DMI type 9, 17 bytes
System Slot Information
  Designation: J3701 M.2 WLAN/BT slot from Promontory
  Type: x1 PCI Express x1
  Current Usage: In Use
  Length: Short
  ID: 137
  Characteristics:
    3.3 V is provided
    PME signal is supported
  Bus Address: 0000:20:09.0

Handle 0x003C, DMI type 41, 11 bytes
Onboard Device
  Reference Designation: RTL8111E Giga LAN
  Type: Ethernet
  Status: Enabled
  Type Instance: 1
  Bus Address: 0000:29:00.0

Handle 0x003D, DMI type 41, 11 bytes
Onboard Device
  Reference Designation: Realtek ALC1220
  Type: Sound
  Status: Enabled
  Type Instance: 1
  Bus Address: 0000:2d:00.4

Handle 0x003E, DMI type 143, 16 bytes
OEM-specific Type
  Header and Data:
    8F 10 3E 00 00 01 02 03 04 05 06 07 08 09 0A 0B
  Strings:
    GOP1-[N/A]     
    RAID-14.8.0.1042
    PXEU1-v1.1.0.4
    AMI-AptioV
    GSES-5/3
    MsiFlash-18
    RavenPI-RAVEN_PI_VERSION
    N/A
    N/A
    N/A
    N/A
    N/A

Handle 0x003F, DMI type 127, 4 bytes
End Of Table

```