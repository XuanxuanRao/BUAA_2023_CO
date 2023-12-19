ori $4 $0 0
loop1_start: nop
nop 
ori $22 $0 17517
sw $22 -9361($22)
nop 
ori $21 $22 1360
ori $22 $0 156
lw $20 7916($22)
ori $21 $0 11551
lw $22 -6619($21)
sub $20 $21 $22
nop 
lui $22 33551
ori $20 $20 41343
ori $21 $0 1541
lw $21 5711($21)
ori $22 $0 5174
sw $20 4614($22)
lui $21 63253
lui $20 13365
lui $22 60107
sub $21 $21 $20
ori $21 $22 21299
add $22 $22 $22
add $20 $22 $20
ori $21 $20 55197
add $20 $21 $21
add $21 $22 $20
ori $22 $0 23936
sw $21 -19676($22)
sub $20 $20 $22
ori $22 $0 20377
lw $20 -8425($22)
add $22 $21 $22
add $21 $21 $21
add $20 $22 $22
lui $21 48567
nop 
add $20 $22 $22
ori $22 $22 11329
ori $22 $0 7758
sw $20 2474($22)
ori $22 $0 1706
sw $21 7742($22)
add $21 $20 $22
lui $21 45172
lui $21 39875
ori $22 $0 10299
sw $21 -1123($22)
ori $20 $0 2583
lw $21 1277($20)
ori $22 $0 5990
sw $21 -5254($22)
sub $21 $20 $20
ori $21 $0 17310
sw $21 -16146($21)
ori $22 $0 9096
sw $21 -2908($22)
add $21 $22 $20
ori $22 $22 32854
ori $20 $20 55053
add $22 $22 $20
ori $20 $21 50711
ori $20 $20 37756
lui $22 22625
ori $1 $0 1
add $4 $4 $1
ori $1 $0 10
beq $1 $4 loop1_end
ori $22 $0 4321
lw $21 2283($22)
jal loop1_start
nop 
loop1_end: nop
jal jal_conflict1_start
lui $18 31
jal_conflict1_start: 
lui $19 31
nop 
ori $31 $0 12612
jr $31
ori $12 $14 29079
ori $16 $0 4019
lw $13 2321($16)
jal jal_conflict2_start
add $14 $31 $13
jal_conflict2_start: 
ori $16 $0 3958
lw $19 -2118($16)
lui $21 31
ori $31 $0 12652
jr $31
sub $10 $9 $12
ori $17 $0 175
lw $8 7301($17)
jal jal_conflict3_start
lui $18 31
jal_conflict3_start: 
lui $13 31
add $14 $16 $31
ori $31 $0 12688
jr $31
add $19 $19 $21
ori $12 $0 28198
sw $9 -22678($12)
jal jal_conflict4_start
ori $9 $31 48709
jal_conflict4_start: 
lui $9 1051
lui $12 31
ori $31 $0 12724
jr $31
ori $10 $0 28764
lw $10 -21904($10)
lui $13 52989
jal jal_conflict5_start
sw $17 -12240($31)
jal_conflict5_start: 
nop 
lui $13 5605
ori $31 $0 12760
jr $31
sub $11 $17 $12
add $19 $13 $12
jal jal_conflict6_start
sw $18 -12276($31)
jal_conflict6_start: 
ori $21 $0 24083
sw $20 -12431($21)
lw $16 -12240($31)
ori $31 $0 12796
jr $31
ori $15 $0 30799
sw $21 -23895($15)
ori $15 $20 29413
jal jal_conflict7_start
add $14 $31 $10
jal_conflict7_start: 
lw $11 -12244($31)
ori $19 $8 31
ori $31 $0 12832
jr $31
ori $18 $0 27581
lw $14 -21301($18)
sub $21 $21 $14
jal jal_conflict8_start
sub $11 $31 $19
jal_conflict8_start: 
ori $16 $0 26941
lw $19 -24589($16)
sw $15 -12240($31)
ori $31 $0 12872
jr $31
ori $15 $0 30046
sw $18 -26714($15)
ori $15 $13 40499
jal jal_conflict9_start
lui $13 31
jal_conflict9_start: 
ori $12 $31 53072
nop 
ori $31 $0 12908
jr $31
ori $21 $0 29843
sw $10 -18115($21)
ori $14 $0 28293
sw $15 -21177($14)
jal jal_conflict10_start
sub $17 $31 $19
jal_conflict10_start: 
sub $21 $13 $31
add $10 $31 $9
ori $31 $0 12948
jr $31
lui $13 25309
add $10 $14 $19
jal jal_conflict11_start
lui $12 31
jal_conflict11_start: 
sub $12 $31 $8
nop 
ori $31 $0 12980
jr $31
ori $12 $0 18132
sw $12 -10616($12)
add $21 $11 $9
jal jal_conflict12_start
sub $17 $31 $11
jal_conflict12_start: 
ori $21 $13 31
add $13 $31 $21
ori $31 $0 13016
jr $31
nop 
lui $13 54309
jal jal_conflict13_start
sub $11 $31 $8
jal_conflict13_start: 
nop 
nop 
ori $31 $0 13048
jr $31
lui $12 33996
nop 
jal jal_conflict14_start
nop 
jal_conflict14_start: 
sub $21 $10 $31
lw $15 -12280($31)
ori $31 $0 13080
jr $31
nop 
ori $12 $19 61977
jal jal_conflict15_start
add $19 $31 $9
jal_conflict15_start: 
lui $18 31
sub $8 $10 $31
ori $31 $0 13112
jr $31
ori $17 $15 17367
lui $13 28573
jal jal_conflict16_start
ori $8 $31 63427
jal_conflict16_start: 
ori $16 $17 31
add $15 $31 $12
ori $31 $0 13144
jr $31
lui $15 40911
sub $17 $15 $16
jal jal_conflict17_start
lw $21 -12244($31)
jal_conflict17_start: 
lui $17 31
ori $20 $16 31
ori $31 $0 13176
jr $31
nop 
add $18 $8 $17
jal jal_conflict18_start
lui $9 31
jal_conflict18_start: 
ori $9 $18 31
sub $11 $31 $20
ori $31 $0 13208
jr $31
ori $9 $0 22684
lw $13 -20408($9)
sub $15 $9 $20
jal jal_conflict19_start
sub $15 $31 $10
jal_conflict19_start: 
sw $11 -12272($31)
ori $21 $0 9613
sw $8 -3797($21)
ori $31 $0 13248
jr $31
ori $13 $0 27180
lw $12 -15888($13)
nop 
jal jal_conflict20_start
sw $8 -12276($31)
jal_conflict20_start: 
ori $8 $10 31
add $20 $31 $19
ori $31 $0 13284
jr $31
lui $14 44639
nop 
jal jal_conflict21_start
sw $10 -12268($31)
jal_conflict21_start: 
lw $8 -12288($31)
sub $8 $12 $31
ori $31 $0 13316
jr $31
add $18 $9 $8
lui $19 55472
jal jal_conflict22_start
nop 
jal_conflict22_start: 
ori $8 $0 4788
sw $10 4224($8)
sw $20 -12244($31)
ori $31 $0 13352
jr $31
ori $11 $0 26497
lw $9 -24361($11)
sub $15 $10 $19
jal jal_conflict23_start
add $16 $31 $20
jal_conflict23_start: 
nop 
ori $17 $0 19390
sw $13 -14346($17)
ori $31 $0 13392
jr $31
lui $13 6246
add $12 $18 $19
jal jal_conflict24_start
lui $19 31
jal_conflict24_start: 
add $21 $20 $31
sub $21 $31 $16
ori $31 $0 13424
jr $31
sub $12 $19 $21
ori $13 $0 32395
lw $18 -25551($13)
jal jal_conflict25_start
sub $14 $31 $12
jal_conflict25_start: 
lui $15 31
nop 
ori $31 $0 13460
jr $31
lui $16 14401
add $11 $14 $21
jal jal_conflict26_start
ori $10 $31 55954
jal_conflict26_start: 
ori $13 $15 31
nop 
ori $31 $0 13492
jr $31
lui $11 48309
sub $11 $8 $10
jal jal_conflict27_start
lui $12 31
jal_conflict27_start: 
lw $20 -12256($31)
add $16 $18 $31
ori $31 $0 13524
jr $31
ori $19 $0 28529
sw $15 -22625($19)
lui $19 32282
jal jal_conflict28_start
add $9 $31 $9
jal_conflict28_start: 
ori $14 $0 8241
sw $17 683($14)
ori $19 $31 49081
ori $31 $0 13564
jr $31
add $10 $21 $21
add $19 $15 $18
jal jal_conflict29_start
nop 
jal_conflict29_start: 
lw $18 -12240($31)
ori $15 $0 3512
lw $9 -252($15)
ori $31 $0 13600
jr $31
sub $11 $13 $17
ori $20 $10 59924
jal jal_conflict30_start
sub $12 $31 $13
jal_conflict30_start: 
sub $8 $9 $31
sub $9 $31 $17
ori $31 $0 13632
jr $31
ori $18 $0 32760
sw $14 -22156($18)
lui $12 51440
jal jal_conflict101_start
lui $17 31
jal_conflict101_start: 
beq $31 $31 jal_conflict101_end
jal_conflict101_end: nop
jal jal_normal_start
nop 
nop 
nop 
sub $18 $10 $16
add $10 $13 $20
add $16 $13 $21
add $8 $19 $10
add $17 $19 $8
nop 
add $21 $12 $19
add $17 $19 $21
jal jal_normal_end
jal_normal_start: nop
ori $18 $0 24103
sw $16 -18079($18)
ori $21 $16 46753
add $20 $13 $16
ori $9 $20 55995
ori $8 $0 14705
sw $12 -10093($8)
sub $21 $15 $14
ori $11 $0 12541
sw $12 -11357($11)
nop 
ori $8 $0 16683
sw $12 -9635($8)
nop 
add $17 $21 $20
sub $19 $18 $11
ori $14 $0 21217
lw $20 -12757($14)
ori $12 $12 9574
ori $20 $9 59796
lui $17 25985
lui $20 40093
ori $9 $0 3056
sw $20 -592($9)
lui $15 52990
ori $10 $0 30121
sw $21 -18377($10)
jr $31
jal_normal_end: nop
add $9 $9 $8
sub $17 $8 $9
sub $8 $9 $8
ori $17 $0 26117
lw $9 -18041($17)
ori $8 $0 18629
sw $17 -13009($8)
sub $8 $17 $9
lui $9 17
lui $17 8
ori $8 $0 13173
lw $17 -1613($8)
ori $17 $17 9
nop 
lui $8 9
add $17 $8 $17
nop 
ori $8 $9 8
sub $17 $17 $8
add $17 $8 $8
ori $9 $17 8
sub $8 $9 $8
ori $8 $0 19391
lw $8 -13051($8)
add $9 $8 $8
ori $17 $9 9
nop 
ori $9 $0 18595
lw $17 -14391($9)
nop 
sub $9 $8 $17
nop 
lui $8 8
ori $17 $0 9114
lw $17 -2254($17)
ori $8 $0 28184
lw $9 -19288($8)
ori $8 $9 17
lui $17 8
sub $17 $17 $8
ori $8 $0 14080
lw $17 -12588($8)
add $8 $9 $17
ori $9 $17 9
ori $8 $0 26802
lw $17 -21758($8)
lui $8 8
ori $17 $8 8
ori $9 $17 9
nop 
sub $17 $17 $9
nop 
lui $8 17
ori $9 $0 31326
sw $8 -20854($9)
lui $9 9
ori $8 $0 30402
sw $17 -28594($8)
sub $8 $8 $8
lui $17 17
ori $17 $0 1564
sw $17 7788($17)
sub $17 $9 $8
lui $9 9
add $8 $8 $8
ori $8 $0 14026
lw $9 -12994($8)
ori $17 $8 9
add $8 $8 $17
ori $9 $17 8
ori $8 $17 8
lui $17 8
add $17 $17 $17
lui $8 9
nop 
ori $8 $0 2330
lw $17 7034($8)
add $17 $17 $9
ori $17 $8 9
sub $9 $17 $8
ori $9 $9 8
nop 
ori $8 $0 21940
sw $8 -15856($8)
ori $17 $9 8
add $8 $9 $9
ori $8 $8 9
ori $8 $9 8
add $8 $8 $8
nop 
ori $8 $0 12136
sw $8 -5256($8)
lui $17 17
sub $9 $17 $8
ori $17 $0 6589
lw $17 -5693($17)
ori $8 $0 13737
lw $8 -10121($8)
lui $9 8
lui $8 9
sub $17 $9 $17
ori $9 $0 28529
sw $8 -22245($9)
lui $9 8
lui $9 17
lui $8 8
sub $17 $9 $8
ori $8 $9 17
ori $17 $0 28695
sw $17 -19327($17)
ori $8 $9 9
lui $9 9
nop 
lui $8 17
ori $9 $9 9
add $9 $17 $17
sub $8 $8 $9
sub $9 $8 $17
sub $9 $9 $8
ori $8 $17 17
nop 
ori $9 $0 6753
lw $9 -4669($9)
sub $17 $8 $17
ori $9 $0 29745
lw $9 -23249($9)
sub $9 $9 $9
ori $9 $17 17
ori $9 $0 8706
sw $17 -5026($9)
nop 
ori $17 $8 8
ori $8 $17 8
nop 
add $8 $9 $17
sub $17 $9 $17
ori $17 $0 21435
lw $8 -18335($17)
add $8 $17 $17
ori $17 $0 18610
lw $9 -11786($17)
ori $8 $0 27908
sw $9 -27664($8)
ori $9 $0 1838
lw $8 -438($9)
nop 
add $8 $9 $9
nop 
add $9 $17 $9
sub $8 $17 $9
ori $8 $0 27737
sw $9 -17853($8)
nop 
nop 
sub $9 $9 $17
add $9 $17 $8
add $9 $9 $17
ori $8 $0 32414
sw $8 -30066($8)
ori $9 $0 30408
lw $17 -21308($9)
add $9 $8 $9
nop 
ori $8 $0 32394
sw $8 -20838($8)
sub $8 $8 $9
ori $17 $8 8
add $17 $17 $17
add $17 $8 $9
ori $8 $8 17
sub $8 $9 $8
ori $17 $9 9
add $8 $17 $8
add $17 $9 $17
ori $17 $9 9
nop 
ori $9 $9 17
nop 
ori $17 $0 7440
sw $9 3084($17)
add $9 $9 $8
sub $9 $8 $8
nop 
ori $20 $0 29528
lw $8 -28044($20)
ori $18 $0 9752
sw $15 -4516($18)
beq $8 $0 beqConflict1_end
nop 
lui $15 55838
beqConflict1_end: nop
ori $20 $14 13912
add $11 $21 $19
ori $8 $0 31078
sw $18 -24474($8)
beq $20 $11 beqConflict2_end
ori $17 $15 28727
nop 
beqConflict2_end: nop
ori $21 $12 24163
nop 
nop 
beq $0 $21 beqConflict3_end
ori $15 $17 8474
ori $16 $0 667
lw $15 5481($16)
beqConflict3_end: nop
nop 
lui $18 29693
lui $14 35524
beq $14 $0 beqConflict4_end
ori $15 $0 20354
sw $17 -12778($15)
ori $16 $0 29998
sw $15 -20494($16)
beqConflict4_end: nop
ori $2 $0 21193
ori $3 $0 6898
sw $3 0($0)
lw $2 0($0)
beq $2 $3 beqConflict5_end
ori $15 $0 17155
sw $17 -9391($15)
add $15 $16 $15
beqConflict5_end: nop
lui $19 20134
ori $21 $19 48279
sub $12 $13 $21
beq $19 $12 beqConflict6_end
lui $15 16880
sub $16 $17 $16
beqConflict6_end: nop
lui $10 64927
ori $10 $10 21979
lui $19 56522
beq $19 $10 beqConflict7_end
add $15 $15 $16
add $15 $15 $15
beqConflict7_end: nop
add $20 $19 $8
lui $20 42086
lui $13 31731
beq $13 $20 beqConflict8_end
ori $15 $0 20341
sw $17 -18901($15)
add $15 $15 $16
beqConflict8_end: nop
nop 
ori $15 $0 6802
lw $20 5426($15)
lui $11 19741
beq $20 $0 beqConflict9_end
sub $16 $16 $17
lui $15 19438
beqConflict9_end: nop
ori $2 $0 15784
ori $3 $0 10978
sw $3 0($0)
lw $2 0($0)
beq $2 $3 beqConflict10_end
add $16 $16 $17
add $17 $15 $15
beqConflict10_end: nop
sub $16 $17 $18
ori $20 $8 18360
ori $10 $0 26349
lw $16 -14529($10)
beq $16 $16 beqConflict11_end
nop 
sub $16 $15 $15
beqConflict11_end: nop
lui $17 37920
nop 
ori $18 $11 57900
beq $17 $18 beqConflict12_end
nop 
lui $17 276
beqConflict12_end: nop
ori $8 $0 28707
lw $17 -18751($8)
lui $18 58705
ori $19 $17 54384
beq $17 $19 beqConflict13_end
ori $17 $0 32685
lw $15 -31809($17)
add $15 $16 $15
beqConflict13_end: nop
sub $13 $12 $20
ori $18 $0 24399
sw $9 -21147($18)
nop 
beq $0 $13 beqConflict14_end
lui $15 30700
add $15 $16 $17
beqConflict14_end: nop
ori $2 $0 54406
ori $3 $0 8702
sw $3 0($0)
lw $2 0($0)
beq $2 $3 beqConflict15_end
add $15 $17 $16
ori $15 $0 24288
lw $16 -14576($15)
beqConflict15_end: nop
nop 
ori $10 $0 23809
lw $13 -21337($10)
nop 
beq $0 $0 beqConflict16_end
lui $17 43840
ori $15 $0 24170
sw $15 -18846($15)
beqConflict16_end: nop
ori $8 $17 26448
ori $18 $0 3784
lw $20 7328($18)
add $17 $18 $21
beq $8 $20 beqConflict17_end
ori $15 $0 29818
lw $15 -26142($15)
ori $16 $0 18757
sw $16 -11841($16)
beqConflict17_end: nop
add $17 $15 $16
ori $19 $0 52
lw $19 7432($19)
add $15 $18 $10
beq $19 $17 beqConflict18_end
ori $17 $15 7533
ori $15 $17 56581
beqConflict18_end: nop
ori $16 $0 32114
lw $19 -26534($16)
ori $10 $18 12857
lui $19 64891
beq $10 $19 beqConflict19_end
ori $16 $0 21086
lw $17 -18566($16)
sub $17 $15 $17
beqConflict19_end: nop
ori $2 $0 28772
ori $3 $0 5143
sw $3 0($0)
lw $2 0($0)
beq $2 $3 beqConflict20_end
lui $16 5324
sub $15 $17 $16
beqConflict20_end: nop
nop 
ori $15 $0 28691
sw $10 -25539($15)
ori $17 $0 21475
lw $17 -18107($17)
beq $0 $17 beqConflict21_end
ori $16 $0 10936
sw $16 -8808($16)
add $16 $16 $17
beqConflict21_end: nop
sub $21 $13 $18
ori $10 $0 28342
sw $12 -25722($10)
ori $20 $21 59946
beq $21 $12 beqConflict22_end
ori $16 $0 30077
lw $16 -24989($16)
ori $16 $0 29384
sw $17 -23124($16)
beqConflict22_end: nop
ori $18 $0 24443
lw $13 -15603($18)
ori $10 $0 16979
sw $21 -10019($10)
add $21 $21 $17
beq $13 $21 beqConflict23_end
ori $16 $0 28435
sw $17 -19587($16)
nop 
beqConflict23_end: nop
ori $21 $0 18499
sw $9 -9191($21)
add $13 $13 $12
add $10 $20 $10
beq $9 $13 beqConflict24_end
ori $17 $0 27918
sw $17 -17478($17)
ori $17 $17 63510
beqConflict24_end: nop
ori $2 $0 53403
ori $3 $0 30321
sw $3 0($0)
lw $2 0($0)
beq $2 $3 beqConflict25_end
sub $17 $17 $15
ori $17 $16 38583
beqConflict25_end: nop
nop 
nop 
lui $9 41191
beq $0 $0 beqConflict26_end
ori $15 $0 30679
lw $17 -26851($15)
add $17 $16 $16
beqConflict26_end: nop
ori $14 $18 30887
lui $16 31237
add $10 $13 $18
beq $14 $16 beqConflict27_end
sub $16 $15 $16
lui $16 37285
beqConflict27_end: nop
ori $19 $0 25930
sw $19 -25250($19)
add $19 $16 $15
sub $12 $11 $20
beq $12 $19 beqConflict28_end
sub $17 $15 $15
nop 
beqConflict28_end: nop
add $11 $18 $16
ori $17 $11 45953
sub $16 $13 $16
beq $11 $17 beqConflict29_end
nop 
add $17 $17 $15
beqConflict29_end: nop
ori $2 $0 708
ori $3 $0 8930
sw $3 0($0)
lw $2 0($0)
beq $2 $3 beqConflict30_end
lui $16 47538
lui $15 47500
beqConflict30_end: nop
ori $20 $0 15580
sw $20 0($0)
lw $20 0($0)
jr $20
nop 
ori $20 $0 15592
jr $20
nop 
ori $20 $0 15608
add $3 $20 $0
jr $3
nop 
ori $20 $0 15624
sub $20 $20 $0
jr $20
nop 
ori $20 $0 15644
add $3 $20 $0
sub $2 $3 $0
jr $3
nop 
jal jrConflict_start
nop 
jal jrConflict_end
nop 
jrConflict_start: 
jr $31
jrConflict_end: nop
ori $20 $0 15696
sw $20 0($0)
lw $2 0($0)
sub $16 $17 $11
add $8 $9 $10
jr $2
nop 
ori $2 $0 780
ori $3 $0 780
add $23 $2 $3
lw $11 0($23)
sw $23 0($23)
lw $3 0($23)
lw $13 0($3)
lui $23 0
lw $15 916($23)
sw $23 0($23)
lw $3 0($23)
sw $23 0($3)
ori $16 $0 645
lw $16 415($16)
ori $15 $16 1314
ori $17 $16 1314
ori $13 $16 1314
