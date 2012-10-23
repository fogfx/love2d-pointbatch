local lovelogo = love.graphics.newPointBatch(nil, 260)

local logocoords = {
	1.468503, 0.250757;
	1.561704, 0.225127;
	1.657082, 0.188915;
	1.746949, 0.140288;
	1.823617, 0.077412;
	1.879398, -0.001547;
	1.906604, -0.098422;
	1.891772, -0.209683;
	1.846683, -0.298430;
	1.790108, -0.364707;
	1.697365, -0.429356;
	1.582633, -0.465934;
	1.471706, -0.479409;
	1.366646, -0.471675;
	1.266606, -0.443333;
	1.148952, -0.378530;
	1.055410, -0.286056;
	0.983384, -0.164983;
	0.959199, -0.034528;
	0.956717, 0.077506;
	0.975921, 0.188443;
	1.024637, 0.309905;
	1.092420, 0.413377;
	1.193460, 0.493830;
	1.310864, 0.540894;
	1.429270, 0.558680;
	1.549592, 0.557562;
	1.609470, 0.552269;
	1.638882, 0.540876;
	1.656610, 0.518395;
	1.662595, 0.501463;
	1.656773, 0.464882;
	1.639086, 0.446207;
	1.609470, 0.441157;
	1.556430, 0.446043;
	1.450589, 0.448343;
	1.346117, 0.434858;
	1.241183, 0.394524;
	1.153219, 0.316399;
	1.104145, 0.234929;
	1.071546, 0.159434;
	1.055096, 0.059346;
	1.063144, -0.043023;
	1.093824, -0.141762;
	1.145266, -0.230962;
	1.215604, -0.304711;
	1.302969, -0.357100;
	1.383816, -0.379778;
	1.469335, -0.384055;
	1.554725, -0.370534;
	1.635185, -0.339816;
	1.705915, -0.292505;
	1.762114, -0.229200;
	1.793310, -0.155721;
	1.790488, -0.088062;
	1.760823, -0.027407;
	1.711484, 0.025063;
	1.649646, 0.068164;
	1.582480, 0.100712;
	1.535432, 0.117531;
	1.463236, 0.137779;
	1.438958, 0.143623;
	1.412085, 0.158355;
	1.400124, 0.182273;
	1.401430, 0.209423;
	1.414359, 0.233855;
	1.437265, 0.249617;
	-0.311591, -0.411978;
	-0.258650, -0.290842;
	-0.205685, -0.169374;
	-0.151718, -0.048219;
	-0.095770, 0.071978;
	-0.036861, 0.190574;
	0.011996, 0.281021;
	0.057183, 0.360695;
	0.109445, 0.434011;
	0.181660, 0.512955;
	0.235927, 0.545141;
	0.297822, 0.560269;
	0.359197, 0.552623;
	1.662589, 0.480849;
	0.414737, 0.524013;
	0.492358, 0.444870;
	0.546463, 0.372023;
	0.594118, 0.295960;
	0.646266, 0.206870;
	0.710312, 0.085760;
	0.770570, -0.037620;
	0.828215, -0.162330;
	0.884423, -0.287426;
	0.940368, -0.411967;
	0.945506, -0.443120;
	0.935108, -0.469756;
	0.924526, -0.485506;
	0.888957, -0.496857;
	0.863831, -0.491017;
	0.844423, -0.468045;
	0.791241, -0.350290;
	0.737742, -0.232422;
	0.683134, -0.114971;
	0.626622, 0.001533;
	0.567412, 0.116559;
	0.520032, 0.201963;
	0.469649, 0.286279;
	0.416810, 0.361039;
	0.359816, 0.423722;
	0.328954, 0.443459;
	0.297082, 0.449092;
	0.270689, 0.439161;
	0.240188, 0.416321;
	0.184600, 0.349227;
	0.134319, 0.273271;
	0.087032, 0.186633;
	0.042063, 0.100728;
	-0.012627, -0.011532;
	-0.064953, -0.125043;
	-0.115705, -0.239301;
	-0.165676, -0.353803;
	-0.215657, -0.468045;
	-0.234771, -0.491128;
	-0.259717, -0.497028;
	-0.277979, -0.492854;
	-0.305858, -0.469914;
	-0.316431, -0.443219;
	-2.179152, -0.462367;
	-2.217917, -0.328036;
	-2.240898, -0.188678;
	-2.244791, -0.048116;
	-2.226291, 0.089827;
	-2.182094, 0.221329;
	-2.108896, 0.342568;
	-2.018931, 0.434448;
	-1.914482, 0.500400;
	-1.799281, 0.541974;
	-1.677059, 0.560722;
	-1.551549, 0.558196;
	-1.426483, 0.535946;
	-1.399757, 0.520620;
	-1.387868, 0.496343;
	-1.389665, 0.458470;
	-1.402068, 0.444753;
	-1.424890, 0.429346;
	-1.456016, 0.428802;
	-1.561200, 0.447777;
	-1.666906, 0.450523;
	-1.769814, 0.435372;
	-1.866606, 0.400658;
	-1.953962, 0.344713;
	-2.028562, 0.265868;
	-2.088940, 0.159572;
	-2.123382, 0.044691;
	-2.135397, -0.075383;
	-2.128499, -0.197257;
	-2.106199, -0.317538;
	-2.072007, -0.432834;
	-2.070097, -0.463242;
	-2.084054, -0.485572;
	-2.097308, -0.497275;
	-2.135689, -0.499651;
	-2.161427, -0.488224;
	-1.363379, 0.032428;
	-1.344932, -0.107169;
	-1.292789, -0.233131;
	-1.211743, -0.340192;
	-1.106587, -0.423086;
	-0.982115, -0.476544;
	-0.843120, -0.495302;
	-0.704967, -0.475968;
	-0.581550, -0.422166;
	-0.477499, -0.339161;
	-0.397444, -0.232217;
	-0.346015, -0.106599;
	-0.327844, 0.032428;
	-0.346015, 0.171456;
	-0.397444, 0.297074;
	-0.477499, 0.404018;
	-0.581550, 0.487023;
	-0.704967, 0.540825;
	-0.843120, 0.560159;
	-0.982115, 0.541401;
	-1.106587, 0.487942;
	-1.211743, 0.405049;
	-1.292789, 0.297988;
	-1.344932, 0.172025;
	-1.255722, 0.032428;
	-1.241123, -0.078556;
	-1.199836, -0.178804;
	-1.135626, -0.264076;
	-1.052260, -0.330133;
	-0.953502, -0.372736;
	-0.843120, -0.387646;
	-0.733579, -0.372158;
	-0.635876, -0.329212;
	-0.553615, -0.263044;
	-0.490397, -0.177891;
	-0.449825, -0.077988;
	-0.435500, 0.032428;
	-0.449825, 0.142845;
	-0.490397, 0.242748;
	-0.553615, 0.327901;
	-0.635876, 0.394069;
	-0.733579, 0.437015;
	-0.843120, 0.452503;
	-0.953502, 0.437593;
	-1.052260, 0.394989;
	-1.135626, 0.328933;
	-1.199836, 0.243661;
	-1.241123, 0.143413;
	-1.087160, -0.657479;
	-1.083189, -0.687006;
	-1.071983, -0.713545;
	-1.054604, -0.736035;
	-1.032114, -0.753413;
	-1.005575, -0.764619;
	-0.976048, -0.768590;
	-0.946522, -0.764619;
	-0.919982, -0.753413;
	-0.897493, -0.736035;
	-0.880114, -0.713545;
	-0.868908, -0.687006;
	-0.864937, -0.657479;
	-0.868908, -0.627952;
	-0.880114, -0.601413;
	-0.897493, -0.578923;
	-0.919982, -0.561545;
	-0.946522, -0.550339;
	-0.976048, -0.546368;
	-1.005575, -0.550339;
	-1.032114, -0.561545;
	-1.054604, -0.578923;
	-1.071983, -0.601413;
	-1.083189, -0.627952;
	-0.805681, -0.661201;
	-0.801710, -0.690728;
	-0.790504, -0.717267;
	-0.773126, -0.739757;
	-0.750636, -0.757136;
	-0.724097, -0.768341;
	-0.694570, -0.772313;
	-0.665043, -0.768341;
	-0.638504, -0.757136;
	-0.616014, -0.739757;
	-0.598635, -0.717267;
	-0.587430, -0.690728;
	-0.583458, -0.661201;
	-0.587430, -0.631674;
	-0.598635, -0.605135;
	-0.616014, -0.582645;
	-0.638504, -0.565267;
	-0.665043, -0.554061;
	-0.694570, -0.550090;
	-0.724097, -0.554061;
	-0.750636, -0.565267;
	-0.773126, -0.582645;
	-0.790504, -0.605135;
	-0.801710, -0.631674;
	-0.295753, -0.482662;
	0.909552, -0.494394;
	-2.114572, -0.501354;
	-1.385875, 0.476925;
}
local logopoints = { }
for i = 1, #logocoords, 2 do
	logopoints[#logopoints+1] = lovelogo:add(logocoords[i], logocoords[i+1], math.random(255), math.random(255), math.random(255))
end
lovelogo:addIndices {
	logopoints[155], logopoints[125], logopoints[126]; 
	logopoints[155], logopoints[126], logopoints[154]; 
	logopoints[154], logopoints[126], logopoints[127]; 
	logopoints[154], logopoints[127], logopoints[153]; 
	logopoints[127], logopoints[128], logopoints[152]; 
	logopoints[127], logopoints[152], logopoints[153]; 
	logopoints[151], logopoints[152], logopoints[128]; 
	logopoints[151], logopoints[128], logopoints[129]; 
	logopoints[129], logopoints[130], logopoints[150]; 
	logopoints[129], logopoints[150], logopoints[151]; 
	logopoints[130], logopoints[131], logopoints[149]; 
	logopoints[130], logopoints[149], logopoints[150]; 
	logopoints[131], logopoints[132], logopoints[148]; 
	logopoints[131], logopoints[148], logopoints[149]; 
	logopoints[133], logopoints[147], logopoints[148]; 
	logopoints[133], logopoints[148], logopoints[132]; 
	logopoints[147], logopoints[133], logopoints[134]; 
	logopoints[147], logopoints[134], logopoints[146]; 
	logopoints[135], logopoints[145], logopoints[146]; 
	logopoints[135], logopoints[146], logopoints[134]; 
	logopoints[136], logopoints[144], logopoints[145]; 
	logopoints[136], logopoints[145], logopoints[135]; 
	logopoints[137], logopoints[143], logopoints[144]; 
	logopoints[137], logopoints[144], logopoints[136]; 
	logopoints[207], logopoints[183], logopoints[184]; 
	logopoints[207], logopoints[184], logopoints[208]; 
	logopoints[206], logopoints[182], logopoints[183]; 
	logopoints[206], logopoints[183], logopoints[207]; 
	logopoints[205], logopoints[181], logopoints[182]; 
	logopoints[205], logopoints[182], logopoints[206]; 
	logopoints[204], logopoints[180], logopoints[181]; 
	logopoints[204], logopoints[181], logopoints[205]; 
	logopoints[161], logopoints[185], logopoints[208]; 
	logopoints[161], logopoints[208], logopoints[184]; 
	logopoints[185], logopoints[161], logopoints[162]; 
	logopoints[185], logopoints[162], logopoints[186]; 
	logopoints[186], logopoints[162], logopoints[163]; 
	logopoints[186], logopoints[163], logopoints[187]; 
	logopoints[187], logopoints[163], logopoints[164]; 
	logopoints[187], logopoints[164], logopoints[188]; 
	logopoints[188], logopoints[164], logopoints[165]; 
	logopoints[188], logopoints[165], logopoints[189]; 
	logopoints[189], logopoints[165], logopoints[166]; 
	logopoints[189], logopoints[166], logopoints[190]; 
	logopoints[190], logopoints[166], logopoints[167]; 
	logopoints[190], logopoints[167], logopoints[191]; 
	logopoints[191], logopoints[167], logopoints[168]; 
	logopoints[191], logopoints[168], logopoints[192]; 
	logopoints[192], logopoints[168], logopoints[169]; 
	logopoints[192], logopoints[169], logopoints[193]; 
	logopoints[193], logopoints[169], logopoints[170]; 
	logopoints[193], logopoints[170], logopoints[194]; 
	logopoints[194], logopoints[170], logopoints[171]; 
	logopoints[194], logopoints[171], logopoints[195]; 
	logopoints[195], logopoints[171], logopoints[172]; 
	logopoints[195], logopoints[172], logopoints[196]; 
	logopoints[196], logopoints[172], logopoints[173]; 
	logopoints[196], logopoints[173], logopoints[197]; 
	logopoints[197], logopoints[173], logopoints[174]; 
	logopoints[197], logopoints[174], logopoints[198]; 
	logopoints[198], logopoints[174], logopoints[175]; 
	logopoints[198], logopoints[175], logopoints[199]; 
	logopoints[199], logopoints[175], logopoints[176]; 
	logopoints[199], logopoints[176], logopoints[200]; 
	logopoints[200], logopoints[176], logopoints[177]; 
	logopoints[200], logopoints[177], logopoints[201]; 
	logopoints[201], logopoints[177], logopoints[178]; 
	logopoints[201], logopoints[178], logopoints[202]; 
	logopoints[202], logopoints[178], logopoints[179]; 
	logopoints[202], logopoints[179], logopoints[203]; 
	logopoints[203], logopoints[179], logopoints[180]; 
	logopoints[203], logopoints[180], logopoints[204]; 
	logopoints[ 69], logopoints[118], logopoints[119]; 
	logopoints[ 69], logopoints[119], logopoints[ 68]; 
	logopoints[118], logopoints[ 69], logopoints[ 70]; 
	logopoints[118], logopoints[ 70], logopoints[117]; 
	logopoints[117], logopoints[ 70], logopoints[ 71]; 
	logopoints[117], logopoints[ 71], logopoints[116]; 
	logopoints[ 72], logopoints[115], logopoints[116]; 
	logopoints[ 72], logopoints[116], logopoints[ 71]; 
	logopoints[ 73], logopoints[114], logopoints[115]; 
	logopoints[ 73], logopoints[115], logopoints[ 72]; 
	logopoints[114], logopoints[ 73], logopoints[ 74]; 
	logopoints[114], logopoints[ 74], logopoints[113]; 
	logopoints[ 98], logopoints[ 90], logopoints[ 91]; 
	logopoints[ 98], logopoints[ 91], logopoints[ 97]; 
	logopoints[ 90], logopoints[ 98], logopoints[ 99]; 
	logopoints[ 90], logopoints[ 99], logopoints[ 89]; 
	logopoints[100], logopoints[ 88], logopoints[ 89]; 
	logopoints[100], logopoints[ 89], logopoints[ 99]; 
	logopoints[101], logopoints[ 87], logopoints[ 88]; 
	logopoints[101], logopoints[ 88], logopoints[100]; 
	logopoints[102], logopoints[ 86], logopoints[ 87]; 
	logopoints[102], logopoints[ 87], logopoints[101]; 
	logopoints[ 86], logopoints[102], logopoints[103]; 
	logopoints[ 86], logopoints[103], logopoints[ 85]; 
	logopoints[ 74], logopoints[ 75], logopoints[112]; 
	logopoints[ 74], logopoints[112], logopoints[113]; 
	logopoints[ 76], logopoints[111], logopoints[112]; 
	logopoints[ 76], logopoints[112], logopoints[ 75]; 
	logopoints[104], logopoints[ 84], logopoints[ 85]; 
	logopoints[104], logopoints[ 85], logopoints[103]; 
	logopoints[105], logopoints[ 83], logopoints[ 84]; 
	logopoints[105], logopoints[ 84], logopoints[104]; 
	logopoints[111], logopoints[ 76], logopoints[ 77]; 
	logopoints[111], logopoints[ 77], logopoints[110]; 
	logopoints[123], logopoints[124], logopoints[120]; 
	logopoints[123], logopoints[120], logopoints[121]; 
	logopoints[ 68], logopoints[119], logopoints[120]; 
	logopoints[ 68], logopoints[120], logopoints[124]; 
	logopoints[ 34], logopoints[ 28], logopoints[ 29]; 
	logopoints[ 34], logopoints[ 29], logopoints[ 33]; 
	logopoints[ 78], logopoints[ 79], logopoints[108]; 
	logopoints[ 78], logopoints[108], logopoints[109]; 
	logopoints[108], logopoints[ 79], logopoints[ 80]; 
	logopoints[108], logopoints[ 80], logopoints[107]; 
	logopoints[ 35], logopoints[ 27], logopoints[ 28]; 
	logopoints[ 35], logopoints[ 28], logopoints[ 34]; 
	logopoints[ 36], logopoints[ 26], logopoints[ 27]; 
	logopoints[ 36], logopoints[ 27], logopoints[ 35]; 
	logopoints[ 63], logopoints[ 66], logopoints[ 67]; 
	logopoints[ 63], logopoints[ 67], logopoints[ 62]; 
	logopoints[ 33], logopoints[ 29], logopoints[ 30]; 
	logopoints[ 33], logopoints[ 30], logopoints[ 32]; 
	logopoints[ 31], logopoints[ 81], logopoints[ 32]; 
	logopoints[ 31], logopoints[ 32], logopoints[ 30]; 
	logopoints[ 64], logopoints[ 65], logopoints[ 66]; 
	logopoints[ 64], logopoints[ 66], logopoints[ 63]; 
	logopoints[ 38], logopoints[ 39], logopoints[ 23]; 
	logopoints[ 38], logopoints[ 23], logopoints[ 24]; 
	logopoints[  1], logopoints[ 61], logopoints[ 62]; 
	logopoints[  1], logopoints[ 62], logopoints[ 67]; 
	logopoints[ 37], logopoints[ 25], logopoints[ 26]; 
	logopoints[ 37], logopoints[ 26], logopoints[ 36]; 
	logopoints[ 37], logopoints[ 38], logopoints[ 24]; 
	logopoints[ 37], logopoints[ 24], logopoints[ 25]; 
	logopoints[ 39], logopoints[ 40], logopoints[ 22]; 
	logopoints[ 39], logopoints[ 22], logopoints[ 23]; 
	logopoints[ 40], logopoints[ 41], logopoints[ 21]; 
	logopoints[ 40], logopoints[ 21], logopoints[ 22]; 
	logopoints[ 20], logopoints[ 21], logopoints[ 41]; 
	logopoints[ 20], logopoints[ 41], logopoints[ 42]; 
	logopoints[ 19], logopoints[ 20], logopoints[ 42]; 
	logopoints[ 19], logopoints[ 42], logopoints[ 43]; 
	logopoints[  9], logopoints[ 53], logopoints[ 54]; 
	logopoints[  9], logopoints[ 54], logopoints[  8]; 
	logopoints[ 17], logopoints[ 18], logopoints[ 44]; 
	logopoints[ 17], logopoints[ 44], logopoints[ 45]; 
	logopoints[ 45], logopoints[ 46], logopoints[ 16]; 
	logopoints[ 45], logopoints[ 16], logopoints[ 17]; 
	logopoints[ 46], logopoints[ 47], logopoints[ 15]; 
	logopoints[ 46], logopoints[ 15], logopoints[ 16]; 
	logopoints[ 47], logopoints[ 48], logopoints[ 14]; 
	logopoints[ 47], logopoints[ 14], logopoints[ 15]; 
	logopoints[ 49], logopoints[ 13], logopoints[ 14]; 
	logopoints[ 49], logopoints[ 14], logopoints[ 48]; 
	logopoints[ 13], logopoints[ 49], logopoints[ 50]; 
	logopoints[ 13], logopoints[ 50], logopoints[ 12]; 
	logopoints[ 11], logopoints[ 51], logopoints[ 52]; 
	logopoints[ 11], logopoints[ 52], logopoints[ 10]; 
	logopoints[ 10], logopoints[ 52], logopoints[ 53]; 
	logopoints[ 10], logopoints[ 53], logopoints[  9]; 
	logopoints[ 77], logopoints[ 78], logopoints[109]; 
	logopoints[ 77], logopoints[109], logopoints[110]; 
	logopoints[  8], logopoints[ 54], logopoints[ 55]; 
	logopoints[  8], logopoints[ 55], logopoints[  7]; 
	logopoints[  7], logopoints[ 55], logopoints[ 56]; 
	logopoints[  7], logopoints[ 56], logopoints[  6]; 
	logopoints[ 57], logopoints[  5], logopoints[  6]; 
	logopoints[ 57], logopoints[  6], logopoints[ 56]; 
	logopoints[ 58], logopoints[  4], logopoints[  5]; 
	logopoints[ 58], logopoints[  5], logopoints[ 57]; 
	logopoints[ 59], logopoints[  3], logopoints[  4]; 
	logopoints[ 59], logopoints[  4], logopoints[ 58]; 
	logopoints[ 60], logopoints[  2], logopoints[  3]; 
	logopoints[ 60], logopoints[  3], logopoints[ 59]; 
	logopoints[ 61], logopoints[  1], logopoints[  2]; 
	logopoints[ 61], logopoints[  2], logopoints[ 60]; 
	logopoints[ 51], logopoints[ 11], logopoints[ 12]; 
	logopoints[ 51], logopoints[ 12], logopoints[ 50]; 
	logopoints[ 43], logopoints[ 44], logopoints[ 18]; 
	logopoints[ 43], logopoints[ 18], logopoints[ 19]; 
	logopoints[106], logopoints[ 82], logopoints[ 83]; 
	logopoints[106], logopoints[ 83], logopoints[105]; 
	logopoints[107], logopoints[ 80], logopoints[ 82]; 
	logopoints[107], logopoints[ 82], logopoints[106]; 
	logopoints[122], logopoints[257], logopoints[123]; 
	logopoints[122], logopoints[123], logopoints[121]; 
	logopoints[ 97], logopoints[ 91], logopoints[ 92]; 
	logopoints[ 97], logopoints[ 92], logopoints[ 96]; 
	logopoints[ 93], logopoints[ 95], logopoints[ 96]; 
	logopoints[ 93], logopoints[ 96], logopoints[ 92]; 
	logopoints[ 94], logopoints[258], logopoints[ 95]; 
	logopoints[ 94], logopoints[ 95], logopoints[ 93]; 
	logopoints[125], logopoints[155], logopoints[156]; 
	logopoints[125], logopoints[156], logopoints[160]; 
	logopoints[160], logopoints[156], logopoints[157]; 
	logopoints[160], logopoints[157], logopoints[159]; 
	logopoints[159], logopoints[157], logopoints[158]; 
	logopoints[159], logopoints[158], logopoints[259]; 
	logopoints[143], logopoints[137], logopoints[138]; 
	logopoints[143], logopoints[138], logopoints[142]; 
	logopoints[142], logopoints[138], logopoints[139]; 
	logopoints[142], logopoints[139], logopoints[141]; 
	logopoints[139], logopoints[260], logopoints[140]; 
	logopoints[139], logopoints[140], logopoints[141]; 
	logopoints[227], logopoints[214], logopoints[215]; 
	logopoints[227], logopoints[215], logopoints[226]; 
	logopoints[216], logopoints[225], logopoints[226]; 
	logopoints[216], logopoints[226], logopoints[215]; 
	logopoints[217], logopoints[224], logopoints[225]; 
	logopoints[217], logopoints[225], logopoints[216]; 
	logopoints[224], logopoints[217], logopoints[218]; 
	logopoints[224], logopoints[218], logopoints[223]; 
	logopoints[219], logopoints[222], logopoints[223]; 
	logopoints[219], logopoints[223], logopoints[218]; 
	logopoints[220], logopoints[221], logopoints[222]; 
	logopoints[220], logopoints[222], logopoints[219]; 
	logopoints[228], logopoints[213], logopoints[214]; 
	logopoints[228], logopoints[214], logopoints[227]; 
	logopoints[213], logopoints[228], logopoints[229]; 
	logopoints[213], logopoints[229], logopoints[212]; 
	logopoints[212], logopoints[229], logopoints[230]; 
	logopoints[212], logopoints[230], logopoints[211]; 
	logopoints[231], logopoints[210], logopoints[211]; 
	logopoints[231], logopoints[211], logopoints[230]; 
	logopoints[232], logopoints[209], logopoints[210]; 
	logopoints[232], logopoints[210], logopoints[231]; 
	logopoints[251], logopoints[238], logopoints[239]; 
	logopoints[251], logopoints[239], logopoints[250]; 
	logopoints[250], logopoints[239], logopoints[240]; 
	logopoints[250], logopoints[240], logopoints[249]; 
	logopoints[249], logopoints[240], logopoints[241]; 
	logopoints[249], logopoints[241], logopoints[248]; 
	logopoints[242], logopoints[247], logopoints[248]; 
	logopoints[242], logopoints[248], logopoints[241]; 
	logopoints[247], logopoints[242], logopoints[243]; 
	logopoints[247], logopoints[243], logopoints[246]; 
	logopoints[246], logopoints[243], logopoints[244]; 
	logopoints[246], logopoints[244], logopoints[245]; 
	logopoints[238], logopoints[251], logopoints[252]; 
	logopoints[238], logopoints[252], logopoints[237]; 
	logopoints[237], logopoints[252], logopoints[253]; 
	logopoints[237], logopoints[253], logopoints[236]; 
	logopoints[254], logopoints[235], logopoints[236]; 
	logopoints[254], logopoints[236], logopoints[253]; 
	logopoints[255], logopoints[234], logopoints[235]; 
	logopoints[255], logopoints[235], logopoints[254]; 
	logopoints[256], logopoints[233], logopoints[234]; 
	logopoints[256], logopoints[234], logopoints[255]; 
}

return lovelogo