# nvmlc

## Features
1. latency matrix (excluding NUMA nodes) with default message size
2. bandwidth matrix (excluding NUMA nodes) with default message size
   - bandwidth between host and gpuA
   - bandwidth between gpuA and gpuA
   - bandwidth between gpuA and gpuB
<!-- 3. bandwidth at different r/w ratio
1. latency at different throughput conditions -->


## Compare
```bash
./p2pBandwidthLatencyTest

[P2P (Peer-to-Peer) GPU Bandwidth Latency Test]
Device: 0, NVIDIA A100-SXM4-80GB, pciBusID: 65, pciDeviceID: 1, pciDomainID:0
Device: 1, NVIDIA A100-SXM4-80GB, pciBusID: 65, pciDeviceID: 2, pciDomainID:0
Device: 2, NVIDIA A100-SXM4-80GB, pciBusID: 67, pciDeviceID: 1, pciDomainID:0
Device: 3, NVIDIA A100-SXM4-80GB, pciBusID: 67, pciDeviceID: 2, pciDomainID:0
Device: 4, NVIDIA A100-SXM4-80GB, pciBusID: 69, pciDeviceID: 1, pciDomainID:0
Device: 5, NVIDIA A100-SXM4-80GB, pciBusID: 69, pciDeviceID: 2, pciDomainID:0
Device: 6, NVIDIA A100-SXM4-80GB, pciBusID: 6b, pciDeviceID: 1, pciDomainID:0
Device: 7, NVIDIA A100-SXM4-80GB, pciBusID: 6b, pciDeviceID: 2, pciDomainID:0
Device=0 CAN Access Peer Device=1
Device=0 CAN Access Peer Device=2
Device=0 CAN Access Peer Device=3
Device=0 CAN Access Peer Device=4
Device=0 CAN Access Peer Device=5
Device=0 CAN Access Peer Device=6
Device=0 CAN Access Peer Device=7
Device=1 CAN Access Peer Device=0
Device=1 CAN Access Peer Device=2
Device=1 CAN Access Peer Device=3
Device=1 CAN Access Peer Device=4
Device=1 CAN Access Peer Device=5
Device=1 CAN Access Peer Device=6
Device=1 CAN Access Peer Device=7
Device=2 CAN Access Peer Device=0
Device=2 CAN Access Peer Device=1
Device=2 CAN Access Peer Device=3
Device=2 CAN Access Peer Device=4
Device=2 CAN Access Peer Device=5
Device=2 CAN Access Peer Device=6
Device=2 CAN Access Peer Device=7
Device=3 CAN Access Peer Device=0
Device=3 CAN Access Peer Device=1
Device=3 CAN Access Peer Device=2
Device=3 CAN Access Peer Device=4
Device=3 CAN Access Peer Device=5
Device=3 CAN Access Peer Device=6
Device=3 CAN Access Peer Device=7
Device=4 CAN Access Peer Device=0
Device=4 CAN Access Peer Device=1
Device=4 CAN Access Peer Device=2
Device=4 CAN Access Peer Device=3
Device=4 CAN Access Peer Device=5
Device=4 CAN Access Peer Device=6
Device=4 CAN Access Peer Device=7
Device=5 CAN Access Peer Device=0
Device=5 CAN Access Peer Device=1
Device=5 CAN Access Peer Device=2
Device=5 CAN Access Peer Device=3
Device=5 CAN Access Peer Device=4
Device=5 CAN Access Peer Device=6
Device=5 CAN Access Peer Device=7
Device=6 CAN Access Peer Device=0
Device=6 CAN Access Peer Device=1
Device=6 CAN Access Peer Device=2
Device=6 CAN Access Peer Device=3
Device=6 CAN Access Peer Device=4
Device=6 CAN Access Peer Device=5
Device=6 CAN Access Peer Device=7
Device=7 CAN Access Peer Device=0
Device=7 CAN Access Peer Device=1
Device=7 CAN Access Peer Device=2
Device=7 CAN Access Peer Device=3
Device=7 CAN Access Peer Device=4
Device=7 CAN Access Peer Device=5
Device=7 CAN Access Peer Device=6

***NOTE: In case a device doesn't have P2P access to other one, it falls back to normal memcopy procedure.
So you can see lesser Bandwidth (GB/s) and unstable Latency (us) in those cases.

P2P Connectivity Matrix
     D\D     0     1     2     3     4     5     6     7
     0	     1     1     1     1     1     1     1     1
     1	     1     1     1     1     1     1     1     1
     2	     1     1     1     1     1     1     1     1
     3	     1     1     1     1     1     1     1     1
     4	     1     1     1     1     1     1     1     1
     5	     1     1     1     1     1     1     1     1
     6	     1     1     1     1     1     1     1     1
     7	     1     1     1     1     1     1     1     1
Unidirectional P2P=Disabled Bandwidth Matrix (GB/s)
   D\D     0      1      2      3      4      5      6      7
     0 1524.39  16.19  15.63  15.14  13.76  13.87  14.31  13.36
     1  16.37 1536.38  15.58  15.16  13.72  13.80  14.33  13.37
     2  19.47  19.63 1545.50   9.76  13.69  13.85  14.29  13.34
     3  20.03  19.99  10.10 1568.78  13.71  13.84  14.41  13.38
     4  19.64  19.59  14.22  13.80 1573.51   8.16  13.33  12.47
     5  20.52  20.49  14.22  13.85   8.18 1562.50  13.36  12.48
     6  19.62  19.64  14.20  13.85  12.83  12.89 1560.94   7.82
     7  20.43  20.53  14.05  13.79  12.78  12.87   8.49 1567.20
Unidirectional P2P=Enabled Bandwidth (P2P Writes) Matrix (GB/s)
   D\D     0      1      2      3      4      5      6      7
     0 1521.42 274.23 272.17 273.72 273.60 271.96 275.08 275.02
     1 272.17 1591.14 273.70 271.87 275.84 275.32 275.10 273.31
     2 269.59 276.62 1548.56 270.21 275.31 274.83 274.62 271.72
     3 270.55 274.76 271.05 1550.10 273.97 275.01 275.05 273.35
     4 271.90 275.90 272.28 274.25 1586.29 275.49 273.56 273.70
     5 270.91 275.01 273.29 272.71 271.79 1583.08 275.52 274.73
     6 273.04 275.33 273.44 273.48 274.11 274.99 1579.88 274.45
     7 273.52 275.08 273.53 274.10 274.61 275.67 274.32 1576.69
Bidirectional P2P=Disabled Bandwidth Matrix (GB/s)
   D\D     0      1      2      3      4      5      6      7
     0 1550.87  15.77  21.91  21.20  19.98  20.28  20.71  20.04
     1  15.48 1599.28  21.80  21.14  19.86  20.17  20.64  20.06
     2  20.00  20.10 1563.28  10.85  15.23  15.37  15.57  14.43
     3  19.83  19.86  10.84 1599.28  14.95  15.09  15.32  14.19
     4  19.37  19.27  15.94  15.64 1598.47   8.96  14.80  13.69
     5  19.74  19.65  16.12  15.75   8.94 1595.20  14.84  13.80
     6  20.14  20.16  16.28  15.99  14.73  14.81 1596.83   8.50
     7  19.13  19.20  14.83  14.55  13.60  13.71   8.44 1592.76
Bidirectional P2P=Enabled Bandwidth Matrix (GB/s)
   D\D     0      1      2      3      4      5      6      7
     0 1551.64 424.90 425.24 424.32 424.53 424.99 425.31 424.54
     1 426.59 1608.34 514.94 518.54 518.17 519.89 519.59 517.15
     2 426.83 519.05 1591.14 512.07 513.74 513.39 512.56 513.41
     3 425.89 519.39 515.84 1600.10 519.72 522.48 519.72 520.25
     4 426.34 519.19 514.97 519.38 1595.20 516.99 518.88 519.22
     5 425.42 520.41 515.32 519.90 519.05 1596.83 518.07 521.19
     6 427.54 517.65 515.59 517.49 517.84 518.53 1588.71 518.19
     7 427.34 519.37 516.10 517.83 518.19 519.74 519.38 1592.76
P2P=Disabled Latency Matrix (us)
   GPU     0      1      2      3      4      5      6      7
     0   2.87  18.16  23.59  21.82  23.63  23.43  23.61  23.61
     1  23.50   2.08  21.71  21.56  23.54  17.95  23.53  23.37
     2  23.49  20.39   2.25  21.63  23.55  23.61  23.62  23.46
     3  22.10  21.55  22.09   2.08  23.57  23.44  23.49  23.60
     4  23.56  22.89  23.44  23.16   2.19  23.37  23.47  23.47
     5  23.57  23.56  23.58  23.46  21.14   2.16  18.30  19.88
     6  23.59  23.39  23.57  23.47  21.97  21.14   2.47  21.42
     7  23.68  23.43  23.48  23.31  23.26  15.81  21.05   2.31

   CPU     0      1      2      3      4      5      6      7
     0   3.57   5.39   5.09   5.18   5.63   5.51   5.51   5.52
     1   5.22   3.40   5.16   5.04   5.52   5.48   5.43   5.38
     2   4.88   4.78   3.30   4.94   5.36   5.36   5.42   5.37
     3   4.89   4.73   4.81   2.62   5.35   5.53   5.41   5.35
     4   5.26   5.19   5.21   5.18   2.77   5.79   5.80   5.78
     5   5.16   5.05   5.06   5.16   5.56   2.79   5.75   5.70
     6   5.20   5.11   5.16   5.19   5.69   5.72   2.82   5.75
     7   5.77   5.25   5.24   5.40   5.67   5.65   5.77   3.57
P2P=Enabled Latency (P2P Writes) Matrix (us)
   GPU     0      1      2      3      4      5      6      7
     0   2.86   3.24   3.22   3.33   3.22   3.22   3.26   3.23
     1   2.72   2.08   2.78   2.79   2.86   2.79   2.78   2.78
     2   2.82   2.81   2.25   2.80   2.81   2.82   2.87   2.81
     3   2.91   2.86   2.80   2.07   2.85   2.79   2.79   2.92
     4   2.86   2.90   2.86   2.86   2.18   2.87   2.86   2.93
     5   2.83   2.85   2.78   2.79   2.79   2.16   2.84   2.80
     6   2.82   2.81   2.88   2.81   2.86   2.88   2.46   2.82
     7   2.86   2.86   2.92   2.87   2.86   2.93   2.85   2.30

   CPU     0      1      2      3      4      5      6      7
     0   3.54   1.92   1.84   1.84   1.92   1.92   1.84   1.98
     1   1.99   3.41   1.85   1.89   1.84   1.82   1.99   1.87
     2   1.77   1.72   3.56   1.71   1.71   1.71   1.68   1.69
     3   1.77   1.77   1.73   2.70   1.69   1.72   1.73   1.69
     4   1.91   1.86   1.88   1.92   2.96   1.92   1.84   1.83
     5   1.97   1.89   1.89   1.86   1.89   2.89   1.85   1.95
     6   1.89   1.86   1.85   1.84   1.90   1.83   2.91   1.82
     7   2.13   2.05   2.06   2.04   1.97   2.05   2.08   3.69

NOTE: The CUDA Samples are not meant for performance measurements. Results may vary when GPU Boost is enabled.


./p2pBandwidthLatencyTest --sm_copy

[P2P (Peer-to-Peer) GPU Bandwidth Latency Test]
Device: 0, NVIDIA A100-SXM4-80GB, pciBusID: 65, pciDeviceID: 1, pciDomainID:0
Device: 1, NVIDIA A100-SXM4-80GB, pciBusID: 65, pciDeviceID: 2, pciDomainID:0
Device: 2, NVIDIA A100-SXM4-80GB, pciBusID: 67, pciDeviceID: 1, pciDomainID:0
Device: 3, NVIDIA A100-SXM4-80GB, pciBusID: 67, pciDeviceID: 2, pciDomainID:0
Device: 4, NVIDIA A100-SXM4-80GB, pciBusID: 69, pciDeviceID: 1, pciDomainID:0
Device: 5, NVIDIA A100-SXM4-80GB, pciBusID: 69, pciDeviceID: 2, pciDomainID:0
Device: 6, NVIDIA A100-SXM4-80GB, pciBusID: 6b, pciDeviceID: 1, pciDomainID:0
Device: 7, NVIDIA A100-SXM4-80GB, pciBusID: 6b, pciDeviceID: 2, pciDomainID:0
Device=0 CAN Access Peer Device=1
Device=0 CAN Access Peer Device=2
Device=0 CAN Access Peer Device=3
Device=0 CAN Access Peer Device=4
Device=0 CAN Access Peer Device=5
Device=0 CAN Access Peer Device=6
Device=0 CAN Access Peer Device=7
Device=1 CAN Access Peer Device=0
Device=1 CAN Access Peer Device=2
Device=1 CAN Access Peer Device=3
Device=1 CAN Access Peer Device=4
Device=1 CAN Access Peer Device=5
Device=1 CAN Access Peer Device=6
Device=1 CAN Access Peer Device=7
Device=2 CAN Access Peer Device=0
Device=2 CAN Access Peer Device=1
Device=2 CAN Access Peer Device=3
Device=2 CAN Access Peer Device=4
Device=2 CAN Access Peer Device=5
Device=2 CAN Access Peer Device=6
Device=2 CAN Access Peer Device=7
Device=3 CAN Access Peer Device=0
Device=3 CAN Access Peer Device=1
Device=3 CAN Access Peer Device=2
Device=3 CAN Access Peer Device=4
Device=3 CAN Access Peer Device=5
Device=3 CAN Access Peer Device=6
Device=3 CAN Access Peer Device=7
Device=4 CAN Access Peer Device=0
Device=4 CAN Access Peer Device=1
Device=4 CAN Access Peer Device=2
Device=4 CAN Access Peer Device=3
Device=4 CAN Access Peer Device=5
Device=4 CAN Access Peer Device=6
Device=4 CAN Access Peer Device=7
Device=5 CAN Access Peer Device=0
Device=5 CAN Access Peer Device=1
Device=5 CAN Access Peer Device=2
Device=5 CAN Access Peer Device=3
Device=5 CAN Access Peer Device=4
Device=5 CAN Access Peer Device=6
Device=5 CAN Access Peer Device=7
Device=6 CAN Access Peer Device=0
Device=6 CAN Access Peer Device=1
Device=6 CAN Access Peer Device=2
Device=6 CAN Access Peer Device=3
Device=6 CAN Access Peer Device=4
Device=6 CAN Access Peer Device=5
Device=6 CAN Access Peer Device=7
Device=7 CAN Access Peer Device=0
Device=7 CAN Access Peer Device=1
Device=7 CAN Access Peer Device=2
Device=7 CAN Access Peer Device=3
Device=7 CAN Access Peer Device=4
Device=7 CAN Access Peer Device=5
Device=7 CAN Access Peer Device=6

***NOTE: In case a device doesn't have P2P access to other one, it falls back to normal memcopy procedure.
So you can see lesser Bandwidth (GB/s) and unstable Latency (us) in those cases.

P2P Connectivity Matrix
     D\D     0     1     2     3     4     5     6     7
     0	     1     1     1     1     1     1     1     1
     1	     1     1     1     1     1     1     1     1
     2	     1     1     1     1     1     1     1     1
     3	     1     1     1     1     1     1     1     1
     4	     1     1     1     1     1     1     1     1
     5	     1     1     1     1     1     1     1     1
     6	     1     1     1     1     1     1     1     1
     7	     1     1     1     1     1     1     1     1
Unidirectional P2P=Disabled Bandwidth Matrix (GB/s)
   D\D     0      1      2      3      4      5      6      7
     0 1521.42  16.15  19.60  19.99  20.35  20.32  20.40  13.78
     1  16.39 1534.87  19.39  19.52  20.32  20.31  20.33  13.72
     2  19.48  19.55 1531.86  15.02  20.29  20.31  20.31  13.74
     3  19.65  19.57  16.33 1543.97  19.63  19.69  20.35  13.72
     4  19.69  19.59  19.89  20.52 1568.78  15.51  20.60  12.66
     5  19.68  19.59  19.68  20.33  15.67 1573.51  20.68  12.76
     6  19.81  19.54  20.47  20.53  20.74  20.69 1565.63   8.31
     7  19.78  19.75  19.67  20.49  20.78  20.66  15.75 1567.20
Unidirectional P2P=Enabled Bandwidth (P2P Writes) Matrix (GB/s)
   D\D     0      1      2      3      4      5      6      7
     0 1530.36 205.00 205.97 205.05 205.27 205.81 205.54 204.94
     1 204.94 1545.50 205.75 205.59 202.97 205.70 205.32 205.48
     2 220.07 221.00 1584.69 225.79 200.58 200.53 200.94 201.09
     3 221.69 221.95 221.88 1586.29 226.58 226.25 226.19 225.79
     4 221.51 222.45 222.01 225.21 1589.52 226.19 226.78 225.60
     5 224.76 225.40 225.34 231.41 228.90 1579.88 231.28 230.39
     6 226.06 225.66 225.47 231.21 231.34 231.21 1587.91 230.32
     7 221.76 222.26 222.20 226.38 225.60 226.12 226.84 1583.08
Bidirectional P2P=Disabled Bandwidth Matrix (GB/s)
   D\D     0      1      2      3      4      5      6      7
     0 1551.64  15.83  27.28  27.45  28.68  28.62  28.94  20.49
     1  15.84 1560.94  26.86  27.51  27.74  27.85  28.83  20.54
     2  27.67  27.52 1592.76  15.88  27.82  27.98  27.91  20.94
     3  27.93  27.80  15.46 1600.92  28.67  28.73  27.80  20.95
     4  28.64  28.50  28.54  28.55 1599.28  15.69  27.97  19.71
     5  27.73  28.59  28.55  28.58  15.80 1598.47  27.86  19.70
     6  27.20  27.23  28.70  28.76  29.19  29.06 1596.02  12.18
     7  20.03  20.06  20.07  20.30  18.04  18.05  12.27 1595.20
Bidirectional P2P=Enabled Bandwidth Matrix (GB/s)
   D\D     0      1      2      3      4      5      6      7
     0 1550.10 314.07 306.73 313.94 324.30 323.97 323.97 324.71
     1 314.96 1564.06 307.16 315.40 323.50 324.04 324.04 323.03
     2 307.34 308.25 1565.63 308.25 316.36 316.42 316.87 316.10
     3 314.70 315.27 306.01 1559.38 324.04 324.17 323.63 322.90
     4 323.23 322.83 315.47 322.83 1601.74 387.62 387.33 388.01
     5 322.96 323.30 315.40 323.23 387.72 1593.57 388.10 386.95
     6 322.96 322.90 315.21 323.16 387.43 388.10 1593.57 387.14
     7 322.50 322.03 314.96 322.10 387.33 386.37 386.95 1594.39
P2P=Disabled Latency Matrix (us)
   GPU     0      1      2      3      4      5      6      7
     0   2.95  23.60  23.59  23.56  23.60  23.58  23.51  23.59
     1  23.43   2.60  23.51  23.47  23.59  23.58  23.64  23.61
     2  23.48  23.47   2.57  23.49  23.54  23.58  23.58  23.64
     3  23.49  23.48  23.46   2.55  23.59  23.58  23.59  23.58
     4  23.60  23.58  23.52  23.58   2.07  21.96  21.67  23.49
     5  23.68  23.53  23.57  23.59  21.09   2.14  21.23  21.79
     6  23.50  23.53  23.63  23.57  21.62  22.48   2.27  23.48
     7  23.62  23.55  23.66  23.67  22.46  21.68  22.39   2.30

   CPU     0      1      2      3      4      5      6      7
     0   2.87   6.01   6.07   6.03   5.26   5.26   5.16   5.37
     1   6.32   2.83   5.88   5.97   5.26   5.24   5.16   5.36
     2   5.84   5.87   2.81   5.83   5.28   5.18   5.14   5.22
     3   5.85   5.78   5.80   2.82   5.32   5.13   5.31   5.21
     4   5.42   5.43   5.43   5.42   2.59   4.72   4.85   4.70
     5   5.46   5.27   5.34   5.35   4.74   2.62   4.80   4.78
     6   5.27   5.38   5.31   5.30   4.72   4.73   2.61   4.69
     7   5.55   5.41   5.57   5.36   4.84   4.62   4.78   2.61
P2P=Enabled Latency (P2P Writes) Matrix (us)
   GPU     0      1      2      3      4      5      6      7
     0   2.96   5.34   5.34   5.35   5.34   5.34   5.38   5.34
     1   5.22   2.59   5.20   5.12   5.21   5.20   5.17   5.19
     2   5.47   5.45   2.58   5.46   5.46   5.45   5.46   5.47
     3   5.24   5.26   5.25   2.53   5.25   5.23   5.24   5.25
     4   4.61   4.65   4.60   4.60   2.07   4.61   4.60   4.62
     5   4.54   4.57   4.53   4.53   4.53   2.13   4.53   4.54
     6   4.55   4.58   4.58   4.54   4.54   4.59   2.24   4.54
     7   4.67   4.68   4.70   4.66   4.67   4.67   4.68   2.29

   CPU     0      1      2      3      4      5      6      7
     0   3.05   2.16   2.16   2.18   2.37   2.28   2.15   2.15
     1   2.18   2.87   2.17   2.12   2.15   2.12   2.11   2.29
     2   2.18   2.19   2.93   2.16   2.23   2.22   2.14   2.14
     3   2.18   2.23   2.13   2.90   2.24   2.16   2.25   2.13
     4   1.99   1.94   1.93   1.99   2.78   1.97   1.99   1.93
     5   1.96   1.95   1.94   1.95   2.07   2.72   1.93   1.94
     6   1.99   1.96   1.92   1.96   2.06   1.95   2.73   1.94
     7   1.98   1.97   1.97   1.95   2.03   2.01   1.95   2.73

NOTE: The CUDA Samples are not meant for performance measurements. Results may vary when GPU Boost is enabled.
(torch1.12) root@GPU-12:/data4/docker_root/docker/tmp# history -c
(torch1.12) root@GPU-12:/data4/docker_root/docker/tmp# logout
```
