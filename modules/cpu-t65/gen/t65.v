module t65_alu_Brtl
  (input  [1:0] mode,
   input  bcd_en,
   input  [4:0] op,
   input  [7:0] busa,
   input  [7:0] busb,
   input  [7:0] p_in,
   output [7:0] p_out,
   output [7:0] q);
  wire adc_z;
  wire adc_c;
  wire adc_v;
  wire adc_n;
  wire [7:0] adc_q;
  wire sbc_z;
  wire sbc_c;
  wire sbc_v;
  wire sbc_n;
  wire [7:0] sbc_q;
  wire [7:0] sbx_q;
  wire [3:0] n3029;
  wire n3030;
  wire [4:0] n3031;
  wire [6:0] n3032;
  wire [3:0] n3033;
  wire [4:0] n3035;
  wire [6:0] n3036;
  wire [6:0] n3037;
  wire [3:0] n3038;
  wire n3039;
  wire [4:0] n3040;
  wire [6:0] n3041;
  wire [3:0] n3042;
  wire [4:0] n3044;
  wire [6:0] n3045;
  wire [6:0] n3046;
  wire [3:0] n3047;
  wire [30:0] n3048;
  wire n3050;
  wire [3:0] n3051;
  wire [30:0] n3052;
  wire n3054;
  wire n3055;
  wire n3058;
  wire [4:0] n3059;
  wire [30:0] n3060;
  wire n3062;
  wire n3063;
  wire n3064;
  wire n3065;
  wire [5:0] n3066;
  wire [5:0] n3068;
  wire [5:0] n3069;
  wire [5:0] n3070;
  wire n3071;
  wire [6:0] n3072;
  wire n3073;
  wire [6:0] n3074;
  wire n3075;
  wire n3076;
  wire [3:0] n3077;
  wire [4:0] n3078;
  wire [6:0] n3079;
  wire [3:0] n3080;
  wire [4:0] n3082;
  wire [6:0] n3083;
  wire [6:0] n3084;
  wire n3085;
  wire n3086;
  wire n3087;
  wire n3088;
  wire n3089;
  wire n3090;
  wire n3091;
  wire n3092;
  wire n3093;
  wire [4:0] n3094;
  wire [30:0] n3095;
  wire n3097;
  wire n3098;
  wire n3099;
  wire n3100;
  wire [5:0] n3101;
  wire [5:0] n3103;
  wire [5:0] n3104;
  wire [5:0] n3105;
  wire n3106;
  wire [6:0] n3107;
  wire n3108;
  wire [6:0] n3109;
  wire n3110;
  wire n3111;
  wire [6:0] n3112;
  wire [3:0] n3113;
  wire [6:0] n3114;
  wire [3:0] n3115;
  wire [7:0] n3116;
  wire n3127;
  wire n3129;
  wire n3130;
  wire n3132;
  wire n3133;
  wire n3135;
  wire n3136;
  wire n3138;
  wire n3139;
  wire n3141;
  wire n3142;
  wire n3144;
  wire n3145;
  wire n3148;
  wire n3150;
  wire n3151;
  wire n3152;
  wire [3:0] n3153;
  wire [4:0] n3154;
  wire [6:0] n3155;
  wire [3:0] n3156;
  wire [4:0] n3158;
  wire [5:0] n3159;
  wire [6:0] n3160;
  wire [6:0] n3161;
  wire [3:0] n3162;
  wire [4:0] n3164;
  wire [5:0] n3165;
  wire [3:0] n3166;
  wire n3167;
  wire [4:0] n3168;
  wire [5:0] n3169;
  wire [5:0] n3170;
  wire [3:0] n3171;
  wire [30:0] n3172;
  wire n3174;
  wire [3:0] n3175;
  wire [30:0] n3176;
  wire n3178;
  wire n3179;
  wire n3182;
  wire n3183;
  wire n3184;
  wire n3185;
  wire n3186;
  wire n3187;
  wire n3188;
  wire n3189;
  wire n3190;
  wire n3191;
  wire n3192;
  wire [3:0] n3193;
  wire [3:0] n3194;
  wire [7:0] n3195;
  wire n3196;
  wire n3197;
  wire n3198;
  wire [4:0] n3199;
  wire [4:0] n3201;
  wire [4:0] n3202;
  wire [4:0] n3203;
  wire [3:0] n3204;
  wire [4:0] n3206;
  wire [5:0] n3207;
  wire [3:0] n3208;
  wire n3209;
  wire n3210;
  wire [6:0] n3211;
  wire n3212;
  wire [4:0] n3213;
  wire [5:0] n3214;
  wire [5:0] n3215;
  wire n3216;
  wire [4:0] n3217;
  wire [4:0] n3219;
  wire [4:0] n3220;
  wire [4:0] n3221;
  wire n3222;
  wire [4:0] n3223;
  wire [4:0] n3224;
  wire n3225;
  wire n3226;
  wire [5:0] n3227;
  wire [5:0] n3228;
  wire [3:0] n3229;
  wire [6:0] n3230;
  wire [3:0] n3231;
  wire [7:0] n3232;
  wire [7:0] n3239;
  wire n3241;
  wire [7:0] n3242;
  wire n3244;
  wire [7:0] n3245;
  wire n3247;
  wire n3249;
  wire n3251;
  wire n3253;
  wire n3255;
  wire [6:0] n3256;
  wire [7:0] n3258;
  wire n3259;
  wire n3261;
  wire [6:0] n3262;
  wire n3263;
  wire [7:0] n3264;
  wire n3265;
  wire n3267;
  wire [6:0] n3268;
  wire [7:0] n3270;
  wire n3271;
  wire n3273;
  wire n3274;
  wire [6:0] n3275;
  wire [7:0] n3276;
  wire n3277;
  wire n3279;
  wire n3280;
  wire [6:0] n3281;
  wire [6:0] n3282;
  wire [6:0] n3283;
  wire [7:0] n3284;
  wire n3285;
  wire n3286;
  wire n3287;
  wire n3288;
  wire n3289;
  wire [3:0] n3290;
  wire [3:0] n3291;
  wire [3:0] n3292;
  wire n3294;
  wire [3:0] n3295;
  wire [3:0] n3297;
  wire [3:0] n3298;
  wire [3:0] n3299;
  wire [3:0] n3300;
  wire [3:0] n3301;
  wire [3:0] n3302;
  wire n3304;
  wire [3:0] n3305;
  wire [3:0] n3307;
  wire n3310;
  wire [3:0] n3311;
  wire [3:0] n3312;
  wire n3313;
  wire n3314;
  wire [7:0] n3315;
  wire [7:0] n3316;
  wire n3318;
  wire n3319;
  wire n3321;
  wire [7:0] n3323;
  wire n3325;
  wire [7:0] n3327;
  wire n3329;
  wire [14:0] n3330;
  wire n3331;
  reg n3332;
  wire n3333;
  reg n3334;
  wire n3336;
  reg [7:0] n3338;
  reg [7:0] n3339;
  wire n3341;
  wire n3343;
  wire n3345;
  wire n3346;
  wire n3348;
  wire n3349;
  wire n3351;
  wire n3352;
  wire [7:0] n3353;
  wire n3355;
  wire n3358;
  wire n3360;
  wire n3361;
  wire n3362;
  wire n3364;
  wire n3367;
  wire n3369;
  wire n3370;
  wire n3372;
  wire n3375;
  wire [4:0] n3376;
  reg n3377;
  wire n3378;
  reg n3379;
  reg n3380;
  wire [3:0] n3381;
  wire n3383;
  wire [7:0] n3384;
  wire [7:0] n3386;
  assign p_out = n3386; //(module output)
  assign q = n3384; //(module output)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:73:15 */
  assign adc_z = n3058; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:74:15 */
  assign adc_c = n3111; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:75:15 */
  assign adc_v = n3093; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:76:15 */
  assign adc_n = n3085; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:77:15 */
  assign adc_q = n3116; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:78:15 */
  assign sbc_z = n3182; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:79:15 */
  assign sbc_c = n3184; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:80:15 */
  assign sbc_v = n3191; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:81:15 */
  assign sbc_n = n3192; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:82:15 */
  assign sbc_q = n3232; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:83:15 */
  assign sbx_q = n3195; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:92:31 */
  assign n3029 = busa[3:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:92:50 */
  assign n3030 = p_in[0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:92:44 */
  assign n3031 = {n3029, n3030};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:92:11 */
  assign n3032 = {2'b0, n3031};  // uext
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:92:86 */
  assign n3033 = busb[3:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:92:99 */
  assign n3035 = {n3033, 1'b1};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:92:66 */
  assign n3036 = {2'b0, n3035};  // uext
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:92:64 */
  assign n3037 = n3032 + n3036;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:93:31 */
  assign n3038 = busa[7:4]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:93:48 */
  assign n3039 = n3037[5]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:93:44 */
  assign n3040 = {n3038, n3039};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:93:11 */
  assign n3041 = {2'b0, n3040};  // uext
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:93:79 */
  assign n3042 = busb[7:4]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:93:92 */
  assign n3044 = {n3042, 1'b1};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:93:59 */
  assign n3045 = {2'b0, n3044};  // uext
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:93:57 */
  assign n3046 = n3041 + n3045;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:100:10 */
  assign n3047 = n3037[4:1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:100:23 */
  assign n3048 = {27'b0, n3047};  // uext
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:100:23 */
  assign n3050 = n3048 == 31'b0000000000000000000000000000000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:100:33 */
  assign n3051 = n3046[4:1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:100:46 */
  assign n3052 = {27'b0, n3051};  // uext
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:100:46 */
  assign n3054 = n3052 == 31'b0000000000000000000000000000000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:100:27 */
  assign n3055 = n3054 & n3050;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:100:5 */
  assign n3058 = n3055 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:106:10 */
  assign n3059 = n3037[5:1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:106:23 */
  assign n3060 = {26'b0, n3059};  // uext
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:106:23 */
  assign n3062 = $unsigned(n3060) > $unsigned(31'b0000000000000000000000000001001);
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:106:35 */
  assign n3063 = p_in[3]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:106:27 */
  assign n3064 = n3063 & n3062;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:106:50 */
  assign n3065 = bcd_en & n3064;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:107:27 */
  assign n3066 = n3037[6:1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:107:40 */
  assign n3068 = n3066 + 6'b000110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:88:14 */
  assign n3069 = n3037[6:1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:106:5 */
  assign n3070 = n3065 ? n3068 : n3069;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:88:14 */
  assign n3071 = n3037[0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:88:14 */
  assign n3072 = {n3070, n3071};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:110:12 */
  assign n3073 = n3072[6]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:88:14 */
  assign n3074 = {n3070, n3071};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:110:21 */
  assign n3075 = n3074[5]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:110:16 */
  assign n3076 = n3073 | n3075;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:111:31 */
  assign n3077 = busa[7:4]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:111:44 */
  assign n3078 = {n3077, n3076};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:111:11 */
  assign n3079 = {2'b0, n3078};  // uext
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:111:75 */
  assign n3080 = busb[7:4]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:111:88 */
  assign n3082 = {n3080, 1'b1};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:111:55 */
  assign n3083 = {2'b0, n3082};  // uext
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:111:53 */
  assign n3084 = n3079 + n3083;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:113:16 */
  assign n3085 = n3084[4]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:114:17 */
  assign n3086 = n3084[4]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:114:29 */
  assign n3087 = busa[7]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:114:21 */
  assign n3088 = n3086 ^ n3087;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:114:47 */
  assign n3089 = busa[7]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:114:59 */
  assign n3090 = busb[7]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:114:51 */
  assign n3091 = n3089 ^ n3090;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:114:38 */
  assign n3092 = ~n3091;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:114:34 */
  assign n3093 = n3088 & n3092;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:120:10 */
  assign n3094 = n3084[5:1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:120:23 */
  assign n3095 = {26'b0, n3094};  // uext
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:120:23 */
  assign n3097 = $unsigned(n3095) > $unsigned(31'b0000000000000000000000000001001);
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:120:35 */
  assign n3098 = p_in[3]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:120:27 */
  assign n3099 = n3098 & n3097;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:120:50 */
  assign n3100 = bcd_en & n3099;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:121:27 */
  assign n3101 = n3084[6:1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:121:40 */
  assign n3103 = n3101 + 6'b000110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:89:14 */
  assign n3104 = n3084[6:1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:120:5 */
  assign n3105 = n3100 ? n3103 : n3104;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:89:14 */
  assign n3106 = n3084[0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:89:14 */
  assign n3107 = {n3105, n3106};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:124:16 */
  assign n3108 = n3107[6]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:89:14 */
  assign n3109 = {n3105, n3106};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:124:25 */
  assign n3110 = n3109[5]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:124:20 */
  assign n3111 = n3108 | n3110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:89:14 */
  assign n3112 = {n3105, n3106};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:126:33 */
  assign n3113 = n3112[4:1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:88:14 */
  assign n3114 = {n3070, n3071};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:126:50 */
  assign n3115 = n3114[4:1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:126:46 */
  assign n3116 = {n3113, n3115};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:136:12 */
  assign n3127 = op == 5'b00001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:137:12 */
  assign n3129 = op == 5'b00011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:136:24 */
  assign n3130 = n3127 | n3129;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:138:12 */
  assign n3132 = op == 5'b00101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:137:24 */
  assign n3133 = n3130 | n3132;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:139:12 */
  assign n3135 = op == 5'b00111;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:138:24 */
  assign n3136 = n3133 | n3135;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:140:12 */
  assign n3138 = op == 5'b01001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:139:24 */
  assign n3139 = n3136 | n3138;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:141:12 */
  assign n3141 = op == 5'b01011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:140:24 */
  assign n3142 = n3139 | n3141;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:143:12 */
  assign n3144 = op == 5'b01110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:141:24 */
  assign n3145 = n3142 | n3144;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:136:5 */
  assign n3148 = n3145 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:148:14 */
  assign n3150 = p_in[0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:148:26 */
  assign n3151 = ~n3148;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:148:23 */
  assign n3152 = n3150 | n3151;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:149:31 */
  assign n3153 = busa[3:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:149:44 */
  assign n3154 = {n3153, n3152};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:149:11 */
  assign n3155 = {2'b0, n3154};  // uext
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:149:75 */
  assign n3156 = busb[3:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:149:88 */
  assign n3158 = {n3156, 1'b1};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:149:55 */
  assign n3159 = {1'b0, n3158};  // uext
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:149:53 */
  assign n3160 = {1'b0, n3159};  // uext
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:149:53 */
  assign n3161 = n3155 - n3160;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:150:31 */
  assign n3162 = busa[7:4]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:150:44 */
  assign n3164 = {n3162, 1'b0};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:150:11 */
  assign n3165 = {1'b0, n3164};  // uext
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:150:77 */
  assign n3166 = busb[7:4]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:150:94 */
  assign n3167 = n3161[5]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:150:90 */
  assign n3168 = {n3166, n3167};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:150:57 */
  assign n3169 = {1'b0, n3168};  // uext
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:150:55 */
  assign n3170 = n3165 - n3169;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:157:10 */
  assign n3171 = n3161[4:1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:157:23 */
  assign n3172 = {27'b0, n3171};  // uext
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:157:23 */
  assign n3174 = n3172 == 31'b0000000000000000000000000000000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:157:33 */
  assign n3175 = n3170[4:1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:157:46 */
  assign n3176 = {27'b0, n3175};  // uext
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:157:46 */
  assign n3178 = n3176 == 31'b0000000000000000000000000000000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:157:27 */
  assign n3179 = n3178 & n3174;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:157:5 */
  assign n3182 = n3179 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:163:20 */
  assign n3183 = n3170[5]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:163:14 */
  assign n3184 = ~n3183;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:164:17 */
  assign n3185 = n3170[4]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:164:29 */
  assign n3186 = busa[7]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:164:21 */
  assign n3187 = n3185 ^ n3186;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:164:43 */
  assign n3188 = busa[7]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:164:55 */
  assign n3189 = busb[7]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:164:47 */
  assign n3190 = n3188 ^ n3189;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:164:34 */
  assign n3191 = n3187 & n3190;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:165:16 */
  assign n3192 = n3170[4]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:167:33 */
  assign n3193 = n3170[4:1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:167:50 */
  assign n3194 = n3161[4:1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:167:46 */
  assign n3195 = {n3193, n3194};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:169:12 */
  assign n3196 = p_in[3]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:169:27 */
  assign n3197 = bcd_en & n3196;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:170:12 */
  assign n3198 = n3161[5]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:171:29 */
  assign n3199 = n3161[5:1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:171:42 */
  assign n3201 = n3199 - 5'b00110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:130:14 */
  assign n3202 = n3161[5:1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:170:7 */
  assign n3203 = n3198 ? n3201 : n3202;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:173:33 */
  assign n3204 = busa[7:4]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:173:46 */
  assign n3206 = {n3204, 1'b0};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:173:13 */
  assign n3207 = {1'b0, n3206};  // uext
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:173:79 */
  assign n3208 = busb[7:4]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:130:14 */
  assign n3209 = n3161[0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:130:14 */
  assign n3210 = n3161[6]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:130:14 */
  assign n3211 = {n3210, n3203, n3209};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:173:96 */
  assign n3212 = n3211[6]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:173:92 */
  assign n3213 = {n3208, n3212};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:173:59 */
  assign n3214 = {1'b0, n3213};  // uext
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:173:57 */
  assign n3215 = n3207 - n3214;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:174:12 */
  assign n3216 = n3215[5]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:175:29 */
  assign n3217 = n3215[5:1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:175:42 */
  assign n3219 = n3217 - 5'b00110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:131:14 */
  assign n3220 = n3215[5:1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:174:7 */
  assign n3221 = n3216 ? n3219 : n3220;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:131:14 */
  assign n3222 = n3215[0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:130:14 */
  assign n3223 = n3161[5:1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:169:5 */
  assign n3224 = n3197 ? n3203 : n3223;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:130:14 */
  assign n3225 = n3161[6]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:130:14 */
  assign n3226 = n3161[0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:169:5 */
  assign n3227 = {n3221, n3222};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:169:5 */
  assign n3228 = n3197 ? n3227 : n3170;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:179:33 */
  assign n3229 = n3228[4:1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:130:14 */
  assign n3230 = {n3225, n3224, n3226};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:179:50 */
  assign n3231 = n3230[4:1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:179:46 */
  assign n3232 = {n3229, n3231};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:196:21 */
  assign n3239 = busa | busb;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:195:7 */
  assign n3241 = op == 5'b00000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:198:21 */
  assign n3242 = busa & busb;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:197:7 */
  assign n3244 = op == 5'b00001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:200:21 */
  assign n3245 = busa ^ busb;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:199:7 */
  assign n3247 = op == 5'b00010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:201:7 */
  assign n3249 = op == 5'b00011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:205:7 */
  assign n3251 = op == 5'b00110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:207:7 */
  assign n3253 = op == 5'b10001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:210:7 */
  assign n3255 = op == 5'b00111;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:215:20 */
  assign n3256 = busa[6:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:215:33 */
  assign n3258 = {n3256, 1'b0};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:216:30 */
  assign n3259 = busa[7]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:214:7 */
  assign n3261 = op == 5'b01000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:218:20 */
  assign n3262 = busa[6:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:218:39 */
  assign n3263 = p_in[0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:218:33 */
  assign n3264 = {n3262, n3263};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:219:30 */
  assign n3265 = busa[7]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:217:7 */
  assign n3267 = op == 5'b01001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:221:26 */
  assign n3268 = busa[7:1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:221:20 */
  assign n3270 = {1'b0, n3268};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:222:30 */
  assign n3271 = busa[0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:220:7 */
  assign n3273 = op == 5'b01010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:224:20 */
  assign n3274 = p_in[0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:224:35 */
  assign n3275 = busa[7:1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:224:29 */
  assign n3276 = {n3274, n3275};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:225:30 */
  assign n3277 = busa[0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:223:7 */
  assign n3279 = op == 5'b01011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:227:20 */
  assign n3280 = p_in[0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:227:36 */
  assign n3281 = busa[7:1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:227:57 */
  assign n3282 = busb[7:1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:227:49 */
  assign n3283 = n3281 & n3282;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:227:29 */
  assign n3284 = {n3280, n3283};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:228:29 */
  assign n3285 = n3284[5]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:228:40 */
  assign n3286 = n3284[6]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:228:33 */
  assign n3287 = n3285 ^ n3286;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:230:16 */
  assign n3288 = p_in[3]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:230:29 */
  assign n3289 = bcd_en & n3288;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:231:19 */
  assign n3290 = busa[3:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:231:40 */
  assign n3291 = busb[3:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:231:32 */
  assign n3292 = n3290 & n3291;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:231:54 */
  assign n3294 = $unsigned(n3292) > $unsigned(4'b0100);
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:232:62 */
  assign n3295 = n3284[3:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:232:76 */
  assign n3297 = n3295 + 4'b0110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:187:14 */
  assign n3298 = n3284[3:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:231:11 */
  assign n3299 = n3294 ? n3297 : n3298;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:234:19 */
  assign n3300 = busa[7:4]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:234:40 */
  assign n3301 = busb[7:4]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:234:32 */
  assign n3302 = n3300 & n3301;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:234:54 */
  assign n3304 = $unsigned(n3302) > $unsigned(4'b0100);
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:235:62 */
  assign n3305 = n3284[7:4]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:235:76 */
  assign n3307 = n3305 + 4'b0110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:234:11 */
  assign n3310 = n3304 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:187:14 */
  assign n3311 = n3284[7:4]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:234:11 */
  assign n3312 = n3304 ? n3307 : n3311;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:241:31 */
  assign n3313 = n3284[6]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:230:9 */
  assign n3314 = n3289 ? n3310 : n3313;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:230:9 */
  assign n3315 = {n3312, n3299};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:230:9 */
  assign n3316 = n3289 ? n3315 : n3284;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:226:7 */
  assign n3318 = op == 5'b01111;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:244:30 */
  assign n3319 = busb[6]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:243:7 */
  assign n3321 = op == 5'b01100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:246:48 */
  assign n3323 = busa - 8'b00000001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:245:7 */
  assign n3325 = op == 5'b01101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:248:48 */
  assign n3327 = busa + 8'b00000001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:247:7 */
  assign n3329 = op == 5'b01110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:194:5 */
  assign n3330 = {n3329, n3325, n3321, n3318, n3279, n3273, n3267, n3261, n3255, n3253, n3251, n3249, n3247, n3244, n3241};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:65:5 */
  assign n3331 = p_in[0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:194:5 */
  always @*
    case (n3330)
      15'b100000000000000: n3332 = n3331;
      15'b010000000000000: n3332 = n3331;
      15'b001000000000000: n3332 = n3331;
      15'b000100000000000: n3332 = n3314;
      15'b000010000000000: n3332 = n3277;
      15'b000001000000000: n3332 = n3271;
      15'b000000100000000: n3332 = n3265;
      15'b000000010000000: n3332 = n3259;
      15'b000000001000000: n3332 = sbc_c;
      15'b000000000100000: n3332 = sbc_c;
      15'b000000000010000: n3332 = sbc_c;
      15'b000000000001000: n3332 = adc_c;
      15'b000000000000100: n3332 = n3331;
      15'b000000000000010: n3332 = n3331;
      15'b000000000000001: n3332 = n3331;
      default: n3332 = n3331;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:65:5 */
  assign n3333 = p_in[6]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:194:5 */
  always @*
    case (n3330)
      15'b100000000000000: n3334 = n3333;
      15'b010000000000000: n3334 = n3333;
      15'b001000000000000: n3334 = n3319;
      15'b000100000000000: n3334 = n3287;
      15'b000010000000000: n3334 = n3333;
      15'b000001000000000: n3334 = n3333;
      15'b000000100000000: n3334 = n3333;
      15'b000000010000000: n3334 = n3333;
      15'b000000001000000: n3334 = sbc_v;
      15'b000000000100000: n3334 = n3333;
      15'b000000000010000: n3334 = n3333;
      15'b000000000001000: n3334 = adc_v;
      15'b000000000000100: n3334 = n3333;
      15'b000000000000010: n3334 = n3333;
      15'b000000000000001: n3334 = n3333;
      default: n3334 = n3333;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:65:5 */
  assign n3336 = p_in[7]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:194:5 */
  always @*
    case (n3330)
      15'b100000000000000: n3338 = n3327;
      15'b010000000000000: n3338 = n3323;
      15'b001000000000000: n3338 = busa;
      15'b000100000000000: n3338 = n3284;
      15'b000010000000000: n3338 = n3276;
      15'b000001000000000: n3338 = n3270;
      15'b000000100000000: n3338 = n3264;
      15'b000000010000000: n3338 = n3258;
      15'b000000001000000: n3338 = sbc_q;
      15'b000000000100000: n3338 = sbx_q;
      15'b000000000010000: n3338 = busa;
      15'b000000000001000: n3338 = adc_q;
      15'b000000000000100: n3338 = n3245;
      15'b000000000000010: n3338 = n3242;
      15'b000000000000001: n3338 = n3239;
      default: n3338 = busa;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:194:5 */
  always @*
    case (n3330)
      15'b100000000000000: n3339 = busa;
      15'b010000000000000: n3339 = busa;
      15'b001000000000000: n3339 = busa;
      15'b000100000000000: n3339 = n3316;
      15'b000010000000000: n3339 = busa;
      15'b000001000000000: n3339 = busa;
      15'b000000100000000: n3339 = busa;
      15'b000000010000000: n3339 = busa;
      15'b000000001000000: n3339 = busa;
      15'b000000000100000: n3339 = busa;
      15'b000000000010000: n3339 = busa;
      15'b000000000001000: n3339 = busa;
      15'b000000000000100: n3339 = busa;
      15'b000000000000010: n3339 = busa;
      15'b000000000000001: n3339 = busa;
      default: n3339 = busa;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:255:7 */
  assign n3341 = op == 5'b00011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:258:7 */
  assign n3343 = op == 5'b00110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:258:22 */
  assign n3345 = op == 5'b00111;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:258:22 */
  assign n3346 = n3343 | n3345;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:258:33 */
  assign n3348 = op == 5'b10001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:258:33 */
  assign n3349 = n3346 | n3348;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:261:7 */
  assign n3351 = op == 5'b00100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:263:30 */
  assign n3352 = busb[7]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:264:18 */
  assign n3353 = busa & busb;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:264:28 */
  assign n3355 = n3353 == 8'b00000000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:264:9 */
  assign n3358 = n3355 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:262:7 */
  assign n3360 = op == 5'b01100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:270:29 */
  assign n3361 = n3338[7]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:271:29 */
  assign n3362 = n3338[7]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:272:16 */
  assign n3364 = n3338 == 8'b00000000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:272:9 */
  assign n3367 = n3364 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:269:7 */
  assign n3369 = op == 5'b10000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:278:29 */
  assign n3370 = n3338[7]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:279:16 */
  assign n3372 = n3338 == 8'b00000000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:279:9 */
  assign n3375 = n3372 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:254:5 */
  assign n3376 = {n3369, n3360, n3351, n3349, n3341};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:254:5 */
  always @*
    case (n3376)
      5'b10000: n3377 = n3362;
      5'b01000: n3377 = n3332;
      5'b00100: n3377 = n3332;
      5'b00010: n3377 = n3332;
      5'b00001: n3377 = n3332;
      default: n3377 = n3332;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:65:5 */
  assign n3378 = p_in[1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:254:5 */
  always @*
    case (n3376)
      5'b10000: n3379 = n3367;
      5'b01000: n3379 = n3358;
      5'b00100: n3379 = n3378;
      5'b00010: n3379 = sbc_z;
      5'b00001: n3379 = adc_z;
      default: n3379 = n3375;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:254:5 */
  always @*
    case (n3376)
      5'b10000: n3380 = n3361;
      5'b01000: n3380 = n3352;
      5'b00100: n3380 = n3336;
      5'b00010: n3380 = sbc_n;
      5'b00001: n3380 = adc_n;
      default: n3380 = n3370;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:65:5 */
  assign n3381 = p_in[5:2]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:286:10 */
  assign n3383 = op == 5'b01111;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:286:5 */
  assign n3384 = n3383 ? n3339 : n3338;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_ALU.vhd:65:5 */
  assign n3386 = {n3380, n3334, n3381, n3379, n3377};
endmodule

module t65_mcode_Brtl
  (input  [1:0] mode,
   input  [7:0] ir,
   input  [2:0] mcycle,
   input  [7:0] p,
   output [2:0] lcycle,
   output [4:0] alu_op,
   output [3:0] set_busa_to,
   output [1:0] set_addr_to,
   output [3:0] write_data,
   output [1:0] jump,
   output [1:0] baadd,
   output breakatna,
   output adadd,
   output addy,
   output pcadd,
   output inc_s,
   output dec_s,
   output lda,
   output ldp,
   output ldx,
   output ldy,
   output lds,
   output lddi,
   output ldalu,
   output ldad,
   output ldbal,
   output ldbah,
   output savep,
   output write);
  wire branch;
  wire alumore;
  wire [2:0] n882;
  wire n883;
  wire n884;
  wire n886;
  wire n887;
  wire n889;
  wire n890;
  wire n891;
  wire n893;
  wire n894;
  wire n896;
  wire n897;
  wire n898;
  wire n900;
  wire n901;
  wire n903;
  wire n904;
  wire n905;
  wire n907;
  wire n908;
  wire [6:0] n909;
  reg n910;
  wire [2:0] n913;
  wire [1:0] n914;
  wire [2:0] n915;
  wire n917;
  wire [3:0] n920;
  wire n922;
  wire [2:0] n923;
  wire n925;
  wire [3:0] n928;
  wire n930;
  wire [2:0] n931;
  wire n933;
  wire [3:0] n936;
  wire n939;
  wire [2:0] n940;
  wire n942;
  wire [2:0] n943;
  wire n945;
  wire n946;
  wire [2:0] n947;
  wire n949;
  wire n950;
  wire [3:0] n953;
  wire n955;
  wire [2:0] n956;
  reg [3:0] n960;
  reg [3:0] n962;
  reg n964;
  wire n966;
  wire [1:0] n967;
  wire n968;
  wire n970;
  wire n971;
  wire n973;
  wire n974;
  wire n977;
  wire n979;
  wire n981;
  wire n983;
  wire [2:0] n984;
  wire n986;
  wire [3:0] n989;
  wire n992;
  wire [2:0] n993;
  reg [3:0] n995;
  reg n1000;
  reg n1004;
  reg n1006;
  reg n1008;
  wire n1010;
  wire [1:0] n1011;
  wire n1012;
  wire n1013;
  wire n1016;
  wire n1018;
  reg [3:0] n1021;
  reg n1023;
  wire n1025;
  wire [1:0] n1026;
  wire n1027;
  wire n1028;
  wire n1031;
  wire n1033;
  reg [3:0] n1036;
  reg n1038;
  wire n1040;
  wire [3:0] n1041;
  reg [3:0] n1043;
  reg [3:0] n1046;
  reg n1049;
  reg n1052;
  reg n1055;
  reg n1058;
  wire [1:0] n1060;
  wire n1062;
  wire n1063;
  wire n1064;
  wire n1066;
  wire n1067;
  wire n1068;
  wire n1069;
  wire n1070;
  wire n1072;
  wire [3:0] n1075;
  wire [3:0] n1076;
  wire [4:0] n1077;
  wire n1079;
  wire n1081;
  wire n1083;
  wire n1085;
  wire n1087;
  wire n1089;
  wire [5:0] n1090;
  reg [1:0] n1097;
  reg [3:0] n1101;
  reg [1:0] n1104;
  reg n1109;
  reg n1112;
  reg n1117;
  wire n1119;
  wire n1121;
  wire n1123;
  wire n1125;
  wire n1127;
  wire n1129;
  wire [4:0] n1130;
  reg [1:0] n1135;
  reg [3:0] n1138;
  reg [1:0] n1142;
  reg n1146;
  reg n1149;
  reg n1153;
  wire n1155;
  wire n1157;
  wire n1159;
  wire n1161;
  wire n1163;
  wire n1165;
  wire [4:0] n1166;
  reg [3:0] n1168;
  reg [1:0] n1174;
  reg [1:0] n1177;
  reg n1182;
  reg n1185;
  reg n1188;
  wire n1190;
  wire n1192;
  wire n1194;
  wire n1196;
  wire n1198;
  wire n1200;
  wire [4:0] n1201;
  reg [1:0] n1206;
  reg [1:0] n1210;
  reg n1214;
  reg n1217;
  wire n1219;
  wire n1221;
  wire n1222;
  wire n1223;
  wire [2:0] n1226;
  wire n1229;
  wire n1230;
  wire n1231;
  wire n1232;
  wire [3:0] n1233;
  wire n1235;
  wire n1237;
  wire n1239;
  wire [3:0] n1241;
  wire n1244;
  wire n1246;
  wire n1248;
  wire [3:0] n1250;
  wire n1253;
  wire n1255;
  wire [3:0] n1256;
  reg [3:0] n1259;
  reg n1261;
  wire [1:0] n1265;
  wire [3:0] n1266;
  wire n1268;
  wire n1270;
  wire n1272;
  wire [1:0] n1273;
  reg [1:0] n1275;
  reg [3:0] n1276;
  reg n1279;
  reg n1281;
  wire n1283;
  wire n1285;
  wire n1286;
  wire n1288;
  wire n1289;
  wire n1291;
  wire n1292;
  wire n1294;
  wire n1295;
  wire n1296;
  wire [2:0] n1299;
  wire [3:0] n1301;
  wire n1303;
  wire n1305;
  wire n1307;
  wire n1309;
  wire n1311;
  wire n1313;
  wire n1315;
  wire n1317;
  wire [3:0] n1318;
  reg n1320;
  reg n1323;
  reg n1324;
  reg n1325;
  wire n1327;
  wire n1328;
  wire n1329;
  wire n1330;
  wire n1333;
  wire n1335;
  wire n1337;
  wire n1338;
  wire n1339;
  wire n1340;
  wire [1:0] n1343;
  wire n1345;
  wire n1347;
  wire n1349;
  wire n1351;
  wire [3:0] n1352;
  reg [3:0] n1354;
  reg [1:0] n1357;
  reg n1360;
  reg n1362;
  reg n1364;
  wire n1366;
  wire n1368;
  wire n1369;
  wire n1371;
  wire n1372;
  wire n1374;
  wire n1375;
  wire n1377;
  wire n1379;
  wire [1:0] n1380;
  reg [1:0] n1383;
  wire n1385;
  wire n1387;
  wire n1388;
  wire n1390;
  wire n1391;
  wire n1393;
  wire n1395;
  wire [1:0] n1396;
  reg [3:0] n1398;
  wire n1400;
  wire n1402;
  wire n1404;
  wire [1:0] n1405;
  reg [3:0] n1407;
  wire n1409;
  wire n1411;
  wire n1413;
  wire n1415;
  wire n1417;
  wire [1:0] n1418;
  reg [3:0] n1420;
  wire n1422;
  wire n1424;
  wire n1425;
  wire n1432;
  wire n1434;
  wire n1435;
  wire n1437;
  wire n1438;
  wire n1440;
  wire n1441;
  wire n1448;
  wire n1450;
  wire n1451;
  wire n1453;
  wire n1455;
  wire [1:0] n1456;
  reg [3:0] n1458;
  wire n1460;
  wire n1462;
  wire n1463;
  wire n1465;
  wire n1467;
  wire n1469;
  wire [1:0] n1470;
  reg [3:0] n1472;
  wire n1474;
  wire n1476;
  wire n1478;
  wire [1:0] n1479;
  reg [1:0] n1482;
  wire n1484;
  wire [15:0] n1487;
  reg [2:0] n1493;
  reg [3:0] n1495;
  reg [1:0] n1497;
  reg [3:0] n1498;
  reg [1:0] n1500;
  reg n1502;
  reg n1504;
  reg n1507;
  reg n1509;
  reg n1512;
  reg n1514;
  reg n1516;
  reg n1518;
  reg n1520;
  reg n1522;
  wire n1524;
  wire n1526;
  wire n1527;
  wire n1529;
  wire n1530;
  wire n1532;
  wire n1533;
  wire n1535;
  wire n1536;
  wire [1:0] n1537;
  wire n1539;
  wire n1541;
  wire n1542;
  wire n1543;
  wire [2:0] n1546;
  wire [2:0] n1548;
  wire n1551;
  wire n1553;
  wire n1555;
  wire n1557;
  wire [2:0] n1558;
  wire n1560;
  wire n1563;
  wire n1565;
  wire n1567;
  wire n1568;
  wire n1569;
  wire [1:0] n1570;
  wire n1572;
  wire n1573;
  wire [1:0] n1576;
  wire n1579;
  wire n1582;
  wire n1584;
  wire n1586;
  wire n1588;
  wire [6:0] n1589;
  reg [3:0] n1591;
  reg [1:0] n1598;
  reg [1:0] n1601;
  reg [1:0] n1604;
  reg n1607;
  reg n1609;
  reg n1612;
  reg n1615;
  reg n1618;
  reg n1621;
  reg n1624;
  reg n1627;
  reg n1630;
  wire n1632;
  wire n1634;
  wire n1635;
  wire [2:0] n1636;
  wire n1638;
  wire n1640;
  wire n1642;
  reg [1:0] n1645;
  wire n1647;
  wire n1649;
  wire [2:0] n1650;
  wire n1652;
  wire n1654;
  wire n1655;
  wire n1657;
  wire n1658;
  wire n1660;
  wire n1661;
  wire n1663;
  wire n1665;
  wire n1667;
  wire [3:0] n1668;
  reg [3:0] n1673;
  reg n1678;
  reg n1680;
  wire n1682;
  reg [1:0] n1685;
  wire [3:0] n1686;
  wire [1:0] n1688;
  wire n1689;
  wire n1690;
  wire n1692;
  wire n1694;
  wire n1696;
  wire [3:0] n1697;
  wire n1699;
  wire [3:0] n1700;
  wire n1702;
  wire n1703;
  wire [3:0] n1704;
  wire n1706;
  wire n1707;
  wire [1:0] n1710;
  wire [1:0] n1712;
  wire n1714;
  wire n1716;
  wire [1:0] n1717;
  reg [1:0] n1719;
  reg n1720;
  wire n1722;
  wire n1724;
  wire n1725;
  wire [2:0] n1726;
  wire n1728;
  wire n1731;
  wire n1733;
  wire [2:0] n1734;
  wire n1736;
  wire n1739;
  wire n1741;
  wire n1743;
  wire [2:0] n1744;
  reg [1:0] n1747;
  reg [1:0] n1750;
  reg n1753;
  reg n1755;
  reg n1757;
  wire n1759;
  wire [1:0] n1760;
  wire n1762;
  wire n1763;
  wire n1764;
  wire n1766;
  wire n1767;
  wire n1768;
  wire n1769;
  wire n1770;
  wire n1772;
  wire n1773;
  wire n1774;
  wire n1776;
  wire n1778;
  wire n1780;
  wire n1783;
  wire n1785;
  wire n1787;
  wire n1789;
  wire n1790;
  wire n1791;
  wire [3:0] n1793;
  wire n1796;
  wire n1799;
  wire n1801;
  wire [3:0] n1802;
  reg [3:0] n1803;
  reg [1:0] n1808;
  reg [1:0] n1811;
  reg n1814;
  reg n1817;
  reg n1820;
  reg n1823;
  reg n1826;
  reg n1828;
  wire [1:0] n1829;
  wire n1831;
  wire n1833;
  wire n1835;
  wire [2:0] n1836;
  wire n1838;
  wire n1841;
  wire n1843;
  wire n1845;
  wire [2:0] n1846;
  reg [1:0] n1849;
  reg [1:0] n1852;
  reg n1855;
  reg n1857;
  wire [2:0] n1860;
  wire [3:0] n1861;
  wire [1:0] n1862;
  wire [1:0] n1863;
  wire n1864;
  wire n1866;
  wire n1868;
  wire n1869;
  wire n1871;
  wire n1872;
  wire n1874;
  wire n1876;
  wire n1878;
  wire n1879;
  wire n1881;
  wire n1882;
  wire [1:0] n1883;
  wire n1885;
  wire [4:0] n1886;
  wire n1888;
  wire n1889;
  wire n1890;
  wire n1891;
  wire n1893;
  wire n1895;
  wire [1:0] n1896;
  reg [1:0] n1900;
  reg n1903;
  wire n1905;
  wire n1907;
  wire [1:0] n1910;
  wire n1912;
  wire [1:0] n1915;
  wire n1917;
  wire n1919;
  wire [1:0] n1922;
  wire [1:0] n1925;
  wire [1:0] n1928;
  wire n1930;
  wire n1932;
  wire [3:0] n1933;
  reg [1:0] n1935;
  reg [1:0] n1939;
  reg [1:0] n1941;
  reg n1945;
  reg n1948;
  reg n1951;
  wire [2:0] n1954;
  wire [1:0] n1956;
  wire [1:0] n1957;
  wire [1:0] n1959;
  wire n1960;
  wire n1962;
  wire n1964;
  wire [2:0] n1965;
  wire n1967;
  wire n1970;
  wire n1972;
  wire n1974;
  wire [2:0] n1975;
  wire n1977;
  wire n1980;
  wire n1982;
  wire n1984;
  wire [3:0] n1985;
  reg [1:0] n1988;
  reg [1:0] n1992;
  reg n1995;
  reg n1998;
  reg n2000;
  reg n2002;
  wire [2:0] n2004;
  wire [1:0] n2005;
  wire [1:0] n2006;
  wire [1:0] n2008;
  wire n2010;
  wire n2011;
  wire n2012;
  wire n2014;
  wire n2016;
  wire n2018;
  wire [1:0] n2019;
  wire n2021;
  wire n2022;
  wire n2023;
  wire n2025;
  wire n2026;
  wire n2027;
  wire n2028;
  wire n2029;
  wire n2031;
  wire n2032;
  wire n2033;
  wire n2035;
  wire n2037;
  wire n2039;
  wire n2041;
  wire n2044;
  wire n2046;
  wire n2048;
  wire n2050;
  wire n2051;
  wire n2052;
  wire [3:0] n2054;
  wire n2057;
  wire n2059;
  wire [4:0] n2060;
  reg [3:0] n2061;
  reg [1:0] n2066;
  reg [1:0] n2070;
  reg n2073;
  reg n2076;
  reg n2079;
  reg n2082;
  reg n2085;
  reg n2088;
  reg n2090;
  wire [1:0] n2091;
  wire n2093;
  wire n2095;
  wire n2097;
  wire n2099;
  wire [2:0] n2100;
  wire n2102;
  wire n2105;
  wire n2107;
  wire n2109;
  wire [3:0] n2110;
  reg [1:0] n2113;
  reg [1:0] n2117;
  reg n2120;
  reg n2123;
  reg n2125;
  wire [2:0] n2128;
  wire [3:0] n2129;
  wire [1:0] n2130;
  wire [1:0] n2131;
  wire n2132;
  wire n2134;
  wire n2136;
  wire n2137;
  wire n2138;
  wire n2140;
  wire n2141;
  wire n2143;
  wire n2145;
  wire n2147;
  wire n2148;
  wire n2150;
  wire n2151;
  wire [2:0] n2154;
  wire n2156;
  wire n2158;
  wire n2160;
  wire [2:0] n2161;
  reg [1:0] n2165;
  reg n2168;
  reg n2171;
  wire n2173;
  wire [1:0] n2174;
  wire n2176;
  wire n2178;
  wire n2179;
  wire n2180;
  wire [2:0] n2183;
  wire [2:0] n2185;
  wire n2188;
  wire n2190;
  wire n2192;
  wire n2194;
  wire [2:0] n2195;
  wire n2197;
  wire n2198;
  wire n2199;
  wire n2201;
  wire n2202;
  wire n2205;
  wire n2207;
  wire n2210;
  wire n2212;
  wire n2214;
  wire n2215;
  wire n2216;
  wire [1:0] n2217;
  wire n2219;
  wire n2220;
  wire [1:0] n2223;
  wire n2226;
  wire n2229;
  wire n2231;
  wire n2233;
  wire n2235;
  wire [6:0] n2236;
  reg [3:0] n2239;
  reg [1:0] n2246;
  reg [1:0] n2249;
  reg [1:0] n2254;
  reg n2256;
  reg n2258;
  reg n2261;
  reg n2264;
  reg n2267;
  reg n2270;
  reg n2273;
  reg n2276;
  reg n2279;
  wire n2281;
  wire n2283;
  wire n2284;
  wire [1:0] n2285;
  wire n2287;
  wire n2288;
  wire n2289;
  wire n2291;
  wire n2292;
  wire n2293;
  wire n2294;
  wire n2295;
  wire n2297;
  wire n2298;
  wire n2299;
  wire n2301;
  wire n2303;
  wire n2305;
  wire n2307;
  wire n2310;
  wire n2312;
  wire n2314;
  wire n2315;
  wire n2316;
  wire n2319;
  wire n2321;
  wire n2323;
  wire n2324;
  wire n2325;
  wire [3:0] n2327;
  wire n2330;
  wire n2332;
  wire [4:0] n2333;
  reg [3:0] n2334;
  reg [1:0] n2340;
  reg [1:0] n2343;
  reg n2346;
  reg n2349;
  reg n2352;
  reg n2355;
  reg n2358;
  reg n2361;
  reg n2363;
  wire [1:0] n2364;
  wire n2366;
  wire n2367;
  wire n2368;
  wire n2370;
  wire n2372;
  wire n2374;
  wire [2:0] n2375;
  wire n2377;
  wire n2380;
  wire [2:0] n2381;
  wire n2383;
  wire n2386;
  wire n2388;
  wire n2390;
  wire [3:0] n2391;
  reg [1:0] n2395;
  reg [1:0] n2398;
  reg n2401;
  reg n2403;
  reg n2406;
  reg n2408;
  wire [2:0] n2411;
  wire [3:0] n2412;
  wire [1:0] n2413;
  wire [1:0] n2414;
  wire n2415;
  wire n2417;
  wire n2418;
  wire n2420;
  wire n2422;
  wire n2423;
  wire n2425;
  wire n2426;
  wire n2428;
  wire n2430;
  wire n2432;
  wire n2433;
  wire n2435;
  wire n2436;
  wire n2438;
  wire n2439;
  wire [1:0] n2440;
  wire n2442;
  wire n2444;
  wire n2445;
  wire n2446;
  wire [2:0] n2449;
  wire [2:0] n2451;
  wire n2454;
  wire n2456;
  wire n2458;
  wire [2:0] n2459;
  wire n2461;
  wire n2462;
  wire n2463;
  wire n2465;
  wire n2466;
  wire n2469;
  wire n2471;
  wire n2474;
  wire n2476;
  wire n2478;
  wire n2479;
  wire n2480;
  wire [1:0] n2481;
  wire n2483;
  wire n2484;
  wire [1:0] n2487;
  wire n2490;
  wire n2493;
  wire n2495;
  wire n2497;
  wire n2499;
  wire [5:0] n2500;
  reg [3:0] n2503;
  reg [1:0] n2508;
  reg [1:0] n2512;
  reg [1:0] n2516;
  reg n2518;
  reg n2520;
  reg n2523;
  reg n2526;
  reg n2529;
  reg n2532;
  reg n2535;
  reg n2538;
  wire n2540;
  wire n2542;
  wire n2543;
  wire [1:0] n2544;
  wire n2546;
  wire n2547;
  wire n2548;
  wire n2550;
  wire n2551;
  wire n2552;
  wire n2553;
  wire n2554;
  wire n2556;
  wire n2557;
  wire n2558;
  wire n2560;
  wire n2562;
  wire n2564;
  wire n2566;
  wire n2568;
  wire n2571;
  wire n2573;
  wire n2575;
  wire n2577;
  wire n2578;
  wire n2579;
  wire [3:0] n2581;
  wire n2584;
  wire n2586;
  wire [5:0] n2587;
  reg [3:0] n2589;
  reg [1:0] n2595;
  reg [1:0] n2599;
  reg [1:0] n2603;
  reg n2606;
  reg n2609;
  reg n2612;
  reg n2615;
  reg n2618;
  reg n2621;
  reg n2623;
  wire [1:0] n2624;
  wire n2626;
  wire n2628;
  wire n2629;
  wire n2630;
  wire n2631;
  wire [1:0] n2632;
  wire n2634;
  wire n2635;
  wire n2637;
  wire n2638;
  wire n2640;
  wire n2642;
  wire [1:0] n2643;
  wire n2645;
  wire [3:0] n2646;
  wire n2648;
  wire n2649;
  wire [3:0] n2652;
  wire n2654;
  wire [2:0] n2655;
  wire n2657;
  wire n2660;
  wire n2663;
  wire n2665;
  wire n2667;
  wire [4:0] n2668;
  reg [3:0] n2669;
  reg [1:0] n2673;
  reg [1:0] n2677;
  reg [1:0] n2681;
  reg n2683;
  reg n2686;
  reg n2689;
  reg n2691;
  wire [2:0] n2694;
  wire [3:0] n2695;
  wire [1:0] n2696;
  wire [1:0] n2697;
  wire [1:0] n2698;
  wire n2700;
  wire n2701;
  wire n2703;
  wire n2705;
  wire n2706;
  wire n2707;
  wire n2709;
  wire n2710;
  wire n2712;
  wire n2714;
  wire n2716;
  wire n2717;
  wire n2719;
  wire n2720;
  wire n2722;
  wire n2723;
  wire [13:0] n2724;
  reg [2:0] n2727;
  reg [3:0] n2729;
  reg [1:0] n2731;
  reg [3:0] n2733;
  reg [1:0] n2735;
  reg [1:0] n2738;
  reg n2741;
  reg n2744;
  reg n2747;
  reg n2750;
  reg n2753;
  reg n2756;
  reg n2758;
  reg n2760;
  reg n2762;
  reg n2763;
  reg n2764;
  reg n2766;
  reg n2769;
  reg n2772;
  reg n2775;
  reg n2778;
  reg n2781;
  reg n2784;
  reg n2787;
  wire [1:0] n2792;
  wire [2:0] n2793;
  wire [2:0] n2794;
  wire n2796;
  wire n2798;
  wire n2799;
  wire n2801;
  wire n2803;
  wire [2:0] n2804;
  reg [4:0] n2809;
  wire n2811;
  wire n2813;
  wire n2814;
  wire n2816;
  wire n2817;
  wire [2:0] n2818;
  wire n2820;
  wire n2822;
  wire n2823;
  wire n2825;
  wire [1:0] n2826;
  reg [4:0] n2830;
  wire n2832;
  wire [2:0] n2833;
  wire n2835;
  reg [4:0] n2838;
  wire n2840;
  wire [2:0] n2841;
  wire n2843;
  reg [4:0] n2846;
  wire [2:0] n2847;
  reg [4:0] n2848;
  wire n2850;
  wire [2:0] n2851;
  wire [30:0] n2852;
  wire n2854;
  wire n2856;
  wire n2858;
  wire n2860;
  wire n2862;
  wire n2864;
  wire n2866;
  wire [6:0] n2867;
  reg [4:0] n2876;
  wire n2878;
  wire [2:0] n2879;
  wire [30:0] n2880;
  wire [2:0] n2881;
  wire n2883;
  wire n2885;
  wire n2886;
  wire [4:0] n2889;
  wire n2892;
  wire [2:0] n2893;
  wire n2895;
  wire n2897;
  wire n2898;
  wire [4:0] n2901;
  wire n2904;
  wire n2906;
  wire n2908;
  wire [2:0] n2909;
  wire n2911;
  wire [4:0] n2914;
  wire n2917;
  wire n2919;
  wire n2921;
  wire [6:0] n2922;
  reg [4:0] n2928;
  wire n2930;
  wire [2:0] n2931;
  wire [30:0] n2932;
  wire n2934;
  wire [4:0] n2937;
  wire n2939;
  wire n2941;
  wire n2943;
  wire n2945;
  wire n2947;
  wire n2948;
  wire n2950;
  wire [2:0] n2951;
  wire [30:0] n2952;
  wire n2954;
  wire n2956;
  wire n2958;
  wire n2960;
  wire n2962;
  wire n2964;
  wire n2966;
  wire [6:0] n2967;
  reg [4:0] n2976;
  wire [2:0] n2977;
  wire [30:0] n2978;
  wire n2980;
  wire n2982;
  wire n2984;
  wire n2986;
  wire n2988;
  wire n2990;
  wire [2:0] n2991;
  wire n2993;
  wire [4:0] n2996;
  wire n2999;
  wire [6:0] n3000;
  reg [4:0] n3008;
  wire [4:0] n3009;
  wire [4:0] n3011;
  wire [4:0] n3013;
  wire [4:0] n3015;
  wire [4:0] n3017;
  reg [4:0] n3018;
  wire [2:0] n3019;
  reg [4:0] n3020;
  assign lcycle = n2727; //(module output)
  assign alu_op = n3020; //(module output)
  assign set_busa_to = n2729; //(module output)
  assign set_addr_to = n2731; //(module output)
  assign write_data = n2733; //(module output)
  assign jump = n2735; //(module output)
  assign baadd = n2738; //(module output)
  assign breakatna = n2741; //(module output)
  assign adadd = n2744; //(module output)
  assign addy = n2747; //(module output)
  assign pcadd = n2750; //(module output)
  assign inc_s = n2753; //(module output)
  assign dec_s = n2756; //(module output)
  assign lda = n2758; //(module output)
  assign ldp = n2760; //(module output)
  assign ldx = n2762; //(module output)
  assign ldy = n2763; //(module output)
  assign lds = n2764; //(module output)
  assign lddi = n2766; //(module output)
  assign ldalu = n2769; //(module output)
  assign ldad = n2772; //(module output)
  assign ldbal = n2775; //(module output)
  assign ldbah = n2778; //(module output)
  assign savep = n2781; //(module output)
  assign write = n2784; //(module output)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:94:10 */
  assign branch = n910; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:95:10 */
  assign alumore = n2787; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:99:10 */
  assign n882 = ir[7:5]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:100:20 */
  assign n883 = p[7]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:100:15 */
  assign n884 = ~n883;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:100:29 */
  assign n886 = n882 == 3'b000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:101:20 */
  assign n887 = p[7]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:101:29 */
  assign n889 = n882 == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:102:20 */
  assign n890 = p[6]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:102:15 */
  assign n891 = ~n890;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:102:29 */
  assign n893 = n882 == 3'b010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:103:20 */
  assign n894 = p[6]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:103:29 */
  assign n896 = n882 == 3'b011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:104:20 */
  assign n897 = p[0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:104:15 */
  assign n898 = ~n897;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:104:29 */
  assign n900 = n882 == 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:105:20 */
  assign n901 = p[0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:105:29 */
  assign n903 = n882 == 3'b101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:106:20 */
  assign n904 = p[1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:106:15 */
  assign n905 = ~n904;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:106:29 */
  assign n907 = n882 == 3'b110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:107:20 */
  assign n908 = p[1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:99:3 */
  assign n909 = {n907, n903, n900, n896, n893, n889, n886};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:99:3 */
  always @*
    case (n909)
      7'b1000000: n910 = n905;
      7'b0100000: n910 = n901;
      7'b0010000: n910 = n898;
      7'b0001000: n910 = n894;
      7'b0000100: n910 = n891;
      7'b0000010: n910 = n887;
      7'b0000001: n910 = n884;
      default: n910 = n908;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:137:12 */
  assign n913 = ir[7:5]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:139:16 */
  assign n914 = ir[1:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:142:18 */
  assign n915 = ir[4:2]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:142:30 */
  assign n917 = n915 == 3'b111;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:142:13 */
  assign n920 = n917 ? 4'b1011 : 4'b0011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:140:11 */
  assign n922 = n914 == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:149:18 */
  assign n923 = ir[4:2]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:149:30 */
  assign n925 = n923 == 3'b111;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:149:13 */
  assign n928 = n925 ? 4'b1010 : 4'b0010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:147:11 */
  assign n930 = n914 == 2'b10;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:155:18 */
  assign n931 = ir[4:2]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:155:30 */
  assign n933 = n931 == 3'b110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:155:13 */
  assign n936 = n933 ? 4'b1001 : 4'b0001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:155:13 */
  assign n939 = n933 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:161:18 */
  assign n940 = ir[4:2]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:161:30 */
  assign n942 = n940 == 3'b111;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:161:42 */
  assign n943 = ir[4:2]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:161:54 */
  assign n945 = n943 == 3'b110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:161:37 */
  assign n946 = n942 | n945;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:161:66 */
  assign n947 = ir[4:2]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:161:78 */
  assign n949 = n947 == 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:161:61 */
  assign n950 = n946 | n949;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:161:13 */
  assign n953 = n950 ? 4'b1001 : 4'b1000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:154:11 */
  assign n955 = n914 == 2'b11;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:139:9 */
  assign n956 = {n955, n930, n922};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:139:9 */
  always @*
    case (n956)
      3'b100: n960 = n936;
      3'b010: n960 = 4'b0010;
      3'b001: n960 = 4'b0011;
      default: n960 = 4'b0001;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:139:9 */
  always @*
    case (n956)
      3'b100: n962 = n953;
      3'b010: n962 = n928;
      3'b001: n962 = n920;
      default: n962 = 4'b0001;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:139:9 */
  always @*
    case (n956)
      3'b100: n964 = n939;
      3'b010: n964 = 1'b0;
      3'b001: n964 = 1'b0;
      default: n964 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:138:7 */
  assign n966 = n913 == 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:171:16 */
  assign n967 = ir[1:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:173:18 */
  assign n968 = ir[4]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:173:22 */
  assign n970 = n968 != 1'b1;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:173:34 */
  assign n971 = ir[2]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:173:38 */
  assign n973 = n971 != 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:173:29 */
  assign n974 = n970 | n973;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:173:13 */
  assign n977 = n974 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:172:11 */
  assign n979 = n967 == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:176:11 */
  assign n981 = n967 == 2'b01;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:178:11 */
  assign n983 = n967 == 2'b10;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:183:18 */
  assign n984 = ir[4:2]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:183:30 */
  assign n986 = n984 == 3'b110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:183:13 */
  assign n989 = n986 ? 4'b0100 : 4'b0000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:183:13 */
  assign n992 = n986 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:171:9 */
  assign n993 = {n983, n981, n979};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:171:9 */
  always @*
    case (n993)
      3'b100: n995 = 4'b0000;
      3'b010: n995 = 4'b0000;
      3'b001: n995 = 4'b0000;
      default: n995 = n989;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:171:9 */
  always @*
    case (n993)
      3'b100: n1000 = 1'b0;
      3'b010: n1000 = 1'b1;
      3'b001: n1000 = 1'b0;
      default: n1000 = 1'b1;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:171:9 */
  always @*
    case (n993)
      3'b100: n1004 = 1'b1;
      3'b010: n1004 = 1'b0;
      3'b001: n1004 = 1'b0;
      default: n1004 = 1'b1;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:171:9 */
  always @*
    case (n993)
      3'b100: n1006 = 1'b0;
      3'b010: n1006 = 1'b0;
      3'b001: n1006 = n977;
      default: n1006 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:171:9 */
  always @*
    case (n993)
      3'b100: n1008 = 1'b0;
      3'b010: n1008 = 1'b0;
      3'b001: n1008 = 1'b0;
      default: n1008 = n992;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:169:7 */
  assign n1010 = n913 == 3'b101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:189:16 */
  assign n1011 = ir[1:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:191:18 */
  assign n1012 = ir[4]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:191:22 */
  assign n1013 = ~n1012;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:191:13 */
  assign n1016 = n1013 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:190:11 */
  assign n1018 = n1011 == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:189:9 */
  always @*
    case (n1018)
      1'b1: n1021 = 4'b0011;
      default: n1021 = 4'b0001;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:189:9 */
  always @*
    case (n1018)
      1'b1: n1023 = n1016;
      default: n1023 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:188:7 */
  assign n1025 = n913 == 3'b110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:199:16 */
  assign n1026 = ir[1:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:201:16 */
  assign n1027 = ir[4]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:201:20 */
  assign n1028 = ~n1027;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:201:11 */
  assign n1031 = n1028 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:200:9 */
  assign n1033 = n1026 == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:199:9 */
  always @*
    case (n1033)
      1'b1: n1036 = 4'b0010;
      default: n1036 = 4'b0001;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:199:9 */
  always @*
    case (n1033)
      1'b1: n1038 = n1031;
      default: n1038 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:198:7 */
  assign n1040 = n913 == 3'b111;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:137:5 */
  assign n1041 = {n1040, n1025, n1010, n966};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:137:5 */
  always @*
    case (n1041)
      4'b1000: n1043 = n1036;
      4'b0100: n1043 = n1021;
      4'b0010: n1043 = n995;
      4'b0001: n1043 = n960;
      default: n1043 = 4'b0001;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:137:5 */
  always @*
    case (n1041)
      4'b1000: n1046 = 4'b0000;
      4'b0100: n1046 = 4'b0000;
      4'b0010: n1046 = 4'b0000;
      4'b0001: n1046 = n962;
      default: n1046 = 4'b0000;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:137:5 */
  always @*
    case (n1041)
      4'b1000: n1049 = 1'b0;
      4'b0100: n1049 = 1'b0;
      4'b0010: n1049 = n1000;
      4'b0001: n1049 = 1'b0;
      default: n1049 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:137:5 */
  always @*
    case (n1041)
      4'b1000: n1052 = n1038;
      4'b0100: n1052 = 1'b0;
      4'b0010: n1052 = n1004;
      4'b0001: n1052 = 1'b0;
      default: n1052 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:137:5 */
  always @*
    case (n1041)
      4'b1000: n1055 = 1'b0;
      4'b0100: n1055 = n1023;
      4'b0010: n1055 = n1006;
      4'b0001: n1055 = 1'b0;
      default: n1055 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:137:5 */
  always @*
    case (n1041)
      4'b1000: n1058 = 1'b0;
      4'b0100: n1058 = 1'b0;
      4'b0010: n1058 = n1008;
      4'b0001: n1058 = n964;
      default: n1058 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:211:10 */
  assign n1060 = ir[7:6]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:211:23 */
  assign n1062 = n1060 != 2'b10;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:211:37 */
  assign n1063 = ir[1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:211:31 */
  assign n1064 = n1063 & n1062;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:211:56 */
  assign n1066 = mode == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:211:67 */
  assign n1067 = ir[0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:211:70 */
  assign n1068 = ~n1067;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:211:62 */
  assign n1069 = n1066 | n1068;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:211:47 */
  assign n1070 = n1069 & n1064;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:212:12 */
  assign n1072 = ir == 8'b11101011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:212:7 */
  assign n1075 = n1072 ? 4'b0001 : 4'b0000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:211:5 */
  assign n1076 = n1070 ? n1075 : n1043;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:219:12 */
  assign n1077 = ir[4:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:232:15 */
  assign n1079 = mcycle == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:236:15 */
  assign n1081 = mcycle == 3'b010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:241:15 */
  assign n1083 = mcycle == 3'b011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:246:15 */
  assign n1085 = mcycle == 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:249:15 */
  assign n1087 = mcycle == 3'b101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:252:15 */
  assign n1089 = mcycle == 3'b110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:231:13 */
  assign n1090 = {n1089, n1087, n1085, n1083, n1081, n1079};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:231:13 */
  always @*
    case (n1090)
      6'b100000: n1097 = 2'b10;
      6'b010000: n1097 = 2'b11;
      6'b001000: n1097 = 2'b11;
      6'b000100: n1097 = 2'b00;
      6'b000010: n1097 = 2'b00;
      6'b000001: n1097 = 2'b00;
      default: n1097 = 2'b10;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:231:13 */
  always @*
    case (n1090)
      6'b100000: n1101 = n1046;
      6'b010000: n1101 = n1046;
      6'b001000: n1101 = n1046;
      6'b000100: n1101 = 4'b0101;
      6'b000010: n1101 = 4'b0110;
      6'b000001: n1101 = 4'b0111;
      default: n1101 = n1046;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:231:13 */
  always @*
    case (n1090)
      6'b100000: n1104 = 2'b10;
      6'b010000: n1104 = 2'b00;
      6'b001000: n1104 = 2'b00;
      6'b000100: n1104 = 2'b00;
      6'b000010: n1104 = 2'b00;
      6'b000001: n1104 = 2'b00;
      default: n1104 = 2'b00;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:231:13 */
  always @*
    case (n1090)
      6'b100000: n1109 = 1'b0;
      6'b010000: n1109 = 1'b0;
      6'b001000: n1109 = 1'b1;
      6'b000100: n1109 = 1'b1;
      6'b000010: n1109 = 1'b1;
      6'b000001: n1109 = 1'b0;
      default: n1109 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:231:13 */
  always @*
    case (n1090)
      6'b100000: n1112 = 1'b0;
      6'b010000: n1112 = 1'b1;
      6'b001000: n1112 = 1'b0;
      6'b000100: n1112 = 1'b0;
      6'b000010: n1112 = 1'b0;
      6'b000001: n1112 = 1'b0;
      default: n1112 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:231:13 */
  always @*
    case (n1090)
      6'b100000: n1117 = 1'b0;
      6'b010000: n1117 = 1'b0;
      6'b001000: n1117 = 1'b0;
      6'b000100: n1117 = 1'b1;
      6'b000010: n1117 = 1'b1;
      6'b000001: n1117 = 1'b1;
      default: n1117 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:228:11 */
  assign n1119 = ir == 8'b00000000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:259:15 */
  assign n1121 = mcycle == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:263:15 */
  assign n1123 = mcycle == 3'b010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:267:15 */
  assign n1125 = mcycle == 3'b011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:272:15 */
  assign n1127 = mcycle == 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:274:15 */
  assign n1129 = mcycle == 3'b101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:258:13 */
  assign n1130 = {n1129, n1127, n1125, n1123, n1121};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:258:13 */
  always @*
    case (n1130)
      5'b10000: n1135 = 2'b10;
      5'b01000: n1135 = 2'b10;
      5'b00100: n1135 = 2'b00;
      5'b00010: n1135 = 2'b00;
      5'b00001: n1135 = 2'b00;
      default: n1135 = 2'b10;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:258:13 */
  always @*
    case (n1130)
      5'b10000: n1138 = n1046;
      5'b01000: n1138 = n1046;
      5'b00100: n1138 = 4'b0110;
      5'b00010: n1138 = 4'b0111;
      5'b00001: n1138 = n1046;
      default: n1138 = n1046;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:258:13 */
  always @*
    case (n1130)
      5'b10000: n1142 = 2'b10;
      5'b01000: n1142 = 2'b00;
      5'b00100: n1142 = 2'b00;
      5'b00010: n1142 = 2'b00;
      5'b00001: n1142 = 2'b01;
      default: n1142 = 2'b00;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:258:13 */
  always @*
    case (n1130)
      5'b10000: n1146 = 1'b0;
      5'b01000: n1146 = 1'b1;
      5'b00100: n1146 = 1'b1;
      5'b00010: n1146 = 1'b0;
      5'b00001: n1146 = 1'b0;
      default: n1146 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:258:13 */
  always @*
    case (n1130)
      5'b10000: n1149 = 1'b0;
      5'b01000: n1149 = 1'b0;
      5'b00100: n1149 = 1'b0;
      5'b00010: n1149 = 1'b0;
      5'b00001: n1149 = 1'b1;
      default: n1149 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:258:13 */
  always @*
    case (n1130)
      5'b10000: n1153 = 1'b0;
      5'b01000: n1153 = 1'b0;
      5'b00100: n1153 = 1'b1;
      5'b00010: n1153 = 1'b1;
      5'b00001: n1153 = 1'b0;
      default: n1153 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:256:11 */
  assign n1155 = ir == 8'b00100000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:281:15 */
  assign n1157 = mcycle == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:283:15 */
  assign n1159 = mcycle == 3'b010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:286:15 */
  assign n1161 = mcycle == 3'b011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:290:15 */
  assign n1163 = mcycle == 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:295:15 */
  assign n1165 = mcycle == 3'b101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:280:15 */
  assign n1166 = {n1165, n1163, n1161, n1159, n1157};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:280:15 */
  always @*
    case (n1166)
      5'b10000: n1168 = n1076;
      5'b01000: n1168 = n1076;
      5'b00100: n1168 = 4'b0000;
      5'b00010: n1168 = n1076;
      5'b00001: n1168 = n1076;
      default: n1168 = n1076;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:280:15 */
  always @*
    case (n1166)
      5'b10000: n1174 = 2'b10;
      5'b01000: n1174 = 2'b00;
      5'b00100: n1174 = 2'b00;
      5'b00010: n1174 = 2'b00;
      5'b00001: n1174 = 2'b00;
      default: n1174 = 2'b10;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:280:15 */
  always @*
    case (n1166)
      5'b10000: n1177 = 2'b10;
      5'b01000: n1177 = 2'b00;
      5'b00100: n1177 = 2'b00;
      5'b00010: n1177 = 2'b00;
      5'b00001: n1177 = 2'b00;
      default: n1177 = 2'b00;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:280:15 */
  always @*
    case (n1166)
      5'b10000: n1182 = 1'b0;
      5'b01000: n1182 = 1'b1;
      5'b00100: n1182 = 1'b1;
      5'b00010: n1182 = 1'b1;
      5'b00001: n1182 = 1'b0;
      default: n1182 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:280:15 */
  always @*
    case (n1166)
      5'b10000: n1185 = 1'b0;
      5'b01000: n1185 = 1'b1;
      5'b00100: n1185 = 1'b0;
      5'b00010: n1185 = 1'b0;
      5'b00001: n1185 = 1'b0;
      default: n1185 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:280:15 */
  always @*
    case (n1166)
      5'b10000: n1188 = 1'b0;
      5'b01000: n1188 = 1'b1;
      5'b00100: n1188 = 1'b0;
      5'b00010: n1188 = 1'b0;
      5'b00001: n1188 = 1'b0;
      default: n1188 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:278:13 */
  assign n1190 = ir == 8'b01000000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:302:15 */
  assign n1192 = mcycle == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:304:15 */
  assign n1194 = mcycle == 3'b010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:307:15 */
  assign n1196 = mcycle == 3'b011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:311:15 */
  assign n1198 = mcycle == 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:313:15 */
  assign n1200 = mcycle == 3'b101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:301:13 */
  assign n1201 = {n1200, n1198, n1196, n1194, n1192};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:301:13 */
  always @*
    case (n1201)
      5'b10000: n1206 = 2'b10;
      5'b01000: n1206 = 2'b10;
      5'b00100: n1206 = 2'b00;
      5'b00010: n1206 = 2'b00;
      5'b00001: n1206 = 2'b00;
      default: n1206 = 2'b10;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:301:13 */
  always @*
    case (n1201)
      5'b10000: n1210 = 2'b01;
      5'b01000: n1210 = 2'b10;
      5'b00100: n1210 = 2'b00;
      5'b00010: n1210 = 2'b00;
      5'b00001: n1210 = 2'b00;
      default: n1210 = 2'b00;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:301:13 */
  always @*
    case (n1201)
      5'b10000: n1214 = 1'b0;
      5'b01000: n1214 = 1'b0;
      5'b00100: n1214 = 1'b1;
      5'b00010: n1214 = 1'b1;
      5'b00001: n1214 = 1'b0;
      default: n1214 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:301:13 */
  always @*
    case (n1201)
      5'b10000: n1217 = 1'b0;
      5'b01000: n1217 = 1'b0;
      5'b00100: n1217 = 1'b1;
      5'b00010: n1217 = 1'b0;
      5'b00001: n1217 = 1'b0;
      default: n1217 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:299:11 */
  assign n1219 = ir == 8'b01100000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:319:23 */
  assign n1221 = mode == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:319:36 */
  assign n1222 = ir[1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:319:30 */
  assign n1223 = n1222 & n1221;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:319:15 */
  assign n1226 = n1223 ? 3'b001 : 3'b010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:324:24 */
  assign n1229 = mode != 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:324:36 */
  assign n1230 = ir[1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:324:39 */
  assign n1231 = ~n1230;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:324:31 */
  assign n1232 = n1229 | n1231;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:326:26 */
  assign n1233 = ir[7:4]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:327:19 */
  assign n1235 = n1233 == 4'b0000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:329:19 */
  assign n1237 = n1233 == 4'b0100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:332:29 */
  assign n1239 = mode != 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:332:21 */
  assign n1241 = n1239 ? 4'b0011 : n1046;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:332:21 */
  assign n1244 = n1239 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:331:19 */
  assign n1246 = n1233 == 4'b0101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:338:29 */
  assign n1248 = mode != 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:338:21 */
  assign n1250 = n1248 ? 4'b0010 : n1046;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:338:21 */
  assign n1253 = n1248 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:337:19 */
  assign n1255 = n1233 == 4'b1101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:326:19 */
  assign n1256 = {n1255, n1246, n1237, n1235};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:326:19 */
  always @*
    case (n1256)
      4'b1000: n1259 = n1250;
      4'b0100: n1259 = n1241;
      4'b0010: n1259 = 4'b0001;
      4'b0001: n1259 = 4'b0101;
      default: n1259 = n1046;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:326:19 */
  always @*
    case (n1256)
      4'b1000: n1261 = n1253;
      4'b0100: n1261 = n1244;
      4'b0010: n1261 = 1'b1;
      4'b0001: n1261 = 1'b1;
      default: n1261 = 1'b1;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:324:17 */
  assign n1265 = n1232 ? 2'b00 : 2'b10;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:324:17 */
  assign n1266 = n1232 ? n1259 : n1046;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:324:17 */
  assign n1268 = n1232 ? n1261 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:323:15 */
  assign n1270 = mcycle == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:347:15 */
  assign n1272 = mcycle == 3'b010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:322:15 */
  assign n1273 = {n1272, n1270};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:322:15 */
  always @*
    case (n1273)
      2'b10: n1275 = 2'b10;
      2'b01: n1275 = n1265;
      default: n1275 = 2'b10;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:322:15 */
  always @*
    case (n1273)
      2'b10: n1276 = n1046;
      2'b01: n1276 = n1266;
      default: n1276 = n1046;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:322:15 */
  always @*
    case (n1273)
      2'b10: n1279 = 1'b1;
      2'b01: n1279 = 1'b0;
      default: n1279 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:322:15 */
  always @*
    case (n1273)
      2'b10: n1281 = 1'b0;
      2'b01: n1281 = n1268;
      default: n1281 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:317:13 */
  assign n1283 = ir == 8'b00001000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:317:24 */
  assign n1285 = ir == 8'b01001000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:317:24 */
  assign n1286 = n1283 | n1285;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:317:32 */
  assign n1288 = ir == 8'b01011010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:317:32 */
  assign n1289 = n1286 | n1288;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:317:40 */
  assign n1291 = ir == 8'b11011010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:317:40 */
  assign n1292 = n1289 | n1291;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:353:21 */
  assign n1294 = mode == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:353:34 */
  assign n1295 = ir[1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:353:28 */
  assign n1296 = n1295 & n1294;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:353:13 */
  assign n1299 = n1296 ? 3'b001 : 3'b011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:356:20 */
  assign n1301 = ir[7:4]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:357:15 */
  assign n1303 = n1301 == 4'b0010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:359:15 */
  assign n1305 = n1301 == 4'b0110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:362:25 */
  assign n1307 = mode != 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:362:17 */
  assign n1309 = n1307 ? 1'b1 : n1055;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:361:15 */
  assign n1311 = n1301 == 4'b0111;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:366:25 */
  assign n1313 = mode != 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:366:17 */
  assign n1315 = n1313 ? 1'b1 : n1052;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:365:15 */
  assign n1317 = n1301 == 4'b1111;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:356:13 */
  assign n1318 = {n1317, n1311, n1305, n1303};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:356:13 */
  always @*
    case (n1318)
      4'b1000: n1320 = n1049;
      4'b0100: n1320 = n1049;
      4'b0010: n1320 = 1'b1;
      4'b0001: n1320 = n1049;
      default: n1320 = n1049;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:356:13 */
  always @*
    case (n1318)
      4'b1000: n1323 = 1'b0;
      4'b0100: n1323 = 1'b0;
      4'b0010: n1323 = 1'b0;
      4'b0001: n1323 = 1'b1;
      default: n1323 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:356:13 */
  always @*
    case (n1318)
      4'b1000: n1324 = n1315;
      4'b0100: n1324 = n1052;
      4'b0010: n1324 = n1052;
      4'b0001: n1324 = n1052;
      default: n1324 = n1052;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:356:13 */
  always @*
    case (n1318)
      4'b1000: n1325 = n1055;
      4'b0100: n1325 = n1309;
      4'b0010: n1325 = n1055;
      4'b0001: n1325 = n1055;
      default: n1325 = n1055;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:373:25 */
  assign n1327 = mode != 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:373:38 */
  assign n1328 = ir[1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:373:42 */
  assign n1329 = ~n1328;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:373:33 */
  assign n1330 = n1327 | n1329;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:373:17 */
  assign n1333 = n1330 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:372:15 */
  assign n1335 = mcycle == 3'b000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:377:25 */
  assign n1337 = mode != 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:377:38 */
  assign n1338 = ir[1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:377:42 */
  assign n1339 = ~n1338;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:377:33 */
  assign n1340 = n1337 | n1339;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:377:17 */
  assign n1343 = n1340 ? 2'b00 : 2'b10;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:377:17 */
  assign n1345 = n1340 ? 1'b0 : n1323;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:376:15 */
  assign n1347 = mcycle == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:381:15 */
  assign n1349 = mcycle == 3'b010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:385:15 */
  assign n1351 = mcycle == 3'b011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:371:13 */
  assign n1352 = {n1351, n1349, n1347, n1335};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:371:13 */
  always @*
    case (n1352)
      4'b1000: n1354 = 4'b0000;
      4'b0100: n1354 = n1076;
      4'b0010: n1354 = n1076;
      4'b0001: n1354 = n1076;
      default: n1354 = n1076;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:371:13 */
  always @*
    case (n1352)
      4'b1000: n1357 = 2'b10;
      4'b0100: n1357 = 2'b00;
      4'b0010: n1357 = n1343;
      4'b0001: n1357 = 2'b10;
      default: n1357 = 2'b10;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:371:13 */
  always @*
    case (n1352)
      4'b1000: n1360 = 1'b0;
      4'b0100: n1360 = 1'b1;
      4'b0010: n1360 = 1'b0;
      4'b0001: n1360 = 1'b0;
      default: n1360 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:371:13 */
  always @*
    case (n1352)
      4'b1000: n1362 = n1323;
      4'b0100: n1362 = 1'b0;
      4'b0010: n1362 = n1345;
      4'b0001: n1362 = n1323;
      default: n1362 = n1323;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:371:13 */
  always @*
    case (n1352)
      4'b1000: n1364 = 1'b0;
      4'b0100: n1364 = 1'b0;
      4'b0010: n1364 = 1'b0;
      4'b0001: n1364 = n1333;
      default: n1364 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:351:11 */
  assign n1366 = ir == 8'b00101000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:351:23 */
  assign n1368 = ir == 8'b01101000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:351:23 */
  assign n1369 = n1366 | n1368;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:351:31 */
  assign n1371 = ir == 8'b01111010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:351:31 */
  assign n1372 = n1369 | n1371;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:351:39 */
  assign n1374 = ir == 8'b11111010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:351:39 */
  assign n1375 = n1372 | n1374;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:392:15 */
  assign n1377 = mcycle == 3'b000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:393:15 */
  assign n1379 = mcycle == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:391:13 */
  assign n1380 = {n1379, n1377};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:391:13 */
  always @*
    case (n1380)
      2'b10: n1383 = 2'b01;
      2'b01: n1383 = 2'b00;
      default: n1383 = 2'b00;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:389:11 */
  assign n1385 = ir == 8'b10100000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:389:22 */
  assign n1387 = ir == 8'b11000000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:389:22 */
  assign n1388 = n1385 | n1387;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:389:30 */
  assign n1390 = ir == 8'b11100000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:389:30 */
  assign n1391 = n1388 | n1390;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:400:15 */
  assign n1393 = mcycle == 3'b000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:401:15 */
  assign n1395 = mcycle == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:399:13 */
  assign n1396 = {n1395, n1393};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:399:13 */
  always @*
    case (n1396)
      2'b10: n1398 = 4'b0011;
      2'b01: n1398 = n1076;
      default: n1398 = n1076;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:397:11 */
  assign n1400 = ir == 8'b10001000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:408:15 */
  assign n1402 = mcycle == 3'b000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:409:15 */
  assign n1404 = mcycle == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:407:13 */
  assign n1405 = {n1404, n1402};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:407:13 */
  always @*
    case (n1405)
      2'b10: n1407 = 4'b0010;
      2'b01: n1407 = n1076;
      default: n1407 = n1076;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:405:11 */
  assign n1409 = ir == 8'b11001010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:414:21 */
  assign n1411 = mode != 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:414:13 */
  assign n1413 = n1411 ? 1'b1 : n1049;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:420:15 */
  assign n1415 = mcycle == 3'b000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:421:15 */
  assign n1417 = mcycle == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:419:13 */
  assign n1418 = {n1417, n1415};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:419:13 */
  always @*
    case (n1418)
      2'b10: n1420 = 4'b0100;
      2'b01: n1420 = n1076;
      default: n1420 = n1076;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:413:11 */
  assign n1422 = ir == 8'b00011010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:413:22 */
  assign n1424 = ir == 8'b00111010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:413:22 */
  assign n1425 = n1422 | n1424;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:425:11 */
  assign n1432 = ir == 8'b00001010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:425:22 */
  assign n1434 = ir == 8'b00101010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:425:22 */
  assign n1435 = n1432 | n1434;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:425:30 */
  assign n1437 = ir == 8'b01001010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:425:30 */
  assign n1438 = n1435 | n1437;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:425:38 */
  assign n1440 = ir == 8'b01101010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:425:38 */
  assign n1441 = n1438 | n1440;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:433:11 */
  assign n1448 = ir == 8'b10001010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:433:22 */
  assign n1450 = ir == 8'b10011000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:433:22 */
  assign n1451 = n1448 | n1450;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:442:15 */
  assign n1453 = mcycle == 3'b000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:443:15 */
  assign n1455 = mcycle == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:441:13 */
  assign n1456 = {n1455, n1453};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:441:13 */
  always @*
    case (n1456)
      2'b10: n1458 = 4'b0001;
      2'b01: n1458 = n1076;
      default: n1458 = n1076;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:440:11 */
  assign n1460 = ir == 8'b10101010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:440:22 */
  assign n1462 = ir == 8'b10101000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:440:22 */
  assign n1463 = n1460 | n1462;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:447:11 */
  assign n1465 = ir == 8'b10011010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:452:15 */
  assign n1467 = mcycle == 3'b000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:453:15 */
  assign n1469 = mcycle == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:451:13 */
  assign n1470 = {n1469, n1467};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:451:13 */
  always @*
    case (n1470)
      2'b10: n1472 = 4'b0100;
      2'b01: n1472 = n1076;
      default: n1472 = n1076;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:449:11 */
  assign n1474 = ir == 8'b10111010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:459:15 */
  assign n1476 = mcycle == 3'b000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:460:15 */
  assign n1478 = mcycle == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:458:13 */
  assign n1479 = {n1478, n1476};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:458:13 */
  always @*
    case (n1479)
      2'b10: n1482 = 2'b01;
      2'b01: n1482 = 2'b00;
      default: n1482 = 2'b00;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:457:11 */
  assign n1484 = ir == 8'b10000000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:227:9 */
  assign n1487 = {n1484, n1474, n1465, n1463, n1451, n1441, n1425, n1409, n1400, n1391, n1375, n1292, n1219, n1190, n1155, n1119};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:227:9 */
  always @*
    case (n1487)
      16'b1000000000000000: n1493 = 3'b001;
      16'b0100000000000000: n1493 = 3'b001;
      16'b0010000000000000: n1493 = 3'b001;
      16'b0001000000000000: n1493 = 3'b001;
      16'b0000100000000000: n1493 = 3'b001;
      16'b0000010000000000: n1493 = 3'b001;
      16'b0000001000000000: n1493 = 3'b001;
      16'b0000000100000000: n1493 = 3'b001;
      16'b0000000010000000: n1493 = 3'b001;
      16'b0000000001000000: n1493 = 3'b001;
      16'b0000000000100000: n1493 = n1299;
      16'b0000000000010000: n1493 = n1226;
      16'b0000000000001000: n1493 = 3'b101;
      16'b0000000000000100: n1493 = 3'b101;
      16'b0000000000000010: n1493 = 3'b101;
      16'b0000000000000001: n1493 = 3'b110;
      default: n1493 = 3'b001;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:227:9 */
  always @*
    case (n1487)
      16'b1000000000000000: n1495 = n1076;
      16'b0100000000000000: n1495 = n1472;
      16'b0010000000000000: n1495 = n1076;
      16'b0001000000000000: n1495 = n1458;
      16'b0000100000000000: n1495 = n1076;
      16'b0000010000000000: n1495 = 4'b0001;
      16'b0000001000000000: n1495 = n1420;
      16'b0000000100000000: n1495 = n1407;
      16'b0000000010000000: n1495 = n1398;
      16'b0000000001000000: n1495 = n1076;
      16'b0000000000100000: n1495 = n1354;
      16'b0000000000010000: n1495 = n1076;
      16'b0000000000001000: n1495 = n1076;
      16'b0000000000000100: n1495 = n1168;
      16'b0000000000000010: n1495 = n1076;
      16'b0000000000000001: n1495 = n1076;
      default: n1495 = n1076;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:227:9 */
  always @*
    case (n1487)
      16'b1000000000000000: n1497 = 2'b10;
      16'b0100000000000000: n1497 = 2'b10;
      16'b0010000000000000: n1497 = 2'b10;
      16'b0001000000000000: n1497 = 2'b10;
      16'b0000100000000000: n1497 = 2'b10;
      16'b0000010000000000: n1497 = 2'b10;
      16'b0000001000000000: n1497 = 2'b10;
      16'b0000000100000000: n1497 = 2'b10;
      16'b0000000010000000: n1497 = 2'b10;
      16'b0000000001000000: n1497 = 2'b10;
      16'b0000000000100000: n1497 = n1357;
      16'b0000000000010000: n1497 = n1275;
      16'b0000000000001000: n1497 = n1206;
      16'b0000000000000100: n1497 = n1174;
      16'b0000000000000010: n1497 = n1135;
      16'b0000000000000001: n1497 = n1097;
      default: n1497 = 2'b10;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:227:9 */
  always @*
    case (n1487)
      16'b1000000000000000: n1498 = n1046;
      16'b0100000000000000: n1498 = n1046;
      16'b0010000000000000: n1498 = n1046;
      16'b0001000000000000: n1498 = n1046;
      16'b0000100000000000: n1498 = n1046;
      16'b0000010000000000: n1498 = n1046;
      16'b0000001000000000: n1498 = n1046;
      16'b0000000100000000: n1498 = n1046;
      16'b0000000010000000: n1498 = n1046;
      16'b0000000001000000: n1498 = n1046;
      16'b0000000000100000: n1498 = n1046;
      16'b0000000000010000: n1498 = n1276;
      16'b0000000000001000: n1498 = n1046;
      16'b0000000000000100: n1498 = n1046;
      16'b0000000000000010: n1498 = n1138;
      16'b0000000000000001: n1498 = n1101;
      default: n1498 = n1046;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:227:9 */
  always @*
    case (n1487)
      16'b1000000000000000: n1500 = n1482;
      16'b0100000000000000: n1500 = 2'b00;
      16'b0010000000000000: n1500 = 2'b00;
      16'b0001000000000000: n1500 = 2'b00;
      16'b0000100000000000: n1500 = 2'b00;
      16'b0000010000000000: n1500 = 2'b00;
      16'b0000001000000000: n1500 = 2'b00;
      16'b0000000100000000: n1500 = 2'b00;
      16'b0000000010000000: n1500 = 2'b00;
      16'b0000000001000000: n1500 = n1383;
      16'b0000000000100000: n1500 = 2'b00;
      16'b0000000000010000: n1500 = 2'b00;
      16'b0000000000001000: n1500 = n1210;
      16'b0000000000000100: n1500 = n1177;
      16'b0000000000000010: n1500 = n1142;
      16'b0000000000000001: n1500 = n1104;
      default: n1500 = 2'b00;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:227:9 */
  always @*
    case (n1487)
      16'b1000000000000000: n1502 = 1'b0;
      16'b0100000000000000: n1502 = 1'b0;
      16'b0010000000000000: n1502 = 1'b0;
      16'b0001000000000000: n1502 = 1'b0;
      16'b0000100000000000: n1502 = 1'b0;
      16'b0000010000000000: n1502 = 1'b0;
      16'b0000001000000000: n1502 = 1'b0;
      16'b0000000100000000: n1502 = 1'b0;
      16'b0000000010000000: n1502 = 1'b0;
      16'b0000000001000000: n1502 = 1'b0;
      16'b0000000000100000: n1502 = n1360;
      16'b0000000000010000: n1502 = 1'b0;
      16'b0000000000001000: n1502 = n1214;
      16'b0000000000000100: n1502 = n1182;
      16'b0000000000000010: n1502 = 1'b0;
      16'b0000000000000001: n1502 = 1'b0;
      default: n1502 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:227:9 */
  always @*
    case (n1487)
      16'b1000000000000000: n1504 = 1'b0;
      16'b0100000000000000: n1504 = 1'b0;
      16'b0010000000000000: n1504 = 1'b0;
      16'b0001000000000000: n1504 = 1'b0;
      16'b0000100000000000: n1504 = 1'b0;
      16'b0000010000000000: n1504 = 1'b0;
      16'b0000001000000000: n1504 = 1'b0;
      16'b0000000100000000: n1504 = 1'b0;
      16'b0000000010000000: n1504 = 1'b0;
      16'b0000000001000000: n1504 = 1'b0;
      16'b0000000000100000: n1504 = 1'b0;
      16'b0000000000010000: n1504 = n1279;
      16'b0000000000001000: n1504 = 1'b0;
      16'b0000000000000100: n1504 = 1'b0;
      16'b0000000000000010: n1504 = n1146;
      16'b0000000000000001: n1504 = n1109;
      default: n1504 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:227:9 */
  always @*
    case (n1487)
      16'b1000000000000000: n1507 = n1049;
      16'b0100000000000000: n1507 = n1049;
      16'b0010000000000000: n1507 = n1049;
      16'b0001000000000000: n1507 = n1049;
      16'b0000100000000000: n1507 = 1'b1;
      16'b0000010000000000: n1507 = 1'b1;
      16'b0000001000000000: n1507 = n1413;
      16'b0000000100000000: n1507 = n1049;
      16'b0000000010000000: n1507 = n1049;
      16'b0000000001000000: n1507 = n1049;
      16'b0000000000100000: n1507 = n1320;
      16'b0000000000010000: n1507 = n1049;
      16'b0000000000001000: n1507 = n1049;
      16'b0000000000000100: n1507 = n1049;
      16'b0000000000000010: n1507 = n1049;
      16'b0000000000000001: n1507 = n1049;
      default: n1507 = n1049;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:227:9 */
  always @*
    case (n1487)
      16'b1000000000000000: n1509 = 1'b0;
      16'b0100000000000000: n1509 = 1'b0;
      16'b0010000000000000: n1509 = 1'b0;
      16'b0001000000000000: n1509 = 1'b0;
      16'b0000100000000000: n1509 = 1'b0;
      16'b0000010000000000: n1509 = 1'b0;
      16'b0000001000000000: n1509 = 1'b0;
      16'b0000000100000000: n1509 = 1'b0;
      16'b0000000010000000: n1509 = 1'b0;
      16'b0000000001000000: n1509 = 1'b0;
      16'b0000000000100000: n1509 = n1362;
      16'b0000000000010000: n1509 = 1'b0;
      16'b0000000000001000: n1509 = 1'b0;
      16'b0000000000000100: n1509 = n1185;
      16'b0000000000000010: n1509 = 1'b0;
      16'b0000000000000001: n1509 = 1'b0;
      default: n1509 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:227:9 */
  always @*
    case (n1487)
      16'b1000000000000000: n1512 = n1052;
      16'b0100000000000000: n1512 = 1'b1;
      16'b0010000000000000: n1512 = n1052;
      16'b0001000000000000: n1512 = n1052;
      16'b0000100000000000: n1512 = n1052;
      16'b0000010000000000: n1512 = n1052;
      16'b0000001000000000: n1512 = n1052;
      16'b0000000100000000: n1512 = 1'b1;
      16'b0000000010000000: n1512 = n1052;
      16'b0000000001000000: n1512 = n1052;
      16'b0000000000100000: n1512 = n1324;
      16'b0000000000010000: n1512 = n1052;
      16'b0000000000001000: n1512 = n1052;
      16'b0000000000000100: n1512 = n1052;
      16'b0000000000000010: n1512 = n1052;
      16'b0000000000000001: n1512 = n1052;
      default: n1512 = n1052;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:227:9 */
  always @*
    case (n1487)
      16'b1000000000000000: n1514 = n1055;
      16'b0100000000000000: n1514 = n1055;
      16'b0010000000000000: n1514 = n1055;
      16'b0001000000000000: n1514 = n1055;
      16'b0000100000000000: n1514 = n1055;
      16'b0000010000000000: n1514 = n1055;
      16'b0000001000000000: n1514 = n1055;
      16'b0000000100000000: n1514 = n1055;
      16'b0000000010000000: n1514 = 1'b1;
      16'b0000000001000000: n1514 = n1055;
      16'b0000000000100000: n1514 = n1325;
      16'b0000000000010000: n1514 = n1055;
      16'b0000000000001000: n1514 = n1055;
      16'b0000000000000100: n1514 = n1055;
      16'b0000000000000010: n1514 = n1055;
      16'b0000000000000001: n1514 = n1055;
      default: n1514 = n1055;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:227:9 */
  always @*
    case (n1487)
      16'b1000000000000000: n1516 = n1058;
      16'b0100000000000000: n1516 = n1058;
      16'b0010000000000000: n1516 = 1'b1;
      16'b0001000000000000: n1516 = n1058;
      16'b0000100000000000: n1516 = n1058;
      16'b0000010000000000: n1516 = n1058;
      16'b0000001000000000: n1516 = n1058;
      16'b0000000100000000: n1516 = n1058;
      16'b0000000010000000: n1516 = n1058;
      16'b0000000001000000: n1516 = n1058;
      16'b0000000000100000: n1516 = n1058;
      16'b0000000000010000: n1516 = n1058;
      16'b0000000000001000: n1516 = n1058;
      16'b0000000000000100: n1516 = n1058;
      16'b0000000000000010: n1516 = n1058;
      16'b0000000000000001: n1516 = n1058;
      default: n1516 = n1058;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:227:9 */
  always @*
    case (n1487)
      16'b1000000000000000: n1518 = 1'b0;
      16'b0100000000000000: n1518 = 1'b0;
      16'b0010000000000000: n1518 = 1'b0;
      16'b0001000000000000: n1518 = 1'b0;
      16'b0000100000000000: n1518 = 1'b0;
      16'b0000010000000000: n1518 = 1'b0;
      16'b0000001000000000: n1518 = 1'b0;
      16'b0000000100000000: n1518 = 1'b0;
      16'b0000000010000000: n1518 = 1'b0;
      16'b0000000001000000: n1518 = 1'b0;
      16'b0000000000100000: n1518 = 1'b0;
      16'b0000000000010000: n1518 = 1'b0;
      16'b0000000000001000: n1518 = n1217;
      16'b0000000000000100: n1518 = n1188;
      16'b0000000000000010: n1518 = n1149;
      16'b0000000000000001: n1518 = n1112;
      default: n1518 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:227:9 */
  always @*
    case (n1487)
      16'b1000000000000000: n1520 = 1'b0;
      16'b0100000000000000: n1520 = 1'b0;
      16'b0010000000000000: n1520 = 1'b0;
      16'b0001000000000000: n1520 = 1'b0;
      16'b0000100000000000: n1520 = 1'b0;
      16'b0000010000000000: n1520 = 1'b0;
      16'b0000001000000000: n1520 = 1'b0;
      16'b0000000100000000: n1520 = 1'b0;
      16'b0000000010000000: n1520 = 1'b0;
      16'b0000000001000000: n1520 = 1'b0;
      16'b0000000000100000: n1520 = n1364;
      16'b0000000000010000: n1520 = 1'b0;
      16'b0000000000001000: n1520 = 1'b0;
      16'b0000000000000100: n1520 = 1'b0;
      16'b0000000000000010: n1520 = 1'b0;
      16'b0000000000000001: n1520 = 1'b0;
      default: n1520 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:227:9 */
  always @*
    case (n1487)
      16'b1000000000000000: n1522 = 1'b0;
      16'b0100000000000000: n1522 = 1'b0;
      16'b0010000000000000: n1522 = 1'b0;
      16'b0001000000000000: n1522 = 1'b0;
      16'b0000100000000000: n1522 = 1'b0;
      16'b0000010000000000: n1522 = 1'b0;
      16'b0000001000000000: n1522 = 1'b0;
      16'b0000000100000000: n1522 = 1'b0;
      16'b0000000010000000: n1522 = 1'b0;
      16'b0000000001000000: n1522 = 1'b0;
      16'b0000000000100000: n1522 = 1'b0;
      16'b0000000000010000: n1522 = n1281;
      16'b0000000000001000: n1522 = 1'b0;
      16'b0000000000000100: n1522 = 1'b0;
      16'b0000000000000010: n1522 = n1153;
      16'b0000000000000001: n1522 = n1117;
      default: n1522 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:225:7 */
  assign n1524 = n1077 == 5'b00000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:225:20 */
  assign n1526 = n1077 == 5'b01000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:225:20 */
  assign n1527 = n1524 | n1526;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:225:30 */
  assign n1529 = n1077 == 5'b01010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:225:30 */
  assign n1530 = n1527 | n1529;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:225:40 */
  assign n1532 = n1077 == 5'b11000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:225:40 */
  assign n1533 = n1530 | n1532;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:225:50 */
  assign n1535 = n1077 == 5'b11010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:225:50 */
  assign n1536 = n1533 | n1535;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:476:14 */
  assign n1537 = ir[7:6]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:476:27 */
  assign n1539 = n1537 != 2'b10;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:478:18 */
  assign n1541 = mode == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:478:30 */
  assign n1542 = ir[1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:478:24 */
  assign n1543 = n1542 & n1541;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:478:11 */
  assign n1546 = n1543 ? 3'b111 : 3'b101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:476:9 */
  assign n1548 = n1539 ? n1546 : 3'b101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:476:9 */
  assign n1551 = n1539 ? 1'b1 : n1049;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:483:11 */
  assign n1553 = mcycle == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:487:11 */
  assign n1555 = mcycle == 3'b010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:490:11 */
  assign n1557 = mcycle == 3'b011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:496:18 */
  assign n1558 = ir[7:5]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:496:31 */
  assign n1560 = n1558 == 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:496:13 */
  assign n1563 = n1560 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:494:11 */
  assign n1565 = mcycle == 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:501:20 */
  assign n1567 = mode == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:501:32 */
  assign n1568 = ir[1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:501:26 */
  assign n1569 = n1568 & n1567;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:501:46 */
  assign n1570 = ir[7:6]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:501:58 */
  assign n1572 = n1570 != 2'b10;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:501:40 */
  assign n1573 = n1572 & n1569;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:501:13 */
  assign n1576 = n1573 ? 2'b11 : 2'b10;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:501:13 */
  assign n1579 = n1573 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:501:13 */
  assign n1582 = n1573 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:500:11 */
  assign n1584 = mcycle == 3'b101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:506:11 */
  assign n1586 = mcycle == 3'b110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:511:11 */
  assign n1588 = mcycle == 3'b111;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:482:9 */
  assign n1589 = {n1588, n1586, n1584, n1565, n1557, n1555, n1553};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:482:9 */
  always @*
    case (n1589)
      7'b1000000: n1591 = 4'b0001;
      7'b0100000: n1591 = n1076;
      7'b0010000: n1591 = n1076;
      7'b0001000: n1591 = n1076;
      7'b0000100: n1591 = n1076;
      7'b0000010: n1591 = n1076;
      7'b0000001: n1591 = n1076;
      default: n1591 = n1076;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:482:9 */
  always @*
    case (n1589)
      7'b1000000: n1598 = 2'b10;
      7'b0100000: n1598 = 2'b11;
      7'b0010000: n1598 = n1576;
      7'b0001000: n1598 = 2'b11;
      7'b0000100: n1598 = 2'b01;
      7'b0000010: n1598 = 2'b01;
      7'b0000001: n1598 = 2'b01;
      default: n1598 = 2'b10;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:482:9 */
  always @*
    case (n1589)
      7'b1000000: n1601 = 2'b00;
      7'b0100000: n1601 = 2'b00;
      7'b0010000: n1601 = 2'b00;
      7'b0001000: n1601 = 2'b00;
      7'b0000100: n1601 = 2'b00;
      7'b0000010: n1601 = 2'b00;
      7'b0000001: n1601 = 2'b01;
      default: n1601 = 2'b00;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:482:9 */
  always @*
    case (n1589)
      7'b1000000: n1604 = 2'b00;
      7'b0100000: n1604 = 2'b00;
      7'b0010000: n1604 = 2'b00;
      7'b0001000: n1604 = 2'b00;
      7'b0000100: n1604 = 2'b01;
      7'b0000010: n1604 = 2'b00;
      7'b0000001: n1604 = 2'b00;
      default: n1604 = 2'b00;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:482:9 */
  always @*
    case (n1589)
      7'b1000000: n1607 = 1'b0;
      7'b0100000: n1607 = 1'b0;
      7'b0010000: n1607 = 1'b0;
      7'b0001000: n1607 = 1'b0;
      7'b0000100: n1607 = 1'b0;
      7'b0000010: n1607 = 1'b1;
      7'b0000001: n1607 = 1'b0;
      default: n1607 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:482:9 */
  always @*
    case (n1589)
      7'b1000000: n1609 = 1'b0;
      7'b0100000: n1609 = 1'b0;
      7'b0010000: n1609 = n1579;
      7'b0001000: n1609 = 1'b0;
      7'b0000100: n1609 = 1'b0;
      7'b0000010: n1609 = 1'b0;
      7'b0000001: n1609 = 1'b0;
      default: n1609 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:482:9 */
  always @*
    case (n1589)
      7'b1000000: n1612 = 1'b0;
      7'b0100000: n1612 = 1'b1;
      7'b0010000: n1612 = 1'b0;
      7'b0001000: n1612 = 1'b0;
      7'b0000100: n1612 = 1'b0;
      7'b0000010: n1612 = 1'b0;
      7'b0000001: n1612 = 1'b0;
      default: n1612 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:482:9 */
  always @*
    case (n1589)
      7'b1000000: n1615 = 1'b0;
      7'b0100000: n1615 = 1'b0;
      7'b0010000: n1615 = 1'b0;
      7'b0001000: n1615 = 1'b0;
      7'b0000100: n1615 = 1'b0;
      7'b0000010: n1615 = 1'b0;
      7'b0000001: n1615 = 1'b1;
      default: n1615 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:482:9 */
  always @*
    case (n1589)
      7'b1000000: n1618 = 1'b0;
      7'b0100000: n1618 = 1'b0;
      7'b0010000: n1618 = 1'b0;
      7'b0001000: n1618 = 1'b0;
      7'b0000100: n1618 = 1'b1;
      7'b0000010: n1618 = 1'b0;
      7'b0000001: n1618 = 1'b0;
      default: n1618 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:482:9 */
  always @*
    case (n1589)
      7'b1000000: n1621 = 1'b0;
      7'b0100000: n1621 = 1'b0;
      7'b0010000: n1621 = 1'b0;
      7'b0001000: n1621 = 1'b1;
      7'b0000100: n1621 = 1'b0;
      7'b0000010: n1621 = 1'b0;
      7'b0000001: n1621 = 1'b0;
      default: n1621 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:482:9 */
  always @*
    case (n1589)
      7'b1000000: n1624 = 1'b0;
      7'b0100000: n1624 = 1'b1;
      7'b0010000: n1624 = 1'b0;
      7'b0001000: n1624 = 1'b0;
      7'b0000100: n1624 = 1'b0;
      7'b0000010: n1624 = 1'b0;
      7'b0000001: n1624 = 1'b0;
      default: n1624 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:482:9 */
  always @*
    case (n1589)
      7'b1000000: n1627 = 1'b0;
      7'b0100000: n1627 = 1'b1;
      7'b0010000: n1627 = n1582;
      7'b0001000: n1627 = n1563;
      7'b0000100: n1627 = 1'b0;
      7'b0000010: n1627 = 1'b0;
      7'b0000001: n1627 = 1'b0;
      default: n1627 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:482:9 */
  always @*
    case (n1589)
      7'b1000000: n1630 = 1'b1;
      7'b0100000: n1630 = 1'b0;
      7'b0010000: n1630 = 1'b0;
      7'b0001000: n1630 = 1'b0;
      7'b0000100: n1630 = 1'b0;
      7'b0000010: n1630 = 1'b0;
      7'b0000001: n1630 = 1'b0;
      default: n1630 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:473:7 */
  assign n1632 = n1077 == 5'b00001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:473:20 */
  assign n1634 = n1077 == 5'b00011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:473:20 */
  assign n1635 = n1632 | n1634;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:520:14 */
  assign n1636 = ir[7:5]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:520:26 */
  assign n1638 = n1636 != 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:520:9 */
  assign n1640 = n1638 ? 1'b1 : n1049;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:524:11 */
  assign n1642 = mcycle == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:523:9 */
  always @*
    case (n1642)
      1'b1: n1645 = 2'b01;
      default: n1645 = 2'b00;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:518:7 */
  assign n1647 = n1077 == 5'b01001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:531:16 */
  assign n1649 = mode == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:533:18 */
  assign n1650 = ir[7:5]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:534:13 */
  assign n1652 = n1650 == 3'b010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:534:23 */
  assign n1654 = n1650 == 3'b011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:534:23 */
  assign n1655 = n1652 | n1654;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:534:29 */
  assign n1657 = n1650 == 3'b000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:534:29 */
  assign n1658 = n1655 | n1657;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:534:35 */
  assign n1660 = n1650 == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:534:35 */
  assign n1661 = n1658 | n1660;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:537:13 */
  assign n1663 = n1650 == 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:540:13 */
  assign n1665 = n1650 == 3'b110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:543:13 */
  assign n1667 = n1650 == 3'b101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:533:11 */
  assign n1668 = {n1667, n1665, n1663, n1661};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:533:11 */
  always @*
    case (n1668)
      4'b1000: n1673 = 4'b0111;
      4'b0100: n1673 = 4'b1001;
      4'b0010: n1673 = 4'b1000;
      4'b0001: n1673 = 4'b0110;
      default: n1673 = n1076;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:533:11 */
  always @*
    case (n1668)
      4'b1000: n1678 = 1'b1;
      4'b0100: n1678 = n1049;
      4'b0010: n1678 = 1'b1;
      4'b0001: n1678 = 1'b1;
      default: n1678 = 1'b1;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:533:11 */
  always @*
    case (n1668)
      4'b1000: n1680 = n1052;
      4'b0100: n1680 = 1'b1;
      4'b0010: n1680 = n1052;
      4'b0001: n1680 = n1052;
      default: n1680 = n1052;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:550:13 */
  assign n1682 = mcycle == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:549:11 */
  always @*
    case (n1682)
      1'b1: n1685 = 2'b01;
      default: n1685 = 2'b00;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:531:9 */
  assign n1686 = n1649 ? n1673 : n1076;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:531:9 */
  assign n1688 = n1649 ? n1685 : 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:531:9 */
  assign n1689 = n1649 ? n1678 : n1049;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:531:9 */
  assign n1690 = n1649 ? n1680 : n1052;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:530:7 */
  assign n1692 = n1077 == 5'b01011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:561:11 */
  assign n1694 = mcycle == 3'b000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:563:19 */
  assign n1696 = ir == 8'b10100010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:567:21 */
  assign n1697 = ir[7:4]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:567:33 */
  assign n1699 = n1697 == 4'b1000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:567:46 */
  assign n1700 = ir[7:4]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:567:58 */
  assign n1702 = n1700 == 4'b1100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:567:41 */
  assign n1703 = n1699 | n1702;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:567:71 */
  assign n1704 = ir[7:4]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:567:83 */
  assign n1706 = n1704 == 4'b1110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:567:66 */
  assign n1707 = n1703 | n1706;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:567:13 */
  assign n1710 = n1707 ? 2'b01 : 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:563:13 */
  assign n1712 = n1696 ? 2'b01 : n1710;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:563:13 */
  assign n1714 = n1696 ? 1'b1 : n1052;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:562:11 */
  assign n1716 = mcycle == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:560:9 */
  assign n1717 = {n1716, n1694};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:560:9 */
  always @*
    case (n1717)
      2'b10: n1719 = n1712;
      2'b01: n1719 = 2'b00;
      default: n1719 = 2'b00;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:560:9 */
  always @*
    case (n1717)
      2'b10: n1720 = n1714;
      2'b01: n1720 = n1052;
      default: n1720 = n1052;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:558:7 */
  assign n1722 = n1077 == 5'b00010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:558:20 */
  assign n1724 = n1077 == 5'b10010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:558:20 */
  assign n1725 = n1722 | n1724;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:582:18 */
  assign n1726 = ir[7:5]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:582:31 */
  assign n1728 = n1726 == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:582:13 */
  assign n1731 = n1728 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:581:11 */
  assign n1733 = mcycle == 3'b000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:588:18 */
  assign n1734 = ir[7:5]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:588:31 */
  assign n1736 = n1734 == 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:588:13 */
  assign n1739 = n1736 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:585:11 */
  assign n1741 = mcycle == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:592:11 */
  assign n1743 = mcycle == 3'b010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:580:9 */
  assign n1744 = {n1743, n1741, n1733};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:580:9 */
  always @*
    case (n1744)
      3'b100: n1747 = 2'b10;
      3'b010: n1747 = 2'b01;
      3'b001: n1747 = 2'b10;
      default: n1747 = 2'b10;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:580:9 */
  always @*
    case (n1744)
      3'b100: n1750 = 2'b00;
      3'b010: n1750 = 2'b01;
      3'b001: n1750 = 2'b00;
      default: n1750 = 2'b00;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:580:9 */
  always @*
    case (n1744)
      3'b100: n1753 = 1'b0;
      3'b010: n1753 = 1'b1;
      3'b001: n1753 = 1'b0;
      default: n1753 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:580:9 */
  always @*
    case (n1744)
      3'b100: n1755 = 1'b0;
      3'b010: n1755 = 1'b0;
      3'b001: n1755 = n1731;
      default: n1755 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:580:9 */
  always @*
    case (n1744)
      3'b100: n1757 = 1'b0;
      3'b010: n1757 = n1739;
      3'b001: n1757 = 1'b0;
      default: n1757 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:577:7 */
  assign n1759 = n1077 == 5'b00100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:601:14 */
  assign n1760 = ir[7:6]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:601:27 */
  assign n1762 = n1760 != 2'b10;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:601:41 */
  assign n1763 = ir[1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:601:35 */
  assign n1764 = n1763 & n1762;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:601:60 */
  assign n1766 = mode == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:601:71 */
  assign n1767 = ir[0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:601:74 */
  assign n1768 = ~n1767;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:601:66 */
  assign n1769 = n1766 | n1768;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:601:51 */
  assign n1770 = n1769 & n1764;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:604:18 */
  assign n1772 = mode == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:604:30 */
  assign n1773 = ir[0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:604:24 */
  assign n1774 = n1773 & n1772;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:604:11 */
  assign n1776 = n1774 ? 1'b1 : n1049;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:608:13 */
  assign n1778 = mcycle == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:614:22 */
  assign n1780 = mode == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:614:15 */
  assign n1783 = n1780 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:612:13 */
  assign n1785 = mcycle == 3'b010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:618:13 */
  assign n1787 = mcycle == 3'b011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:624:22 */
  assign n1789 = mode == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:624:34 */
  assign n1790 = ir[0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:624:28 */
  assign n1791 = n1790 & n1789;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:624:15 */
  assign n1793 = n1791 ? 4'b0001 : n1076;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:624:15 */
  assign n1796 = n1791 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:624:15 */
  assign n1799 = n1791 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:623:13 */
  assign n1801 = mcycle == 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:607:11 */
  assign n1802 = {n1801, n1787, n1785, n1778};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:607:11 */
  always @*
    case (n1802)
      4'b1000: n1803 = n1793;
      4'b0100: n1803 = n1076;
      4'b0010: n1803 = n1076;
      4'b0001: n1803 = n1076;
      default: n1803 = n1076;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:607:11 */
  always @*
    case (n1802)
      4'b1000: n1808 = 2'b10;
      4'b0100: n1808 = 2'b01;
      4'b0010: n1808 = 2'b01;
      4'b0001: n1808 = 2'b01;
      default: n1808 = 2'b10;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:607:11 */
  always @*
    case (n1802)
      4'b1000: n1811 = 2'b00;
      4'b0100: n1811 = 2'b00;
      4'b0010: n1811 = 2'b00;
      4'b0001: n1811 = 2'b01;
      default: n1811 = 2'b00;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:607:11 */
  always @*
    case (n1802)
      4'b1000: n1814 = n1796;
      4'b0100: n1814 = 1'b0;
      4'b0010: n1814 = 1'b1;
      4'b0001: n1814 = 1'b0;
      default: n1814 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:607:11 */
  always @*
    case (n1802)
      4'b1000: n1817 = 1'b0;
      4'b0100: n1817 = 1'b1;
      4'b0010: n1817 = 1'b0;
      4'b0001: n1817 = 1'b0;
      default: n1817 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:607:11 */
  always @*
    case (n1802)
      4'b1000: n1820 = 1'b0;
      4'b0100: n1820 = 1'b0;
      4'b0010: n1820 = 1'b0;
      4'b0001: n1820 = 1'b1;
      default: n1820 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:607:11 */
  always @*
    case (n1802)
      4'b1000: n1823 = 1'b0;
      4'b0100: n1823 = 1'b1;
      4'b0010: n1823 = 1'b0;
      4'b0001: n1823 = 1'b0;
      default: n1823 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:607:11 */
  always @*
    case (n1802)
      4'b1000: n1826 = 1'b0;
      4'b0100: n1826 = 1'b1;
      4'b0010: n1826 = n1783;
      4'b0001: n1826 = 1'b0;
      default: n1826 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:607:11 */
  always @*
    case (n1802)
      4'b1000: n1828 = n1799;
      4'b0100: n1828 = 1'b0;
      4'b0010: n1828 = 1'b0;
      4'b0001: n1828 = 1'b0;
      default: n1828 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:633:16 */
  assign n1829 = ir[7:6]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:633:29 */
  assign n1831 = n1829 != 2'b10;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:633:11 */
  assign n1833 = n1831 ? 1'b1 : n1049;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:637:13 */
  assign n1835 = mcycle == 3'b000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:641:20 */
  assign n1836 = ir[7:5]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:641:33 */
  assign n1838 = n1836 == 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:641:15 */
  assign n1841 = n1838 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:638:13 */
  assign n1843 = mcycle == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:645:13 */
  assign n1845 = mcycle == 3'b010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:636:11 */
  assign n1846 = {n1845, n1843, n1835};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:636:11 */
  always @*
    case (n1846)
      3'b100: n1849 = 2'b10;
      3'b010: n1849 = 2'b01;
      3'b001: n1849 = 2'b10;
      default: n1849 = 2'b10;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:636:11 */
  always @*
    case (n1846)
      3'b100: n1852 = 2'b00;
      3'b010: n1852 = 2'b01;
      3'b001: n1852 = 2'b00;
      default: n1852 = 2'b00;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:636:11 */
  always @*
    case (n1846)
      3'b100: n1855 = 1'b0;
      3'b010: n1855 = 1'b1;
      3'b001: n1855 = 1'b0;
      default: n1855 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:636:11 */
  always @*
    case (n1846)
      3'b100: n1857 = 1'b0;
      3'b010: n1857 = n1841;
      3'b001: n1857 = 1'b0;
      default: n1857 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:601:9 */
  assign n1860 = n1770 ? 3'b100 : 3'b010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:601:9 */
  assign n1861 = n1770 ? n1803 : n1076;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:601:9 */
  assign n1862 = n1770 ? n1808 : n1849;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:601:9 */
  assign n1863 = n1770 ? n1811 : n1852;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:601:9 */
  assign n1864 = n1770 ? n1776 : n1833;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:601:9 */
  assign n1866 = n1770 ? n1814 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:601:9 */
  assign n1868 = n1770 ? n1817 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:601:9 */
  assign n1869 = n1770 ? n1820 : n1855;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:601:9 */
  assign n1871 = n1770 ? n1823 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:601:9 */
  assign n1872 = n1770 ? n1826 : n1857;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:601:9 */
  assign n1874 = n1770 ? n1828 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:599:7 */
  assign n1876 = n1077 == 5'b00101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:599:20 */
  assign n1878 = n1077 == 5'b00110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:599:20 */
  assign n1879 = n1876 | n1878;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:599:30 */
  assign n1881 = n1077 == 5'b00111;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:599:30 */
  assign n1882 = n1879 | n1881;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:653:14 */
  assign n1883 = ir[7:6]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:653:27 */
  assign n1885 = n1883 == 2'b01;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:653:40 */
  assign n1886 = ir[4:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:653:53 */
  assign n1888 = n1886 == 5'b01100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:653:34 */
  assign n1889 = n1888 & n1885;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:654:16 */
  assign n1890 = ir[5]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:654:20 */
  assign n1891 = ~n1890;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:657:15 */
  assign n1893 = mcycle == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:660:15 */
  assign n1895 = mcycle == 3'b010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:656:13 */
  assign n1896 = {n1895, n1893};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:656:13 */
  always @*
    case (n1896)
      2'b10: n1900 = 2'b10;
      2'b01: n1900 = 2'b01;
      default: n1900 = 2'b00;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:656:13 */
  always @*
    case (n1896)
      2'b10: n1903 = 1'b0;
      2'b01: n1903 = 1'b1;
      default: n1903 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:667:15 */
  assign n1905 = mcycle == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:673:25 */
  assign n1907 = mode != 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:673:17 */
  assign n1910 = n1907 ? 2'b10 : 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:676:25 */
  assign n1912 = mode == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:676:17 */
  assign n1915 = n1912 ? 2'b11 : 2'b10;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:671:15 */
  assign n1917 = mcycle == 3'b010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:681:25 */
  assign n1919 = mode == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:681:17 */
  assign n1922 = n1919 ? 2'b11 : 2'b10;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:681:17 */
  assign n1925 = n1919 ? 2'b00 : 2'b01;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:681:17 */
  assign n1928 = n1919 ? 2'b01 : 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:679:15 */
  assign n1930 = mcycle == 3'b011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:687:15 */
  assign n1932 = mcycle == 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:666:13 */
  assign n1933 = {n1932, n1930, n1917, n1905};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:666:13 */
  always @*
    case (n1933)
      4'b1000: n1935 = 2'b10;
      4'b0100: n1935 = n1922;
      4'b0010: n1935 = n1915;
      4'b0001: n1935 = 2'b10;
      default: n1935 = 2'b10;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:666:13 */
  always @*
    case (n1933)
      4'b1000: n1939 = 2'b10;
      4'b0100: n1939 = n1925;
      4'b0010: n1939 = n1910;
      4'b0001: n1939 = 2'b01;
      default: n1939 = 2'b00;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:666:13 */
  always @*
    case (n1933)
      4'b1000: n1941 = 2'b00;
      4'b0100: n1941 = n1928;
      4'b0010: n1941 = 2'b00;
      4'b0001: n1941 = 2'b00;
      default: n1941 = 2'b00;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:666:13 */
  always @*
    case (n1933)
      4'b1000: n1945 = 1'b0;
      4'b0100: n1945 = 1'b1;
      4'b0010: n1945 = 1'b0;
      4'b0001: n1945 = 1'b1;
      default: n1945 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:666:13 */
  always @*
    case (n1933)
      4'b1000: n1948 = 1'b0;
      4'b0100: n1948 = 1'b0;
      4'b0010: n1948 = 1'b0;
      4'b0001: n1948 = 1'b1;
      default: n1948 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:666:13 */
  always @*
    case (n1933)
      4'b1000: n1951 = 1'b0;
      4'b0100: n1951 = 1'b0;
      4'b0010: n1951 = 1'b1;
      4'b0001: n1951 = 1'b0;
      default: n1951 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:654:11 */
  assign n1954 = n1891 ? 3'b010 : 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:654:11 */
  assign n1956 = n1891 ? 2'b10 : n1935;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:654:11 */
  assign n1957 = n1891 ? n1900 : n1939;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:654:11 */
  assign n1959 = n1891 ? 2'b00 : n1941;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:654:11 */
  assign n1960 = n1891 ? n1903 : n1945;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:654:11 */
  assign n1962 = n1891 ? 1'b0 : n1948;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:654:11 */
  assign n1964 = n1891 ? 1'b0 : n1951;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:696:20 */
  assign n1965 = ir[7:5]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:696:33 */
  assign n1967 = n1965 == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:696:15 */
  assign n1970 = n1967 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:695:13 */
  assign n1972 = mcycle == 3'b000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:699:13 */
  assign n1974 = mcycle == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:705:20 */
  assign n1975 = ir[7:5]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:705:33 */
  assign n1977 = n1975 == 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:705:15 */
  assign n1980 = n1977 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:702:13 */
  assign n1982 = mcycle == 3'b010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:709:13 */
  assign n1984 = mcycle == 3'b011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:694:11 */
  assign n1985 = {n1984, n1982, n1974, n1972};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:694:11 */
  always @*
    case (n1985)
      4'b1000: n1988 = 2'b10;
      4'b0100: n1988 = 2'b11;
      4'b0010: n1988 = 2'b10;
      4'b0001: n1988 = 2'b10;
      default: n1988 = 2'b10;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:694:11 */
  always @*
    case (n1985)
      4'b1000: n1992 = 2'b00;
      4'b0100: n1992 = 2'b01;
      4'b0010: n1992 = 2'b01;
      4'b0001: n1992 = 2'b00;
      default: n1992 = 2'b00;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:694:11 */
  always @*
    case (n1985)
      4'b1000: n1995 = 1'b0;
      4'b0100: n1995 = 1'b0;
      4'b0010: n1995 = 1'b1;
      4'b0001: n1995 = 1'b0;
      default: n1995 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:694:11 */
  always @*
    case (n1985)
      4'b1000: n1998 = 1'b0;
      4'b0100: n1998 = 1'b1;
      4'b0010: n1998 = 1'b0;
      4'b0001: n1998 = 1'b0;
      default: n1998 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:694:11 */
  always @*
    case (n1985)
      4'b1000: n2000 = 1'b0;
      4'b0100: n2000 = 1'b0;
      4'b0010: n2000 = 1'b0;
      4'b0001: n2000 = n1970;
      default: n2000 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:694:11 */
  always @*
    case (n1985)
      4'b1000: n2002 = 1'b0;
      4'b0100: n2002 = n1980;
      4'b0010: n2002 = 1'b0;
      4'b0001: n2002 = 1'b0;
      default: n2002 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:653:9 */
  assign n2004 = n1889 ? n1954 : 3'b011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:653:9 */
  assign n2005 = n1889 ? n1956 : n1988;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:653:9 */
  assign n2006 = n1889 ? n1957 : n1992;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:653:9 */
  assign n2008 = n1889 ? n1959 : 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:653:9 */
  assign n2010 = n1889 ? n1960 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:653:9 */
  assign n2011 = n1889 ? n1962 : n1995;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:653:9 */
  assign n2012 = n1889 ? n1964 : n1998;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:653:9 */
  assign n2014 = n1889 ? 1'b0 : n2000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:653:9 */
  assign n2016 = n1889 ? 1'b0 : n2002;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:651:7 */
  assign n2018 = n1077 == 5'b01100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:719:14 */
  assign n2019 = ir[7:6]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:719:27 */
  assign n2021 = n2019 != 2'b10;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:719:41 */
  assign n2022 = ir[1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:719:35 */
  assign n2023 = n2022 & n2021;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:719:60 */
  assign n2025 = mode == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:719:71 */
  assign n2026 = ir[0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:719:74 */
  assign n2027 = ~n2026;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:719:66 */
  assign n2028 = n2025 | n2027;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:719:51 */
  assign n2029 = n2028 & n2023;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:722:18 */
  assign n2031 = mode == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:722:30 */
  assign n2032 = ir[0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:722:24 */
  assign n2033 = n2032 & n2031;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:722:11 */
  assign n2035 = n2033 ? 1'b1 : n1049;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:726:13 */
  assign n2037 = mcycle == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:729:13 */
  assign n2039 = mcycle == 3'b010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:735:22 */
  assign n2041 = mode == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:735:15 */
  assign n2044 = n2041 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:733:13 */
  assign n2046 = mcycle == 3'b011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:739:13 */
  assign n2048 = mcycle == 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:745:22 */
  assign n2050 = mode == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:745:34 */
  assign n2051 = ir[0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:745:28 */
  assign n2052 = n2051 & n2050;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:745:15 */
  assign n2054 = n2052 ? 4'b0001 : n1076;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:745:15 */
  assign n2057 = n2052 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:744:13 */
  assign n2059 = mcycle == 3'b101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:725:11 */
  assign n2060 = {n2059, n2048, n2046, n2039, n2037};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:725:11 */
  always @*
    case (n2060)
      5'b10000: n2061 = n2054;
      5'b01000: n2061 = n1076;
      5'b00100: n2061 = n1076;
      5'b00010: n2061 = n1076;
      5'b00001: n2061 = n1076;
      default: n2061 = n1076;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:725:11 */
  always @*
    case (n2060)
      5'b10000: n2066 = 2'b10;
      5'b01000: n2066 = 2'b11;
      5'b00100: n2066 = 2'b11;
      5'b00010: n2066 = 2'b11;
      5'b00001: n2066 = 2'b10;
      default: n2066 = 2'b10;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:725:11 */
  always @*
    case (n2060)
      5'b10000: n2070 = 2'b00;
      5'b01000: n2070 = 2'b00;
      5'b00100: n2070 = 2'b00;
      5'b00010: n2070 = 2'b01;
      5'b00001: n2070 = 2'b01;
      default: n2070 = 2'b00;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:725:11 */
  always @*
    case (n2060)
      5'b10000: n2073 = 1'b0;
      5'b01000: n2073 = 1'b0;
      5'b00100: n2073 = 1'b1;
      5'b00010: n2073 = 1'b0;
      5'b00001: n2073 = 1'b0;
      default: n2073 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:725:11 */
  always @*
    case (n2060)
      5'b10000: n2076 = 1'b0;
      5'b01000: n2076 = 1'b1;
      5'b00100: n2076 = 1'b0;
      5'b00010: n2076 = 1'b0;
      5'b00001: n2076 = 1'b0;
      default: n2076 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:725:11 */
  always @*
    case (n2060)
      5'b10000: n2079 = 1'b0;
      5'b01000: n2079 = 1'b0;
      5'b00100: n2079 = 1'b0;
      5'b00010: n2079 = 1'b0;
      5'b00001: n2079 = 1'b1;
      default: n2079 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:725:11 */
  always @*
    case (n2060)
      5'b10000: n2082 = 1'b0;
      5'b01000: n2082 = 1'b0;
      5'b00100: n2082 = 1'b0;
      5'b00010: n2082 = 1'b1;
      5'b00001: n2082 = 1'b0;
      default: n2082 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:725:11 */
  always @*
    case (n2060)
      5'b10000: n2085 = 1'b0;
      5'b01000: n2085 = 1'b1;
      5'b00100: n2085 = 1'b0;
      5'b00010: n2085 = 1'b0;
      5'b00001: n2085 = 1'b0;
      default: n2085 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:725:11 */
  always @*
    case (n2060)
      5'b10000: n2088 = 1'b0;
      5'b01000: n2088 = 1'b1;
      5'b00100: n2088 = n2044;
      5'b00010: n2088 = 1'b0;
      5'b00001: n2088 = 1'b0;
      default: n2088 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:725:11 */
  always @*
    case (n2060)
      5'b10000: n2090 = n2057;
      5'b01000: n2090 = 1'b0;
      5'b00100: n2090 = 1'b0;
      5'b00010: n2090 = 1'b0;
      5'b00001: n2090 = 1'b0;
      default: n2090 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:753:16 */
  assign n2091 = ir[7:6]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:753:29 */
  assign n2093 = n2091 != 2'b10;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:753:11 */
  assign n2095 = n2093 ? 1'b1 : n1049;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:757:13 */
  assign n2097 = mcycle == 3'b000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:758:13 */
  assign n2099 = mcycle == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:764:20 */
  assign n2100 = ir[7:5]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:764:33 */
  assign n2102 = n2100 == 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:764:15 */
  assign n2105 = n2102 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:761:13 */
  assign n2107 = mcycle == 3'b010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:768:13 */
  assign n2109 = mcycle == 3'b011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:756:11 */
  assign n2110 = {n2109, n2107, n2099, n2097};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:756:11 */
  always @*
    case (n2110)
      4'b1000: n2113 = 2'b10;
      4'b0100: n2113 = 2'b11;
      4'b0010: n2113 = 2'b10;
      4'b0001: n2113 = 2'b10;
      default: n2113 = 2'b10;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:756:11 */
  always @*
    case (n2110)
      4'b1000: n2117 = 2'b00;
      4'b0100: n2117 = 2'b01;
      4'b0010: n2117 = 2'b01;
      4'b0001: n2117 = 2'b00;
      default: n2117 = 2'b00;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:756:11 */
  always @*
    case (n2110)
      4'b1000: n2120 = 1'b0;
      4'b0100: n2120 = 1'b0;
      4'b0010: n2120 = 1'b1;
      4'b0001: n2120 = 1'b0;
      default: n2120 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:756:11 */
  always @*
    case (n2110)
      4'b1000: n2123 = 1'b0;
      4'b0100: n2123 = 1'b1;
      4'b0010: n2123 = 1'b0;
      4'b0001: n2123 = 1'b0;
      default: n2123 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:756:11 */
  always @*
    case (n2110)
      4'b1000: n2125 = 1'b0;
      4'b0100: n2125 = n2105;
      4'b0010: n2125 = 1'b0;
      4'b0001: n2125 = 1'b0;
      default: n2125 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:719:9 */
  assign n2128 = n2029 ? 3'b101 : 3'b011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:719:9 */
  assign n2129 = n2029 ? n2061 : n1076;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:719:9 */
  assign n2130 = n2029 ? n2066 : n2113;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:719:9 */
  assign n2131 = n2029 ? n2070 : n2117;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:719:9 */
  assign n2132 = n2029 ? n2035 : n2095;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:719:9 */
  assign n2134 = n2029 ? n2073 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:719:9 */
  assign n2136 = n2029 ? n2076 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:719:9 */
  assign n2137 = n2029 ? n2079 : n2120;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:719:9 */
  assign n2138 = n2029 ? n2082 : n2123;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:719:9 */
  assign n2140 = n2029 ? n2085 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:719:9 */
  assign n2141 = n2029 ? n2088 : n2125;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:719:9 */
  assign n2143 = n2029 ? n2090 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:717:7 */
  assign n2145 = n1077 == 5'b01101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:717:20 */
  assign n2147 = n1077 == 5'b01110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:717:20 */
  assign n2148 = n2145 | n2147;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:717:30 */
  assign n2150 = n1077 == 5'b01111;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:717:30 */
  assign n2151 = n2148 | n2150;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:780:9 */
  assign n2154 = branch ? 3'b011 : 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:794:11 */
  assign n2156 = mcycle == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:805:11 */
  assign n2158 = mcycle == 3'b010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:814:11 */
  assign n2160 = mcycle == 3'b011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:789:9 */
  assign n2161 = {n2160, n2158, n2156};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:789:9 */
  always @*
    case (n2161)
      3'b100: n2165 = 2'b00;
      3'b010: n2165 = 2'b11;
      3'b001: n2165 = 2'b01;
      default: n2165 = 2'b00;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:789:9 */
  always @*
    case (n2161)
      3'b100: n2168 = 1'b0;
      3'b010: n2168 = 1'b1;
      3'b001: n2168 = 1'b0;
      default: n2168 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:789:9 */
  always @*
    case (n2161)
      3'b100: n2171 = 1'b0;
      3'b010: n2171 = 1'b0;
      3'b001: n2171 = 1'b1;
      default: n2171 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:774:7 */
  assign n2173 = n1077 == 5'b10000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:822:14 */
  assign n2174 = ir[7:6]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:822:27 */
  assign n2176 = n2174 != 2'b10;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:824:18 */
  assign n2178 = mode == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:824:30 */
  assign n2179 = ir[1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:824:24 */
  assign n2180 = n2179 & n2178;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:824:11 */
  assign n2183 = n2180 ? 3'b111 : 3'b101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:822:9 */
  assign n2185 = n2176 ? n2183 : 3'b101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:822:9 */
  assign n2188 = n2176 ? 1'b1 : n1049;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:829:11 */
  assign n2190 = mcycle == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:833:11 */
  assign n2192 = mcycle == 3'b010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:837:11 */
  assign n2194 = mcycle == 3'b011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:844:18 */
  assign n2195 = ir[7:5]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:844:31 */
  assign n2197 = n2195 == 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:846:21 */
  assign n2198 = ir[1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:846:24 */
  assign n2199 = ~n2198;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:846:34 */
  assign n2201 = ir == 8'b10110011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:846:29 */
  assign n2202 = n2199 | n2201;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:846:13 */
  assign n2205 = n2202 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:844:13 */
  assign n2207 = n2197 ? 1'b0 : n2205;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:844:13 */
  assign n2210 = n2197 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:842:11 */
  assign n2212 = mcycle == 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:851:20 */
  assign n2214 = mode == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:851:32 */
  assign n2215 = ir[1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:851:26 */
  assign n2216 = n2215 & n2214;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:851:46 */
  assign n2217 = ir[7:6]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:851:58 */
  assign n2219 = n2217 != 2'b10;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:851:40 */
  assign n2220 = n2219 & n2216;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:851:13 */
  assign n2223 = n2220 ? 2'b11 : 2'b10;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:851:13 */
  assign n2226 = n2220 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:851:13 */
  assign n2229 = n2220 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:850:11 */
  assign n2231 = mcycle == 3'b101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:856:11 */
  assign n2233 = mcycle == 3'b110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:861:11 */
  assign n2235 = mcycle == 3'b111;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:828:9 */
  assign n2236 = {n2235, n2233, n2231, n2212, n2194, n2192, n2190};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:828:9 */
  always @*
    case (n2236)
      7'b1000000: n2239 = 4'b0001;
      7'b0100000: n2239 = n1076;
      7'b0010000: n2239 = n1076;
      7'b0001000: n2239 = n1076;
      7'b0000100: n2239 = 4'b0011;
      7'b0000010: n2239 = n1076;
      7'b0000001: n2239 = n1076;
      default: n2239 = n1076;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:828:9 */
  always @*
    case (n2236)
      7'b1000000: n2246 = 2'b10;
      7'b0100000: n2246 = 2'b11;
      7'b0010000: n2246 = n2223;
      7'b0001000: n2246 = 2'b11;
      7'b0000100: n2246 = 2'b11;
      7'b0000010: n2246 = 2'b01;
      7'b0000001: n2246 = 2'b01;
      default: n2246 = 2'b10;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:828:9 */
  always @*
    case (n2236)
      7'b1000000: n2249 = 2'b00;
      7'b0100000: n2249 = 2'b00;
      7'b0010000: n2249 = 2'b00;
      7'b0001000: n2249 = 2'b00;
      7'b0000100: n2249 = 2'b00;
      7'b0000010: n2249 = 2'b00;
      7'b0000001: n2249 = 2'b01;
      default: n2249 = 2'b00;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:828:9 */
  always @*
    case (n2236)
      7'b1000000: n2254 = 2'b00;
      7'b0100000: n2254 = 2'b00;
      7'b0010000: n2254 = 2'b00;
      7'b0001000: n2254 = 2'b11;
      7'b0000100: n2254 = 2'b10;
      7'b0000010: n2254 = 2'b01;
      7'b0000001: n2254 = 2'b00;
      default: n2254 = 2'b00;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:828:9 */
  always @*
    case (n2236)
      7'b1000000: n2256 = 1'b0;
      7'b0100000: n2256 = 1'b0;
      7'b0010000: n2256 = 1'b0;
      7'b0001000: n2256 = n2207;
      7'b0000100: n2256 = 1'b0;
      7'b0000010: n2256 = 1'b0;
      7'b0000001: n2256 = 1'b0;
      default: n2256 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:828:9 */
  always @*
    case (n2236)
      7'b1000000: n2258 = 1'b0;
      7'b0100000: n2258 = 1'b0;
      7'b0010000: n2258 = n2226;
      7'b0001000: n2258 = 1'b0;
      7'b0000100: n2258 = 1'b0;
      7'b0000010: n2258 = 1'b0;
      7'b0000001: n2258 = 1'b0;
      default: n2258 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:828:9 */
  always @*
    case (n2236)
      7'b1000000: n2261 = 1'b0;
      7'b0100000: n2261 = 1'b1;
      7'b0010000: n2261 = 1'b0;
      7'b0001000: n2261 = 1'b0;
      7'b0000100: n2261 = 1'b0;
      7'b0000010: n2261 = 1'b0;
      7'b0000001: n2261 = 1'b0;
      default: n2261 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:828:9 */
  always @*
    case (n2236)
      7'b1000000: n2264 = 1'b0;
      7'b0100000: n2264 = 1'b0;
      7'b0010000: n2264 = 1'b0;
      7'b0001000: n2264 = 1'b0;
      7'b0000100: n2264 = 1'b0;
      7'b0000010: n2264 = 1'b0;
      7'b0000001: n2264 = 1'b1;
      default: n2264 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:828:9 */
  always @*
    case (n2236)
      7'b1000000: n2267 = 1'b0;
      7'b0100000: n2267 = 1'b0;
      7'b0010000: n2267 = 1'b0;
      7'b0001000: n2267 = 1'b0;
      7'b0000100: n2267 = 1'b0;
      7'b0000010: n2267 = 1'b1;
      7'b0000001: n2267 = 1'b0;
      default: n2267 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:828:9 */
  always @*
    case (n2236)
      7'b1000000: n2270 = 1'b0;
      7'b0100000: n2270 = 1'b0;
      7'b0010000: n2270 = 1'b0;
      7'b0001000: n2270 = 1'b0;
      7'b0000100: n2270 = 1'b1;
      7'b0000010: n2270 = 1'b0;
      7'b0000001: n2270 = 1'b0;
      default: n2270 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:828:9 */
  always @*
    case (n2236)
      7'b1000000: n2273 = 1'b0;
      7'b0100000: n2273 = 1'b1;
      7'b0010000: n2273 = 1'b0;
      7'b0001000: n2273 = 1'b0;
      7'b0000100: n2273 = 1'b0;
      7'b0000010: n2273 = 1'b0;
      7'b0000001: n2273 = 1'b0;
      default: n2273 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:828:9 */
  always @*
    case (n2236)
      7'b1000000: n2276 = 1'b0;
      7'b0100000: n2276 = 1'b1;
      7'b0010000: n2276 = n2229;
      7'b0001000: n2276 = n2210;
      7'b0000100: n2276 = 1'b0;
      7'b0000010: n2276 = 1'b0;
      7'b0000001: n2276 = 1'b0;
      default: n2276 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:828:9 */
  always @*
    case (n2236)
      7'b1000000: n2279 = 1'b1;
      7'b0100000: n2279 = 1'b0;
      7'b0010000: n2279 = 1'b0;
      7'b0001000: n2279 = 1'b0;
      7'b0000100: n2279 = 1'b0;
      7'b0000010: n2279 = 1'b0;
      7'b0000001: n2279 = 1'b0;
      default: n2279 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:820:7 */
  assign n2281 = n1077 == 5'b10001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:820:20 */
  assign n2283 = n1077 == 5'b10011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:820:20 */
  assign n2284 = n2281 | n2283;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:873:14 */
  assign n2285 = ir[7:6]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:873:27 */
  assign n2287 = n2285 != 2'b10;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:873:41 */
  assign n2288 = ir[1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:873:35 */
  assign n2289 = n2288 & n2287;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:873:60 */
  assign n2291 = mode == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:873:71 */
  assign n2292 = ir[0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:873:74 */
  assign n2293 = ~n2292;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:873:66 */
  assign n2294 = n2291 | n2293;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:873:51 */
  assign n2295 = n2294 & n2289;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:875:18 */
  assign n2297 = mode == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:875:30 */
  assign n2298 = ir[0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:875:24 */
  assign n2299 = n2298 & n2297;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:875:11 */
  assign n2301 = n2299 ? 1'b1 : n1049;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:880:13 */
  assign n2303 = mcycle == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:884:13 */
  assign n2305 = mcycle == 3'b010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:889:22 */
  assign n2307 = mode == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:889:15 */
  assign n2310 = n2307 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:887:13 */
  assign n2312 = mcycle == 3'b011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:898:22 */
  assign n2314 = mode == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:898:34 */
  assign n2315 = ir[0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:898:28 */
  assign n2316 = n2315 & n2314;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:898:15 */
  assign n2319 = n2316 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:893:13 */
  assign n2321 = mcycle == 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:902:22 */
  assign n2323 = mode == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:902:34 */
  assign n2324 = ir[0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:902:28 */
  assign n2325 = n2324 & n2323;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:902:15 */
  assign n2327 = n2325 ? 4'b0001 : n1076;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:902:15 */
  assign n2330 = n2325 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:901:13 */
  assign n2332 = mcycle == 3'b101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:879:11 */
  assign n2333 = {n2332, n2321, n2312, n2305, n2303};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:879:11 */
  always @*
    case (n2333)
      5'b10000: n2334 = n2327;
      5'b01000: n2334 = n1076;
      5'b00100: n2334 = n1076;
      5'b00010: n2334 = n1076;
      5'b00001: n2334 = n1076;
      default: n2334 = n1076;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:879:11 */
  always @*
    case (n2333)
      5'b10000: n2340 = 2'b10;
      5'b01000: n2340 = 2'b01;
      5'b00100: n2340 = 2'b01;
      5'b00010: n2340 = 2'b01;
      5'b00001: n2340 = 2'b01;
      default: n2340 = 2'b10;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:879:11 */
  always @*
    case (n2333)
      5'b10000: n2343 = 2'b00;
      5'b01000: n2343 = 2'b00;
      5'b00100: n2343 = 2'b00;
      5'b00010: n2343 = 2'b00;
      5'b00001: n2343 = 2'b01;
      default: n2343 = 2'b00;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:879:11 */
  always @*
    case (n2333)
      5'b10000: n2346 = 1'b0;
      5'b01000: n2346 = 1'b0;
      5'b00100: n2346 = 1'b0;
      5'b00010: n2346 = 1'b1;
      5'b00001: n2346 = 1'b0;
      default: n2346 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:879:11 */
  always @*
    case (n2333)
      5'b10000: n2349 = 1'b0;
      5'b01000: n2349 = n2319;
      5'b00100: n2349 = 1'b1;
      5'b00010: n2349 = 1'b0;
      5'b00001: n2349 = 1'b0;
      default: n2349 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:879:11 */
  always @*
    case (n2333)
      5'b10000: n2352 = 1'b0;
      5'b01000: n2352 = 1'b1;
      5'b00100: n2352 = 1'b0;
      5'b00010: n2352 = 1'b0;
      5'b00001: n2352 = 1'b0;
      default: n2352 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:879:11 */
  always @*
    case (n2333)
      5'b10000: n2355 = 1'b0;
      5'b01000: n2355 = 1'b0;
      5'b00100: n2355 = 1'b0;
      5'b00010: n2355 = 1'b0;
      5'b00001: n2355 = 1'b1;
      default: n2355 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:879:11 */
  always @*
    case (n2333)
      5'b10000: n2358 = 1'b0;
      5'b01000: n2358 = 1'b1;
      5'b00100: n2358 = 1'b0;
      5'b00010: n2358 = 1'b0;
      5'b00001: n2358 = 1'b0;
      default: n2358 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:879:11 */
  always @*
    case (n2333)
      5'b10000: n2361 = 1'b0;
      5'b01000: n2361 = 1'b1;
      5'b00100: n2361 = n2310;
      5'b00010: n2361 = 1'b0;
      5'b00001: n2361 = 1'b0;
      default: n2361 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:879:11 */
  always @*
    case (n2333)
      5'b10000: n2363 = n2330;
      5'b01000: n2363 = 1'b0;
      5'b00100: n2363 = 1'b0;
      5'b00010: n2363 = 1'b0;
      5'b00001: n2363 = 1'b0;
      default: n2363 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:910:16 */
  assign n2364 = ir[7:6]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:910:29 */
  assign n2366 = n2364 != 2'b10;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:910:43 */
  assign n2367 = ir[0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:910:37 */
  assign n2368 = n2367 & n2366;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:910:11 */
  assign n2370 = n2368 ? 1'b1 : n1049;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:914:13 */
  assign n2372 = mcycle == 3'b000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:915:13 */
  assign n2374 = mcycle == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:922:21 */
  assign n2375 = ir[3:1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:922:34 */
  assign n2377 = n2375 == 3'b011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:922:15 */
  assign n2380 = n2377 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:925:20 */
  assign n2381 = ir[7:5]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:925:33 */
  assign n2383 = n2381 == 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:925:15 */
  assign n2386 = n2383 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:919:13 */
  assign n2388 = mcycle == 3'b010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:929:13 */
  assign n2390 = mcycle == 3'b011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:913:11 */
  assign n2391 = {n2390, n2388, n2374, n2372};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:913:11 */
  always @*
    case (n2391)
      4'b1000: n2395 = 2'b10;
      4'b0100: n2395 = 2'b01;
      4'b0010: n2395 = 2'b01;
      4'b0001: n2395 = 2'b10;
      default: n2395 = 2'b10;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:913:11 */
  always @*
    case (n2391)
      4'b1000: n2398 = 2'b00;
      4'b0100: n2398 = 2'b00;
      4'b0010: n2398 = 2'b01;
      4'b0001: n2398 = 2'b00;
      default: n2398 = 2'b00;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:913:11 */
  always @*
    case (n2391)
      4'b1000: n2401 = 1'b0;
      4'b0100: n2401 = 1'b1;
      4'b0010: n2401 = 1'b0;
      4'b0001: n2401 = 1'b0;
      default: n2401 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:913:11 */
  always @*
    case (n2391)
      4'b1000: n2403 = 1'b0;
      4'b0100: n2403 = n2380;
      4'b0010: n2403 = 1'b0;
      4'b0001: n2403 = 1'b0;
      default: n2403 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:913:11 */
  always @*
    case (n2391)
      4'b1000: n2406 = 1'b0;
      4'b0100: n2406 = 1'b0;
      4'b0010: n2406 = 1'b1;
      4'b0001: n2406 = 1'b0;
      default: n2406 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:913:11 */
  always @*
    case (n2391)
      4'b1000: n2408 = 1'b0;
      4'b0100: n2408 = n2386;
      4'b0010: n2408 = 1'b0;
      4'b0001: n2408 = 1'b0;
      default: n2408 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:873:9 */
  assign n2411 = n2295 ? 3'b101 : 3'b011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:873:9 */
  assign n2412 = n2295 ? n2334 : n1076;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:873:9 */
  assign n2413 = n2295 ? n2340 : n2395;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:873:9 */
  assign n2414 = n2295 ? n2343 : n2398;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:873:9 */
  assign n2415 = n2295 ? n2346 : n2401;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:873:9 */
  assign n2417 = n2295 ? 1'b0 : n2403;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:873:9 */
  assign n2418 = n2295 ? n2301 : n2370;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:873:9 */
  assign n2420 = n2295 ? n2349 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:873:9 */
  assign n2422 = n2295 ? n2352 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:873:9 */
  assign n2423 = n2295 ? n2355 : n2406;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:873:9 */
  assign n2425 = n2295 ? n2358 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:873:9 */
  assign n2426 = n2295 ? n2361 : n2408;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:873:9 */
  assign n2428 = n2295 ? n2363 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:871:7 */
  assign n2430 = n1077 == 5'b10100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:871:20 */
  assign n2432 = n1077 == 5'b10101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:871:20 */
  assign n2433 = n2430 | n2432;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:871:30 */
  assign n2435 = n1077 == 5'b10110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:871:30 */
  assign n2436 = n2433 | n2435;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:871:40 */
  assign n2438 = n1077 == 5'b10111;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:871:40 */
  assign n2439 = n2436 | n2438;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:939:14 */
  assign n2440 = ir[7:6]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:939:27 */
  assign n2442 = n2440 != 2'b10;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:941:18 */
  assign n2444 = mode == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:941:30 */
  assign n2445 = ir[1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:941:24 */
  assign n2446 = n2445 & n2444;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:941:11 */
  assign n2449 = n2446 ? 3'b110 : 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:939:9 */
  assign n2451 = n2442 ? n2449 : 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:939:9 */
  assign n2454 = n2442 ? 1'b1 : n1049;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:946:11 */
  assign n2456 = mcycle == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:949:11 */
  assign n2458 = mcycle == 3'b010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:957:18 */
  assign n2459 = ir[7:5]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:957:31 */
  assign n2461 = n2459 == 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:959:21 */
  assign n2462 = ir[1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:959:24 */
  assign n2463 = ~n2462;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:959:34 */
  assign n2465 = ir == 8'b10111011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:959:29 */
  assign n2466 = n2463 | n2465;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:959:13 */
  assign n2469 = n2466 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:957:13 */
  assign n2471 = n2461 ? 1'b0 : n2469;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:957:13 */
  assign n2474 = n2461 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:955:11 */
  assign n2476 = mcycle == 3'b011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:964:20 */
  assign n2478 = mode == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:964:32 */
  assign n2479 = ir[1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:964:26 */
  assign n2480 = n2479 & n2478;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:964:46 */
  assign n2481 = ir[7:6]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:964:58 */
  assign n2483 = n2481 != 2'b10;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:964:40 */
  assign n2484 = n2483 & n2480;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:964:13 */
  assign n2487 = n2484 ? 2'b11 : 2'b10;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:964:13 */
  assign n2490 = n2484 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:964:13 */
  assign n2493 = n2484 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:963:11 */
  assign n2495 = mcycle == 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:969:11 */
  assign n2497 = mcycle == 3'b101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:974:11 */
  assign n2499 = mcycle == 3'b110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:945:9 */
  assign n2500 = {n2499, n2497, n2495, n2476, n2458, n2456};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:945:9 */
  always @*
    case (n2500)
      6'b100000: n2503 = 4'b0001;
      6'b010000: n2503 = n1076;
      6'b001000: n2503 = n1076;
      6'b000100: n2503 = n1076;
      6'b000010: n2503 = 4'b0011;
      6'b000001: n2503 = n1076;
      default: n2503 = n1076;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:945:9 */
  always @*
    case (n2500)
      6'b100000: n2508 = 2'b10;
      6'b010000: n2508 = 2'b11;
      6'b001000: n2508 = n2487;
      6'b000100: n2508 = 2'b11;
      6'b000010: n2508 = 2'b11;
      6'b000001: n2508 = 2'b10;
      default: n2508 = 2'b10;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:945:9 */
  always @*
    case (n2500)
      6'b100000: n2512 = 2'b00;
      6'b010000: n2512 = 2'b00;
      6'b001000: n2512 = 2'b00;
      6'b000100: n2512 = 2'b00;
      6'b000010: n2512 = 2'b01;
      6'b000001: n2512 = 2'b01;
      default: n2512 = 2'b00;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:945:9 */
  always @*
    case (n2500)
      6'b100000: n2516 = 2'b00;
      6'b010000: n2516 = 2'b00;
      6'b001000: n2516 = 2'b00;
      6'b000100: n2516 = 2'b11;
      6'b000010: n2516 = 2'b10;
      6'b000001: n2516 = 2'b00;
      default: n2516 = 2'b00;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:945:9 */
  always @*
    case (n2500)
      6'b100000: n2518 = 1'b0;
      6'b010000: n2518 = 1'b0;
      6'b001000: n2518 = 1'b0;
      6'b000100: n2518 = n2471;
      6'b000010: n2518 = 1'b0;
      6'b000001: n2518 = 1'b0;
      default: n2518 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:945:9 */
  always @*
    case (n2500)
      6'b100000: n2520 = 1'b0;
      6'b010000: n2520 = 1'b0;
      6'b001000: n2520 = n2490;
      6'b000100: n2520 = 1'b0;
      6'b000010: n2520 = 1'b0;
      6'b000001: n2520 = 1'b0;
      default: n2520 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:945:9 */
  always @*
    case (n2500)
      6'b100000: n2523 = 1'b0;
      6'b010000: n2523 = 1'b1;
      6'b001000: n2523 = 1'b0;
      6'b000100: n2523 = 1'b0;
      6'b000010: n2523 = 1'b0;
      6'b000001: n2523 = 1'b0;
      default: n2523 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:945:9 */
  always @*
    case (n2500)
      6'b100000: n2526 = 1'b0;
      6'b010000: n2526 = 1'b0;
      6'b001000: n2526 = 1'b0;
      6'b000100: n2526 = 1'b0;
      6'b000010: n2526 = 1'b0;
      6'b000001: n2526 = 1'b1;
      default: n2526 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:945:9 */
  always @*
    case (n2500)
      6'b100000: n2529 = 1'b0;
      6'b010000: n2529 = 1'b0;
      6'b001000: n2529 = 1'b0;
      6'b000100: n2529 = 1'b0;
      6'b000010: n2529 = 1'b1;
      6'b000001: n2529 = 1'b0;
      default: n2529 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:945:9 */
  always @*
    case (n2500)
      6'b100000: n2532 = 1'b0;
      6'b010000: n2532 = 1'b1;
      6'b001000: n2532 = 1'b0;
      6'b000100: n2532 = 1'b0;
      6'b000010: n2532 = 1'b0;
      6'b000001: n2532 = 1'b0;
      default: n2532 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:945:9 */
  always @*
    case (n2500)
      6'b100000: n2535 = 1'b0;
      6'b010000: n2535 = 1'b1;
      6'b001000: n2535 = n2493;
      6'b000100: n2535 = n2474;
      6'b000010: n2535 = 1'b0;
      6'b000001: n2535 = 1'b0;
      default: n2535 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:945:9 */
  always @*
    case (n2500)
      6'b100000: n2538 = 1'b1;
      6'b010000: n2538 = 1'b0;
      6'b001000: n2538 = 1'b0;
      6'b000100: n2538 = 1'b0;
      6'b000010: n2538 = 1'b0;
      6'b000001: n2538 = 1'b0;
      default: n2538 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:936:7 */
  assign n2540 = n1077 == 5'b11001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:936:20 */
  assign n2542 = n1077 == 5'b11011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:936:20 */
  assign n2543 = n2540 | n2542;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:986:14 */
  assign n2544 = ir[7:6]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:986:27 */
  assign n2546 = n2544 != 2'b10;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:986:41 */
  assign n2547 = ir[1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:986:35 */
  assign n2548 = n2547 & n2546;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:986:60 */
  assign n2550 = mode == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:986:71 */
  assign n2551 = ir[0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:986:74 */
  assign n2552 = ~n2551;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:986:66 */
  assign n2553 = n2550 | n2552;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:986:51 */
  assign n2554 = n2553 & n2548;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:989:18 */
  assign n2556 = mode == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:989:30 */
  assign n2557 = ir[0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:989:24 */
  assign n2558 = n2557 & n2556;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:989:11 */
  assign n2560 = n2558 ? 1'b1 : n1049;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:993:13 */
  assign n2562 = mcycle == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:996:13 */
  assign n2564 = mcycle == 3'b010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1002:13 */
  assign n2566 = mcycle == 3'b011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1007:22 */
  assign n2568 = mode == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1007:15 */
  assign n2571 = n2568 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1005:13 */
  assign n2573 = mcycle == 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1011:13 */
  assign n2575 = mcycle == 3'b101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1017:22 */
  assign n2577 = mode == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1017:34 */
  assign n2578 = ir[0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1017:28 */
  assign n2579 = n2578 & n2577;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1017:15 */
  assign n2581 = n2579 ? 4'b0001 : n1076;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1017:15 */
  assign n2584 = n2579 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1016:13 */
  assign n2586 = mcycle == 3'b110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:992:11 */
  assign n2587 = {n2586, n2575, n2573, n2566, n2564, n2562};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:992:11 */
  always @*
    case (n2587)
      6'b100000: n2589 = n2581;
      6'b010000: n2589 = n1076;
      6'b001000: n2589 = n1076;
      6'b000100: n2589 = n1076;
      6'b000010: n2589 = 4'b0010;
      6'b000001: n2589 = n1076;
      default: n2589 = n1076;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:992:11 */
  always @*
    case (n2587)
      6'b100000: n2595 = 2'b10;
      6'b010000: n2595 = 2'b11;
      6'b001000: n2595 = 2'b11;
      6'b000100: n2595 = 2'b11;
      6'b000010: n2595 = 2'b11;
      6'b000001: n2595 = 2'b10;
      default: n2595 = 2'b10;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:992:11 */
  always @*
    case (n2587)
      6'b100000: n2599 = 2'b00;
      6'b010000: n2599 = 2'b00;
      6'b001000: n2599 = 2'b00;
      6'b000100: n2599 = 2'b00;
      6'b000010: n2599 = 2'b01;
      6'b000001: n2599 = 2'b01;
      default: n2599 = 2'b00;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:992:11 */
  always @*
    case (n2587)
      6'b100000: n2603 = 2'b00;
      6'b010000: n2603 = 2'b00;
      6'b001000: n2603 = 2'b00;
      6'b000100: n2603 = 2'b11;
      6'b000010: n2603 = 2'b10;
      6'b000001: n2603 = 2'b00;
      default: n2603 = 2'b00;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:992:11 */
  always @*
    case (n2587)
      6'b100000: n2606 = 1'b0;
      6'b010000: n2606 = 1'b0;
      6'b001000: n2606 = 1'b1;
      6'b000100: n2606 = 1'b0;
      6'b000010: n2606 = 1'b0;
      6'b000001: n2606 = 1'b0;
      default: n2606 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:992:11 */
  always @*
    case (n2587)
      6'b100000: n2609 = 1'b0;
      6'b010000: n2609 = 1'b1;
      6'b001000: n2609 = 1'b0;
      6'b000100: n2609 = 1'b0;
      6'b000010: n2609 = 1'b0;
      6'b000001: n2609 = 1'b0;
      default: n2609 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:992:11 */
  always @*
    case (n2587)
      6'b100000: n2612 = 1'b0;
      6'b010000: n2612 = 1'b0;
      6'b001000: n2612 = 1'b0;
      6'b000100: n2612 = 1'b0;
      6'b000010: n2612 = 1'b0;
      6'b000001: n2612 = 1'b1;
      default: n2612 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:992:11 */
  always @*
    case (n2587)
      6'b100000: n2615 = 1'b0;
      6'b010000: n2615 = 1'b0;
      6'b001000: n2615 = 1'b0;
      6'b000100: n2615 = 1'b0;
      6'b000010: n2615 = 1'b1;
      6'b000001: n2615 = 1'b0;
      default: n2615 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:992:11 */
  always @*
    case (n2587)
      6'b100000: n2618 = 1'b0;
      6'b010000: n2618 = 1'b1;
      6'b001000: n2618 = 1'b0;
      6'b000100: n2618 = 1'b0;
      6'b000010: n2618 = 1'b0;
      6'b000001: n2618 = 1'b0;
      default: n2618 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:992:11 */
  always @*
    case (n2587)
      6'b100000: n2621 = 1'b0;
      6'b010000: n2621 = 1'b1;
      6'b001000: n2621 = n2571;
      6'b000100: n2621 = 1'b0;
      6'b000010: n2621 = 1'b0;
      6'b000001: n2621 = 1'b0;
      default: n2621 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:992:11 */
  always @*
    case (n2587)
      6'b100000: n2623 = n2584;
      6'b010000: n2623 = 1'b0;
      6'b001000: n2623 = 1'b0;
      6'b000100: n2623 = 1'b0;
      6'b000010: n2623 = 1'b0;
      6'b000001: n2623 = 1'b0;
      default: n2623 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1025:16 */
  assign n2624 = ir[7:6]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1025:29 */
  assign n2626 = n2624 != 2'b10;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1026:20 */
  assign n2628 = mode != 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1026:32 */
  assign n2629 = ir[4]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1026:35 */
  assign n2630 = ~n2629;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1026:27 */
  assign n2631 = n2628 | n2630;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1026:45 */
  assign n2632 = ir[1:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1026:57 */
  assign n2634 = n2632 != 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1026:40 */
  assign n2635 = n2631 | n2634;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1025:11 */
  assign n2637 = n2638 ? 1'b1 : n1049;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1025:11 */
  assign n2638 = n2635 & n2626;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1031:13 */
  assign n2640 = mcycle == 3'b000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1032:13 */
  assign n2642 = mcycle == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1038:20 */
  assign n2643 = ir[7:6]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1038:32 */
  assign n2645 = n2643 == 2'b10;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1038:44 */
  assign n2646 = ir[4:1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1038:56 */
  assign n2648 = n2646 == 4'b1111;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1038:38 */
  assign n2649 = n2648 & n2645;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1038:15 */
  assign n2652 = n2649 ? 4'b0011 : 4'b0010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1035:13 */
  assign n2654 = mcycle == 3'b010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1048:20 */
  assign n2655 = ir[7:5]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1048:33 */
  assign n2657 = n2655 == 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1048:15 */
  assign n2660 = n2657 ? 1'b0 : 1'b1;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1048:15 */
  assign n2663 = n2657 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1046:13 */
  assign n2665 = mcycle == 3'b011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1054:13 */
  assign n2667 = mcycle == 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1030:11 */
  assign n2668 = {n2667, n2665, n2654, n2642, n2640};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1030:11 */
  always @*
    case (n2668)
      5'b10000: n2669 = n1076;
      5'b01000: n2669 = n1076;
      5'b00100: n2669 = n2652;
      5'b00010: n2669 = n1076;
      5'b00001: n2669 = n1076;
      default: n2669 = n1076;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1030:11 */
  always @*
    case (n2668)
      5'b10000: n2673 = 2'b10;
      5'b01000: n2673 = 2'b11;
      5'b00100: n2673 = 2'b11;
      5'b00010: n2673 = 2'b10;
      5'b00001: n2673 = 2'b10;
      default: n2673 = 2'b10;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1030:11 */
  always @*
    case (n2668)
      5'b10000: n2677 = 2'b00;
      5'b01000: n2677 = 2'b00;
      5'b00100: n2677 = 2'b01;
      5'b00010: n2677 = 2'b01;
      5'b00001: n2677 = 2'b00;
      default: n2677 = 2'b00;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1030:11 */
  always @*
    case (n2668)
      5'b10000: n2681 = 2'b00;
      5'b01000: n2681 = 2'b11;
      5'b00100: n2681 = 2'b10;
      5'b00010: n2681 = 2'b00;
      5'b00001: n2681 = 2'b00;
      default: n2681 = 2'b00;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1030:11 */
  always @*
    case (n2668)
      5'b10000: n2683 = 1'b0;
      5'b01000: n2683 = n2660;
      5'b00100: n2683 = 1'b0;
      5'b00010: n2683 = 1'b0;
      5'b00001: n2683 = 1'b0;
      default: n2683 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1030:11 */
  always @*
    case (n2668)
      5'b10000: n2686 = 1'b0;
      5'b01000: n2686 = 1'b0;
      5'b00100: n2686 = 1'b0;
      5'b00010: n2686 = 1'b1;
      5'b00001: n2686 = 1'b0;
      default: n2686 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1030:11 */
  always @*
    case (n2668)
      5'b10000: n2689 = 1'b0;
      5'b01000: n2689 = 1'b0;
      5'b00100: n2689 = 1'b1;
      5'b00010: n2689 = 1'b0;
      5'b00001: n2689 = 1'b0;
      default: n2689 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1030:11 */
  always @*
    case (n2668)
      5'b10000: n2691 = 1'b0;
      5'b01000: n2691 = n2663;
      5'b00100: n2691 = 1'b0;
      5'b00010: n2691 = 1'b0;
      5'b00001: n2691 = 1'b0;
      default: n2691 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:986:9 */
  assign n2694 = n2554 ? 3'b110 : 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:986:9 */
  assign n2695 = n2554 ? n2589 : n2669;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:986:9 */
  assign n2696 = n2554 ? n2595 : n2673;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:986:9 */
  assign n2697 = n2554 ? n2599 : n2677;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:986:9 */
  assign n2698 = n2554 ? n2603 : n2681;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:986:9 */
  assign n2700 = n2554 ? 1'b0 : n2683;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:986:9 */
  assign n2701 = n2554 ? n2560 : n2637;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:986:9 */
  assign n2703 = n2554 ? n2606 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:986:9 */
  assign n2705 = n2554 ? n2609 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:986:9 */
  assign n2706 = n2554 ? n2612 : n2686;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:986:9 */
  assign n2707 = n2554 ? n2615 : n2689;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:986:9 */
  assign n2709 = n2554 ? n2618 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:986:9 */
  assign n2710 = n2554 ? n2621 : n2691;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:986:9 */
  assign n2712 = n2554 ? n2623 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:984:7 */
  assign n2714 = n1077 == 5'b11100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:984:20 */
  assign n2716 = n1077 == 5'b11101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:984:20 */
  assign n2717 = n2714 | n2716;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:984:30 */
  assign n2719 = n1077 == 5'b11110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:984:30 */
  assign n2720 = n2717 | n2719;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:984:40 */
  assign n2722 = n1077 == 5'b11111;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:984:40 */
  assign n2723 = n2720 | n2722;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:219:5 */
  assign n2724 = {n2723, n2543, n2439, n2284, n2173, n2151, n2018, n1882, n1759, n1725, n1692, n1647, n1635, n1536};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2724)
      14'b10000000000000: n2727 = n2694;
      14'b01000000000000: n2727 = n2451;
      14'b00100000000000: n2727 = n2411;
      14'b00010000000000: n2727 = n2185;
      14'b00001000000000: n2727 = n2154;
      14'b00000100000000: n2727 = n2128;
      14'b00000010000000: n2727 = n2004;
      14'b00000001000000: n2727 = n1860;
      14'b00000000100000: n2727 = 3'b010;
      14'b00000000010000: n2727 = 3'b001;
      14'b00000000001000: n2727 = 3'b001;
      14'b00000000000100: n2727 = 3'b001;
      14'b00000000000010: n2727 = n1548;
      14'b00000000000001: n2727 = n1493;
      default: n2727 = 3'b001;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2724)
      14'b10000000000000: n2729 = n2695;
      14'b01000000000000: n2729 = n2503;
      14'b00100000000000: n2729 = n2412;
      14'b00010000000000: n2729 = n2239;
      14'b00001000000000: n2729 = n1076;
      14'b00000100000000: n2729 = n2129;
      14'b00000010000000: n2729 = n1076;
      14'b00000001000000: n2729 = n1861;
      14'b00000000100000: n2729 = n1076;
      14'b00000000010000: n2729 = n1076;
      14'b00000000001000: n2729 = n1686;
      14'b00000000000100: n2729 = n1076;
      14'b00000000000010: n2729 = n1591;
      14'b00000000000001: n2729 = n1495;
      default: n2729 = n1076;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2724)
      14'b10000000000000: n2731 = n2696;
      14'b01000000000000: n2731 = n2508;
      14'b00100000000000: n2731 = n2413;
      14'b00010000000000: n2731 = n2246;
      14'b00001000000000: n2731 = 2'b10;
      14'b00000100000000: n2731 = n2130;
      14'b00000010000000: n2731 = n2005;
      14'b00000001000000: n2731 = n1862;
      14'b00000000100000: n2731 = n1747;
      14'b00000000010000: n2731 = 2'b10;
      14'b00000000001000: n2731 = 2'b10;
      14'b00000000000100: n2731 = 2'b10;
      14'b00000000000010: n2731 = n1598;
      14'b00000000000001: n2731 = n1497;
      default: n2731 = 2'b10;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2724)
      14'b10000000000000: n2733 = n1046;
      14'b01000000000000: n2733 = n1046;
      14'b00100000000000: n2733 = n1046;
      14'b00010000000000: n2733 = n1046;
      14'b00001000000000: n2733 = n1046;
      14'b00000100000000: n2733 = n1046;
      14'b00000010000000: n2733 = n1046;
      14'b00000001000000: n2733 = n1046;
      14'b00000000100000: n2733 = n1046;
      14'b00000000010000: n2733 = n1046;
      14'b00000000001000: n2733 = n1046;
      14'b00000000000100: n2733 = n1046;
      14'b00000000000010: n2733 = n1046;
      14'b00000000000001: n2733 = n1498;
      default: n2733 = n1046;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2724)
      14'b10000000000000: n2735 = n2697;
      14'b01000000000000: n2735 = n2512;
      14'b00100000000000: n2735 = n2414;
      14'b00010000000000: n2735 = n2249;
      14'b00001000000000: n2735 = n2165;
      14'b00000100000000: n2735 = n2131;
      14'b00000010000000: n2735 = n2006;
      14'b00000001000000: n2735 = n1863;
      14'b00000000100000: n2735 = n1750;
      14'b00000000010000: n2735 = n1719;
      14'b00000000001000: n2735 = n1688;
      14'b00000000000100: n2735 = n1645;
      14'b00000000000010: n2735 = n1601;
      14'b00000000000001: n2735 = n1500;
      default: n2735 = 2'b00;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2724)
      14'b10000000000000: n2738 = n2698;
      14'b01000000000000: n2738 = n2516;
      14'b00100000000000: n2738 = 2'b00;
      14'b00010000000000: n2738 = n2254;
      14'b00001000000000: n2738 = 2'b00;
      14'b00000100000000: n2738 = 2'b00;
      14'b00000010000000: n2738 = n2008;
      14'b00000001000000: n2738 = 2'b00;
      14'b00000000100000: n2738 = 2'b00;
      14'b00000000010000: n2738 = 2'b00;
      14'b00000000001000: n2738 = 2'b00;
      14'b00000000000100: n2738 = 2'b00;
      14'b00000000000010: n2738 = n1604;
      14'b00000000000001: n2738 = 2'b00;
      default: n2738 = 2'b00;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2724)
      14'b10000000000000: n2741 = n2700;
      14'b01000000000000: n2741 = n2518;
      14'b00100000000000: n2741 = 1'b0;
      14'b00010000000000: n2741 = n2256;
      14'b00001000000000: n2741 = 1'b0;
      14'b00000100000000: n2741 = 1'b0;
      14'b00000010000000: n2741 = 1'b0;
      14'b00000001000000: n2741 = 1'b0;
      14'b00000000100000: n2741 = 1'b0;
      14'b00000000010000: n2741 = 1'b0;
      14'b00000000001000: n2741 = 1'b0;
      14'b00000000000100: n2741 = 1'b0;
      14'b00000000000010: n2741 = 1'b0;
      14'b00000000000001: n2741 = 1'b0;
      default: n2741 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2724)
      14'b10000000000000: n2744 = 1'b0;
      14'b01000000000000: n2744 = 1'b0;
      14'b00100000000000: n2744 = n2415;
      14'b00010000000000: n2744 = 1'b0;
      14'b00001000000000: n2744 = 1'b0;
      14'b00000100000000: n2744 = 1'b0;
      14'b00000010000000: n2744 = 1'b0;
      14'b00000001000000: n2744 = 1'b0;
      14'b00000000100000: n2744 = 1'b0;
      14'b00000000010000: n2744 = 1'b0;
      14'b00000000001000: n2744 = 1'b0;
      14'b00000000000100: n2744 = 1'b0;
      14'b00000000000010: n2744 = n1607;
      14'b00000000000001: n2744 = 1'b0;
      default: n2744 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2724)
      14'b10000000000000: n2747 = 1'b0;
      14'b01000000000000: n2747 = 1'b0;
      14'b00100000000000: n2747 = n2417;
      14'b00010000000000: n2747 = 1'b0;
      14'b00001000000000: n2747 = 1'b0;
      14'b00000100000000: n2747 = 1'b0;
      14'b00000010000000: n2747 = 1'b0;
      14'b00000001000000: n2747 = 1'b0;
      14'b00000000100000: n2747 = 1'b0;
      14'b00000000010000: n2747 = 1'b0;
      14'b00000000001000: n2747 = 1'b0;
      14'b00000000000100: n2747 = 1'b0;
      14'b00000000000010: n2747 = 1'b0;
      14'b00000000000001: n2747 = 1'b0;
      default: n2747 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2724)
      14'b10000000000000: n2750 = 1'b0;
      14'b01000000000000: n2750 = 1'b0;
      14'b00100000000000: n2750 = 1'b0;
      14'b00010000000000: n2750 = 1'b0;
      14'b00001000000000: n2750 = n2168;
      14'b00000100000000: n2750 = 1'b0;
      14'b00000010000000: n2750 = 1'b0;
      14'b00000001000000: n2750 = 1'b0;
      14'b00000000100000: n2750 = 1'b0;
      14'b00000000010000: n2750 = 1'b0;
      14'b00000000001000: n2750 = 1'b0;
      14'b00000000000100: n2750 = 1'b0;
      14'b00000000000010: n2750 = 1'b0;
      14'b00000000000001: n2750 = 1'b0;
      default: n2750 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2724)
      14'b10000000000000: n2753 = 1'b0;
      14'b01000000000000: n2753 = 1'b0;
      14'b00100000000000: n2753 = 1'b0;
      14'b00010000000000: n2753 = 1'b0;
      14'b00001000000000: n2753 = 1'b0;
      14'b00000100000000: n2753 = 1'b0;
      14'b00000010000000: n2753 = 1'b0;
      14'b00000001000000: n2753 = 1'b0;
      14'b00000000100000: n2753 = 1'b0;
      14'b00000000010000: n2753 = 1'b0;
      14'b00000000001000: n2753 = 1'b0;
      14'b00000000000100: n2753 = 1'b0;
      14'b00000000000010: n2753 = 1'b0;
      14'b00000000000001: n2753 = n1502;
      default: n2753 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2724)
      14'b10000000000000: n2756 = 1'b0;
      14'b01000000000000: n2756 = 1'b0;
      14'b00100000000000: n2756 = 1'b0;
      14'b00010000000000: n2756 = 1'b0;
      14'b00001000000000: n2756 = 1'b0;
      14'b00000100000000: n2756 = 1'b0;
      14'b00000010000000: n2756 = 1'b0;
      14'b00000001000000: n2756 = 1'b0;
      14'b00000000100000: n2756 = 1'b0;
      14'b00000000010000: n2756 = 1'b0;
      14'b00000000001000: n2756 = 1'b0;
      14'b00000000000100: n2756 = 1'b0;
      14'b00000000000010: n2756 = 1'b0;
      14'b00000000000001: n2756 = n1504;
      default: n2756 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2724)
      14'b10000000000000: n2758 = n2701;
      14'b01000000000000: n2758 = n2454;
      14'b00100000000000: n2758 = n2418;
      14'b00010000000000: n2758 = n2188;
      14'b00001000000000: n2758 = n1049;
      14'b00000100000000: n2758 = n2132;
      14'b00000010000000: n2758 = n1049;
      14'b00000001000000: n2758 = n1864;
      14'b00000000100000: n2758 = n1049;
      14'b00000000010000: n2758 = n1049;
      14'b00000000001000: n2758 = n1689;
      14'b00000000000100: n2758 = n1640;
      14'b00000000000010: n2758 = n1551;
      14'b00000000000001: n2758 = n1507;
      default: n2758 = n1049;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2724)
      14'b10000000000000: n2760 = 1'b0;
      14'b01000000000000: n2760 = 1'b0;
      14'b00100000000000: n2760 = 1'b0;
      14'b00010000000000: n2760 = 1'b0;
      14'b00001000000000: n2760 = 1'b0;
      14'b00000100000000: n2760 = 1'b0;
      14'b00000010000000: n2760 = 1'b0;
      14'b00000001000000: n2760 = 1'b0;
      14'b00000000100000: n2760 = 1'b0;
      14'b00000000010000: n2760 = 1'b0;
      14'b00000000001000: n2760 = 1'b0;
      14'b00000000000100: n2760 = 1'b0;
      14'b00000000000010: n2760 = 1'b0;
      14'b00000000000001: n2760 = n1509;
      default: n2760 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2724)
      14'b10000000000000: n2762 = n1052;
      14'b01000000000000: n2762 = n1052;
      14'b00100000000000: n2762 = n1052;
      14'b00010000000000: n2762 = n1052;
      14'b00001000000000: n2762 = n1052;
      14'b00000100000000: n2762 = n1052;
      14'b00000010000000: n2762 = n1052;
      14'b00000001000000: n2762 = n1052;
      14'b00000000100000: n2762 = n1052;
      14'b00000000010000: n2762 = n1720;
      14'b00000000001000: n2762 = n1690;
      14'b00000000000100: n2762 = n1052;
      14'b00000000000010: n2762 = n1052;
      14'b00000000000001: n2762 = n1512;
      default: n2762 = n1052;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2724)
      14'b10000000000000: n2763 = n1055;
      14'b01000000000000: n2763 = n1055;
      14'b00100000000000: n2763 = n1055;
      14'b00010000000000: n2763 = n1055;
      14'b00001000000000: n2763 = n1055;
      14'b00000100000000: n2763 = n1055;
      14'b00000010000000: n2763 = n1055;
      14'b00000001000000: n2763 = n1055;
      14'b00000000100000: n2763 = n1055;
      14'b00000000010000: n2763 = n1055;
      14'b00000000001000: n2763 = n1055;
      14'b00000000000100: n2763 = n1055;
      14'b00000000000010: n2763 = n1055;
      14'b00000000000001: n2763 = n1514;
      default: n2763 = n1055;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2724)
      14'b10000000000000: n2764 = n1058;
      14'b01000000000000: n2764 = n1058;
      14'b00100000000000: n2764 = n1058;
      14'b00010000000000: n2764 = n1058;
      14'b00001000000000: n2764 = n1058;
      14'b00000100000000: n2764 = n1058;
      14'b00000010000000: n2764 = n1058;
      14'b00000001000000: n2764 = n1058;
      14'b00000000100000: n2764 = n1058;
      14'b00000000010000: n2764 = n1058;
      14'b00000000001000: n2764 = n1058;
      14'b00000000000100: n2764 = n1058;
      14'b00000000000010: n2764 = n1058;
      14'b00000000000001: n2764 = n1516;
      default: n2764 = n1058;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2724)
      14'b10000000000000: n2766 = n2703;
      14'b01000000000000: n2766 = n2520;
      14'b00100000000000: n2766 = n2420;
      14'b00010000000000: n2766 = n2258;
      14'b00001000000000: n2766 = n2171;
      14'b00000100000000: n2766 = n2134;
      14'b00000010000000: n2766 = n2010;
      14'b00000001000000: n2766 = n1866;
      14'b00000000100000: n2766 = 1'b0;
      14'b00000000010000: n2766 = 1'b0;
      14'b00000000001000: n2766 = 1'b0;
      14'b00000000000100: n2766 = 1'b0;
      14'b00000000000010: n2766 = n1609;
      14'b00000000000001: n2766 = n1518;
      default: n2766 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2724)
      14'b10000000000000: n2769 = n2705;
      14'b01000000000000: n2769 = n2523;
      14'b00100000000000: n2769 = n2422;
      14'b00010000000000: n2769 = n2261;
      14'b00001000000000: n2769 = 1'b0;
      14'b00000100000000: n2769 = n2136;
      14'b00000010000000: n2769 = 1'b0;
      14'b00000001000000: n2769 = n1868;
      14'b00000000100000: n2769 = 1'b0;
      14'b00000000010000: n2769 = 1'b0;
      14'b00000000001000: n2769 = 1'b0;
      14'b00000000000100: n2769 = 1'b0;
      14'b00000000000010: n2769 = n1612;
      14'b00000000000001: n2769 = 1'b0;
      default: n2769 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2724)
      14'b10000000000000: n2772 = 1'b0;
      14'b01000000000000: n2772 = 1'b0;
      14'b00100000000000: n2772 = n2423;
      14'b00010000000000: n2772 = n2264;
      14'b00001000000000: n2772 = 1'b0;
      14'b00000100000000: n2772 = 1'b0;
      14'b00000010000000: n2772 = 1'b0;
      14'b00000001000000: n2772 = n1869;
      14'b00000000100000: n2772 = n1753;
      14'b00000000010000: n2772 = 1'b0;
      14'b00000000001000: n2772 = 1'b0;
      14'b00000000000100: n2772 = 1'b0;
      14'b00000000000010: n2772 = n1615;
      14'b00000000000001: n2772 = 1'b0;
      default: n2772 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2724)
      14'b10000000000000: n2775 = n2706;
      14'b01000000000000: n2775 = n2526;
      14'b00100000000000: n2775 = 1'b0;
      14'b00010000000000: n2775 = n2267;
      14'b00001000000000: n2775 = 1'b0;
      14'b00000100000000: n2775 = n2137;
      14'b00000010000000: n2775 = n2011;
      14'b00000001000000: n2775 = 1'b0;
      14'b00000000100000: n2775 = 1'b0;
      14'b00000000010000: n2775 = 1'b0;
      14'b00000000001000: n2775 = 1'b0;
      14'b00000000000100: n2775 = 1'b0;
      14'b00000000000010: n2775 = n1618;
      14'b00000000000001: n2775 = 1'b0;
      default: n2775 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2724)
      14'b10000000000000: n2778 = n2707;
      14'b01000000000000: n2778 = n2529;
      14'b00100000000000: n2778 = 1'b0;
      14'b00010000000000: n2778 = n2270;
      14'b00001000000000: n2778 = 1'b0;
      14'b00000100000000: n2778 = n2138;
      14'b00000010000000: n2778 = n2012;
      14'b00000001000000: n2778 = 1'b0;
      14'b00000000100000: n2778 = 1'b0;
      14'b00000000010000: n2778 = 1'b0;
      14'b00000000001000: n2778 = 1'b0;
      14'b00000000000100: n2778 = 1'b0;
      14'b00000000000010: n2778 = n1621;
      14'b00000000000001: n2778 = 1'b0;
      default: n2778 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2724)
      14'b10000000000000: n2781 = n2709;
      14'b01000000000000: n2781 = n2532;
      14'b00100000000000: n2781 = n2425;
      14'b00010000000000: n2781 = n2273;
      14'b00001000000000: n2781 = 1'b0;
      14'b00000100000000: n2781 = n2140;
      14'b00000010000000: n2781 = n2014;
      14'b00000001000000: n2781 = n1871;
      14'b00000000100000: n2781 = n1755;
      14'b00000000010000: n2781 = 1'b0;
      14'b00000000001000: n2781 = 1'b0;
      14'b00000000000100: n2781 = 1'b0;
      14'b00000000000010: n2781 = n1624;
      14'b00000000000001: n2781 = n1520;
      default: n2781 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2724)
      14'b10000000000000: n2784 = n2710;
      14'b01000000000000: n2784 = n2535;
      14'b00100000000000: n2784 = n2426;
      14'b00010000000000: n2784 = n2276;
      14'b00001000000000: n2784 = 1'b0;
      14'b00000100000000: n2784 = n2141;
      14'b00000010000000: n2784 = n2016;
      14'b00000001000000: n2784 = n1872;
      14'b00000000100000: n2784 = n1757;
      14'b00000000010000: n2784 = 1'b0;
      14'b00000000001000: n2784 = 1'b0;
      14'b00000000000100: n2784 = 1'b0;
      14'b00000000000010: n2784 = n1627;
      14'b00000000000001: n2784 = n1522;
      default: n2784 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:219:5 */
  always @*
    case (n2724)
      14'b10000000000000: n2787 = n2712;
      14'b01000000000000: n2787 = n2538;
      14'b00100000000000: n2787 = n2428;
      14'b00010000000000: n2787 = n2279;
      14'b00001000000000: n2787 = 1'b0;
      14'b00000100000000: n2787 = n2143;
      14'b00000010000000: n2787 = 1'b0;
      14'b00000001000000: n2787 = n1874;
      14'b00000000100000: n2787 = 1'b0;
      14'b00000000010000: n2787 = 1'b0;
      14'b00000000001000: n2787 = 1'b0;
      14'b00000000000100: n2787 = 1'b0;
      14'b00000000000010: n2787 = n1630;
      14'b00000000000001: n2787 = 1'b0;
      default: n2787 = 1'b0;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1066:12 */
  assign n2792 = ir[1:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1068:16 */
  assign n2793 = ir[4:2]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1073:18 */
  assign n2794 = ir[7:5]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1074:13 */
  assign n2796 = n2794 == 3'b110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1074:24 */
  assign n2798 = n2794 == 3'b111;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1074:24 */
  assign n2799 = n2796 | n2798;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1076:13 */
  assign n2801 = n2794 == 3'b101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1078:13 */
  assign n2803 = n2794 == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1073:11 */
  assign n2804 = {n2803, n2801, n2799};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1073:11 */
  always @*
    case (n2804)
      3'b100: n2809 = 5'b01100;
      3'b010: n2809 = 5'b00101;
      3'b001: n2809 = 5'b00110;
      default: n2809 = 5'b00100;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1072:9 */
  assign n2811 = n2793 == 3'b000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1072:20 */
  assign n2813 = n2793 == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1072:20 */
  assign n2814 = n2811 | n2813;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1072:28 */
  assign n2816 = n2793 == 3'b011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1072:28 */
  assign n2817 = n2814 | n2816;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1086:18 */
  assign n2818 = ir[7:5]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1087:13 */
  assign n2820 = n2818 == 3'b111;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1087:24 */
  assign n2822 = n2818 == 3'b110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1087:24 */
  assign n2823 = n2820 | n2822;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1089:13 */
  assign n2825 = n2818 == 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1086:11 */
  assign n2826 = {n2825, n2823};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1086:11 */
  always @*
    case (n2826)
      2'b10: n2830 = 5'b01101;
      2'b01: n2830 = 5'b01110;
      default: n2830 = 5'b00101;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1085:9 */
  assign n2832 = n2793 == 3'b010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1097:18 */
  assign n2833 = ir[7:5]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1098:13 */
  assign n2835 = n2833 == 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1097:11 */
  always @*
    case (n2835)
      1'b1: n2838 = 5'b00101;
      default: n2838 = 5'b00100;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1096:9 */
  assign n2840 = n2793 == 3'b110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1108:18 */
  assign n2841 = ir[7:5]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1109:13 */
  assign n2843 = n2841 == 3'b101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1108:11 */
  always @*
    case (n2843)
      1'b1: n2846 = 5'b00101;
      default: n2846 = 5'b00100;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1068:9 */
  assign n2847 = {n2840, n2832, n2817};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1068:9 */
  always @*
    case (n2847)
      3'b100: n2848 = n2838;
      3'b010: n2848 = n2830;
      3'b001: n2848 = n2809;
      default: n2848 = n2846;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1067:7 */
  assign n2850 = n2792 == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1117:36 */
  assign n2851 = ir[7:5]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1117:14 */
  assign n2852 = {28'b0, n2851};  // uext
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1118:11 */
  assign n2854 = n2852 == 31'b0000000000000000000000000000000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1120:11 */
  assign n2856 = n2852 == 31'b0000000000000000000000000000001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1122:11 */
  assign n2858 = n2852 == 31'b0000000000000000000000000000010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1124:11 */
  assign n2860 = n2852 == 31'b0000000000000000000000000000011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1126:11 */
  assign n2862 = n2852 == 31'b0000000000000000000000000000100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1128:11 */
  assign n2864 = n2852 == 31'b0000000000000000000000000000101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1130:11 */
  assign n2866 = n2852 == 31'b0000000000000000000000000000110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1117:9 */
  assign n2867 = {n2866, n2864, n2862, n2860, n2858, n2856, n2854};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1117:9 */
  always @*
    case (n2867)
      7'b1000000: n2876 = 5'b00110;
      7'b0100000: n2876 = 5'b00101;
      7'b0010000: n2876 = 5'b00100;
      7'b0001000: n2876 = 5'b00011;
      7'b0000100: n2876 = 5'b00010;
      7'b0000010: n2876 = 5'b00001;
      7'b0000001: n2876 = 5'b00000;
      default: n2876 = 5'b00111;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1116:7 */
  assign n2878 = n2792 == 2'b01;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1137:36 */
  assign n2879 = ir[7:5]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1137:14 */
  assign n2880 = {28'b0, n2879};  // uext
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1140:18 */
  assign n2881 = ir[4:2]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1140:31 */
  assign n2883 = n2881 == 3'b110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1140:47 */
  assign n2885 = mode != 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1140:39 */
  assign n2886 = n2885 & n2883;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1140:13 */
  assign n2889 = n2886 ? 5'b01110 : 5'b01000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1138:11 */
  assign n2892 = n2880 == 31'b0000000000000000000000000000000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1145:18 */
  assign n2893 = ir[4:2]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1145:31 */
  assign n2895 = n2893 == 3'b110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1145:47 */
  assign n2897 = mode != 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1145:39 */
  assign n2898 = n2897 & n2895;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1145:13 */
  assign n2901 = n2898 ? 5'b01101 : 5'b01001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1143:11 */
  assign n2904 = n2880 == 31'b0000000000000000000000000000001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1148:11 */
  assign n2906 = n2880 == 31'b0000000000000000000000000000010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1150:11 */
  assign n2908 = n2880 == 31'b0000000000000000000000000000011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1154:18 */
  assign n2909 = ir[4:2]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1154:31 */
  assign n2911 = n2909 == 3'b010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1154:13 */
  assign n2914 = n2911 ? 5'b00101 : 5'b00100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1152:11 */
  assign n2917 = n2880 == 31'b0000000000000000000000000000100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1159:11 */
  assign n2919 = n2880 == 31'b0000000000000000000000000000101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1161:11 */
  assign n2921 = n2880 == 31'b0000000000000000000000000000110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1137:9 */
  assign n2922 = {n2921, n2919, n2917, n2908, n2906, n2904, n2892};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1137:9 */
  always @*
    case (n2922)
      7'b1000000: n2928 = 5'b01101;
      7'b0100000: n2928 = 5'b00101;
      7'b0010000: n2928 = n2914;
      7'b0001000: n2928 = 5'b01011;
      7'b0000100: n2928 = 5'b01010;
      7'b0000010: n2928 = n2901;
      7'b0000001: n2928 = n2889;
      default: n2928 = 5'b01110;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1136:7 */
  assign n2930 = n2792 == 2'b10;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1168:36 */
  assign n2931 = ir[7:5]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1168:14 */
  assign n2932 = {28'b0, n2931};  // uext
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1171:18 */
  assign n2934 = ir == 8'b10111011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1171:13 */
  assign n2937 = n2934 ? 5'b00001 : 5'b00101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1170:11 */
  assign n2939 = n2932 == 31'b0000000000000000000000000000101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1185:18 */
  assign n2941 = ir == 8'b01101011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1187:21 */
  assign n2943 = ir == 8'b10001011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1189:21 */
  assign n2945 = ir == 8'b00001011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1189:33 */
  assign n2947 = ir == 8'b00101011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1189:28 */
  assign n2948 = n2945 | n2947;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1191:21 */
  assign n2950 = ir == 8'b11101011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1194:42 */
  assign n2951 = ir[7:5]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1194:20 */
  assign n2952 = {28'b0, n2951};  // uext
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1195:17 */
  assign n2954 = n2952 == 31'b0000000000000000000000000000000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1197:17 */
  assign n2956 = n2952 == 31'b0000000000000000000000000000001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1199:17 */
  assign n2958 = n2952 == 31'b0000000000000000000000000000010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1201:17 */
  assign n2960 = n2952 == 31'b0000000000000000000000000000011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1203:17 */
  assign n2962 = n2952 == 31'b0000000000000000000000000000100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1205:17 */
  assign n2964 = n2952 == 31'b0000000000000000000000000000101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1207:17 */
  assign n2966 = n2952 == 31'b0000000000000000000000000000110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1194:15 */
  assign n2967 = {n2966, n2964, n2962, n2960, n2958, n2956, n2954};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1194:15 */
  always @*
    case (n2967)
      7'b1000000: n2976 = 5'b00110;
      7'b0100000: n2976 = 5'b00101;
      7'b0010000: n2976 = 5'b00100;
      7'b0001000: n2976 = 5'b00011;
      7'b0000100: n2976 = 5'b00010;
      7'b0000010: n2976 = 5'b00001;
      7'b0000001: n2976 = 5'b00000;
      default: n2976 = 5'b00111;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1213:42 */
  assign n2977 = ir[7:5]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1213:20 */
  assign n2978 = {28'b0, n2977};  // uext
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1214:17 */
  assign n2980 = n2978 == 31'b0000000000000000000000000000000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1216:17 */
  assign n2982 = n2978 == 31'b0000000000000000000000000000001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1218:17 */
  assign n2984 = n2978 == 31'b0000000000000000000000000000010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1220:17 */
  assign n2986 = n2978 == 31'b0000000000000000000000000000011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1222:17 */
  assign n2988 = n2978 == 31'b0000000000000000000000000000100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1224:17 */
  assign n2990 = n2978 == 31'b0000000000000000000000000000101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1228:24 */
  assign n2991 = ir[4:2]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1228:36 */
  assign n2993 = n2991 == 3'b010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1228:19 */
  assign n2996 = n2993 ? 5'b10001 : 5'b01101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1226:17 */
  assign n2999 = n2978 == 31'b0000000000000000000000000000110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1213:15 */
  assign n3000 = {n2999, n2990, n2988, n2986, n2984, n2982, n2980};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1213:15 */
  always @*
    case (n3000)
      7'b1000000: n3008 = n2996;
      7'b0100000: n3008 = 5'b00101;
      7'b0010000: n3008 = 5'b01100;
      7'b0001000: n3008 = 5'b01011;
      7'b0000100: n3008 = 5'b01010;
      7'b0000010: n3008 = 5'b01001;
      7'b0000001: n3008 = 5'b01000;
      default: n3008 = 5'b01110;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1193:13 */
  assign n3009 = alumore ? n2976 : n3008;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1191:13 */
  assign n3011 = n2950 ? 5'b00111 : n3009;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1189:13 */
  assign n3013 = n2948 ? 5'b10000 : n3011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1187:13 */
  assign n3015 = n2943 ? 5'b10010 : n3013;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1185:13 */
  assign n3017 = n2941 ? 5'b01111 : n3015;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1168:9 */
  always @*
    case (n2939)
      1'b1: n3018 = n2937;
      default: n3018 = n3017;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1066:5 */
  assign n3019 = {n2930, n2878, n2850};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65_MCode.vhd:1066:5 */
  always @*
    case (n3019)
      3'b100: n3020 = n2928;
      3'b010: n3020 = n2876;
      3'b001: n3020 = n2848;
      default: n3020 = n3018;
    endcase
endmodule

module T65
  (input  [1:0] Mode,
   input  BCD_en,
   input  Res_n,
   input  Clk,
   input  Enable,
   output [23:0] A,
   input  [7:0] DI,
   output [7:0] DO,
   input  Rdy,
   input  Abort_n,
   input  IRQ_n,
   input  NMI_n,
   input  SO_n,
   output R_W_n,
   output Sync,
   output EF,
   output MF,
   output XF,
   output ML_n,
   output VP_n,
   output VDA,
   output VPA,
   output [7:0] \DEBUG[I] ,
   output [7:0] \DEBUG[A] ,
   output [7:0] \DEBUG[X] ,
   output [7:0] \DEBUG[Y] ,
   output [7:0] \DEBUG[S] ,
   output [7:0] \DEBUG[P] ,
   output NMI_ack);
  wire [7:0] n12;
  wire [7:0] n13;
  wire [7:0] n14;
  wire [7:0] n15;
  wire [7:0] n16;
  wire [7:0] n17;
  wire [15:0] abc;
  wire [15:0] x;
  wire [15:0] y;
  reg [7:0] p;
  reg [7:0] ad;
  reg [7:0] dl;
  wire [7:0] pwithb;
  wire [7:0] bah;
  wire [8:0] bal;
  wire [7:0] pbr;
  wire [7:0] dbr;
  reg [15:0] pc;
  reg [15:0] s;
  wire ef_i;
  wire mf_i;
  wire xf_i;
  reg [7:0] ir;
  reg [2:0] mcycle;
  reg [1:0] mode_r;
  wire bcd_en_r;
  wire [4:0] alu_op_r;
  wire [3:0] write_data_r;
  reg [1:0] set_addr_to_r;
  reg [8:0] pcadder;
  wire rstcycle;
  wire irqcycle;
  wire nmicycle;
  wire so_n_o;
  wire irq_n_o;
  wire nmi_n_o;
  wire nmiact;
  wire break_s;
  wire [7:0] busa;
  wire [7:0] busa_r;
  wire [7:0] busb;
  wire [7:0] busb_r;
  wire [7:0] alu_q;
  wire [7:0] p_out;
  wire [2:0] lcycle;
  wire [4:0] alu_op;
  wire [3:0] set_busa_to;
  wire [1:0] set_addr_to;
  wire [3:0] write_data;
  wire [1:0] jump;
  wire [1:0] baadd;
  wire breakatna;
  wire adadd;
  wire addy;
  wire pcadd;
  wire inc_s;
  wire dec_s;
  wire lda;
  wire ldp;
  wire ldx;
  wire ldy;
  wire lds;
  wire lddi;
  wire ldalu;
  wire ldad;
  wire ldbal;
  wire ldbah;
  wire savep;
  wire write;
  wire res_n_i;
  wire res_n_d;
  wire really_rdy;
  wire wrn_i;
  wire nmi_entered;
  wire n29;
  wire n30;
  wire n33;
  wire n34;
  wire [1:0] n37;
  wire n39;
  wire [1:0] n40;
  wire n42;
  wire n43;
  wire [1:0] n44;
  wire n46;
  wire n47;
  wire n48;
  wire n52;
  wire n54;
  wire n55;
  wire n56;
  wire n57;
  wire n61;
  wire n62;
  wire n65;
  wire n66;
  wire n67;
  wire [7:0] n69;
  wire [7:0] n70;
  wire [7:0] n71;
  wire [7:0] n72;
  wire n102;
  wire n114;
  wire n116;
  wire n117;
  wire n119;
  wire n120;
  wire n121;
  wire n122;
  wire [15:0] n124;
  wire [15:0] n125;
  wire n126;
  wire [7:0] n128;
  wire [7:0] n129;
  wire [7:0] n130;
  wire n131;
  wire n133;
  wire [1:0] n138;
  wire [15:0] n140;
  wire [7:0] n141;
  wire [15:0] n142;
  wire [15:0] n143;
  wire n144;
  wire n146;
  wire n147;
  wire n148;
  wire [15:0] n150;
  wire [15:0] n151;
  wire n153;
  wire n155;
  wire n156;
  wire n157;
  wire n158;
  wire n159;
  wire n160;
  wire [15:0] n162;
  wire [15:0] n163;
  wire [15:0] n165;
  wire n167;
  wire [15:0] n168;
  wire n170;
  wire n171;
  wire n172;
  wire n173;
  wire [7:0] n174;
  wire [7:0] n176;
  wire [7:0] n177;
  wire [7:0] n179;
  wire [7:0] n180;
  wire [7:0] n181;
  wire [7:0] n182;
  wire [7:0] n183;
  wire n185;
  wire [2:0] n186;
  wire [7:0] n187;
  wire [7:0] n188;
  wire [7:0] n189;
  reg [7:0] n190;
  wire [7:0] n191;
  wire [7:0] n192;
  wire [7:0] n193;
  reg [7:0] n194;
  wire [15:0] n200;
  wire n209;
  wire n210;
  wire n211;
  wire n216;
  wire n217;
  wire n218;
  wire n219;
  wire n220;
  wire n221;
  wire n222;
  wire n223;
  wire n224;
  wire n225;
  wire n226;
  wire n227;
  wire n228;
  wire n229;
  wire [7:0] n273;
  wire [8:0] n274;
  wire n275;
  wire [8:0] n276;
  wire [8:0] n277;
  wire [8:0] n278;
  wire [7:0] n279;
  wire [8:0] n281;
  wire n285;
  wire n288;
  wire n295;
  wire n296;
  wire [7:0] n297;
  wire n299;
  wire n301;
  wire n303;
  wire n304;
  wire [7:0] n305;
  wire [7:0] n306;
  wire [4:0] n307;
  wire n309;
  wire [2:0] n310;
  wire n313;
  wire n316;
  wire n319;
  wire n322;
  wire n325;
  wire n328;
  wire n331;
  wire [6:0] n332;
  wire n333;
  reg n334;
  wire n335;
  reg n336;
  wire n337;
  reg n338;
  wire n339;
  reg n340;
  wire [1:0] n341;
  wire n342;
  wire n343;
  wire [1:0] n344;
  wire [1:0] n345;
  wire n346;
  wire n347;
  wire n350;
  wire n351;
  wire n356;
  wire n358;
  wire n359;
  wire n360;
  wire n361;
  wire n363;
  wire n364;
  wire n365;
  wire [1:0] n368;
  wire [1:0] n369;
  wire [1:0] n370;
  wire [7:0] n372;
  wire [4:0] n373;
  wire n375;
  wire n377;
  wire n378;
  wire n381;
  wire n383;
  wire n385;
  wire [7:0] n386;
  wire n387;
  wire [4:0] n390;
  wire n392;
  wire n394;
  wire n395;
  wire n398;
  wire n400;
  wire n402;
  wire n403;
  wire n404;
  wire n405;
  wire n407;
  wire n408;
  wire n410;
  wire n411;
  wire n412;
  wire [5:0] n413;
  wire [7:0] n420;
  wire n441;
  wire n444;
  wire n446;
  wire n447;
  wire [7:0] n449;
  wire [7:0] n452;
  wire [8:0] n454;
  wire n456;
  wire [7:0] n457;
  wire [8:0] n458;
  wire [8:0] n459;
  wire [8:0] n460;
  wire n462;
  wire n463;
  wire [7:0] n465;
  wire [7:0] n466;
  wire n468;
  wire [2:0] n469;
  reg [7:0] n470;
  reg [7:0] n471;
  reg [8:0] n472;
  wire [7:0] n473;
  wire [7:0] n474;
  wire [7:0] n475;
  wire [7:0] n476;
  wire [7:0] n477;
  wire [7:0] n478;
  wire n480;
  wire n483;
  wire n484;
  wire n485;
  wire n486;
  wire n489;
  wire n492;
  wire [2:0] n494;
  wire n496;
  wire [2:0] n497;
  localparam [8:0] n498 = 9'b111111111;
  wire [5:0] n499;
  wire n501;
  wire n503;
  wire n505;
  wire n506;
  wire [1:0] n507;
  wire [7:0] n509;
  wire [8:0] n510;
  wire [8:0] n511;
  wire n513;
  wire [7:0] n514;
  wire [7:0] n515;
  wire [7:0] n516;
  wire [7:0] n517;
  wire [7:0] n518;
  wire n519;
  wire [7:0] n520;
  wire [8:0] n524;
  wire n528;
  wire n530;
  wire n532;
  wire n533;
  wire n534;
  wire n535;
  wire n536;
  wire n537;
  wire n538;
  wire n564;
  wire n565;
  wire n566;
  wire n567;
  wire n568;
  wire n569;
  wire n570;
  wire n572;
  wire [7:0] n573;
  wire n575;
  wire [7:0] n576;
  wire n578;
  wire [7:0] n579;
  wire n581;
  wire [7:0] n582;
  wire n584;
  wire n586;
  wire [7:0] n587;
  wire [7:0] n588;
  wire n590;
  wire [7:0] n591;
  wire [7:0] n593;
  wire [7:0] n594;
  wire n596;
  wire [7:0] n597;
  wire [7:0] n599;
  wire [7:0] n600;
  wire [7:0] n601;
  wire [7:0] n602;
  wire n604;
  wire [7:0] n605;
  wire [7:0] n606;
  wire [7:0] n607;
  wire n609;
  wire n612;
  wire [10:0] n613;
  reg [7:0] n615;
  wire [7:0] n616;
  wire [23:0] n618;
  wire n620;
  wire [15:0] n622;
  wire [23:0] n623;
  wire n625;
  wire [15:0] n627;
  wire [7:0] n628;
  wire [23:0] n629;
  wire n631;
  wire [7:0] n632;
  wire [15:0] n633;
  wire [7:0] n634;
  wire [23:0] n635;
  wire n637;
  wire [3:0] n638;
  reg [23:0] n640;
  wire [7:0] n642;
  wire n643;
  wire [7:0] n644;
  wire n646;
  wire [7:0] n647;
  wire n649;
  wire [7:0] n650;
  wire n652;
  wire [7:0] n653;
  wire n655;
  wire [7:0] n656;
  wire n658;
  wire n660;
  wire [7:0] n661;
  wire n663;
  wire [7:0] n664;
  wire n666;
  wire [7:0] n667;
  wire [7:0] n668;
  wire [7:0] n669;
  wire n671;
  wire [7:0] n672;
  wire [7:0] n673;
  wire [7:0] n674;
  wire [7:0] n675;
  wire n677;
  wire [7:0] n678;
  wire [7:0] n679;
  wire n681;
  wire [7:0] n682;
  wire [7:0] n683;
  wire n685;
  wire n688;
  wire [12:0] n689;
  reg [7:0] n691;
  wire n694;
  wire n696;
  wire n697;
  wire n699;
  wire n700;
  wire n701;
  wire n702;
  wire n703;
  wire n704;
  wire n707;
  wire n709;
  wire n713;
  wire n716;
  wire [2:0] n718;
  wire [2:0] n720;
  wire n725;
  wire n727;
  wire n728;
  wire n729;
  wire n730;
  wire n731;
  wire [4:0] n732;
  wire n734;
  wire n736;
  wire n737;
  wire n738;
  wire n739;
  wire n741;
  wire n743;
  wire n744;
  wire n745;
  wire n746;
  wire n747;
  wire [15:0] n766;
  wire [15:0] n768;
  wire [15:0] n770;
  wire [47:0] n771;
  wire n772;
  wire n773;
  wire [7:0] n774;
  wire [7:0] n775;
  reg [7:0] n776;
  wire n777;
  wire n778;
  wire [7:0] n779;
  wire [7:0] n780;
  reg [7:0] n781;
  wire n782;
  wire n783;
  wire [7:0] n784;
  wire [7:0] n785;
  reg [7:0] n786;
  reg [7:0] n787;
  wire [7:0] n788;
  reg [7:0] n789;
  wire [7:0] n790;
  reg [7:0] n791;
  wire [7:0] n792;
  reg [7:0] n793;
  wire [8:0] n794;
  reg [8:0] n795;
  wire [7:0] n796;
  reg [7:0] n797;
  wire [7:0] n798;
  reg [7:0] n799;
  wire [15:0] n800;
  reg [15:0] n801;
  wire [15:0] n802;
  reg [15:0] n803;
  wire n804;
  reg n805;
  wire n806;
  reg n807;
  wire n808;
  reg n809;
  wire [7:0] n810;
  reg [7:0] n811;
  wire [2:0] n812;
  reg [2:0] n813;
  wire [1:0] n814;
  reg [1:0] n815;
  wire n816;
  reg n817;
  wire [4:0] n818;
  reg [4:0] n819;
  wire [3:0] n820;
  reg [3:0] n821;
  wire [1:0] n822;
  reg [1:0] n823;
  wire n824;
  reg n825;
  wire n826;
  reg n827;
  wire n828;
  reg n829;
  wire n830;
  wire n831;
  reg n832;
  wire n833;
  wire n834;
  wire n835;
  reg n836;
  wire n837;
  wire n838;
  wire n839;
  reg n840;
  wire n841;
  reg n842;
  wire [7:0] n843;
  reg [7:0] n844;
  wire [7:0] n845;
  reg [7:0] n846;
  wire [7:0] n847;
  reg [7:0] n848;
  reg n849;
  reg n850;
  wire n851;
  reg n852;
  wire n853;
  wire n854;
  wire n855;
  reg n856;
  assign A = n640; //(module output)
  assign DO = n691; //(module output)
  assign R_W_n = wrn_i; //(module output)
  assign Sync = n34; //(module output)
  assign EF = ef_i; //(module output)
  assign MF = mf_i; //(module output)
  assign XF = xf_i; //(module output)
  assign ML_n = n48; //(module output)
  assign VP_n = n57; //(module output)
  assign VDA = n62; //(module output)
  assign VPA = n67; //(module output)
  assign \DEBUG[I]  = n12; //(module output)
  assign \DEBUG[A]  = n13; //(module output)
  assign \DEBUG[X]  = n14; //(module output)
  assign \DEBUG[Y]  = n15; //(module output)
  assign \DEBUG[S]  = n16; //(module output)
  assign \DEBUG[P]  = n17; //(module output)
  assign NMI_ack = nmiact; //(module output)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:130:8 */
  assign n12 = n771[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:130:8 */
  assign n13 = n771[15:8]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:130:8 */
  assign n14 = n771[23:16]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:130:8 */
  assign n15 = n771[31:24]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:130:8 */
  assign n16 = n771[39:32]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:130:8 */
  assign n17 = n771[47:40]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:166:10 */
  assign abc = n766; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:166:15 */
  assign x = n768; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:166:18 */
  assign y = n770; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:167:10 */
  always @*
    p = n787; // (isignal)
  initial
    p = 8'b00000000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:167:13 */
  always @*
    ad = n789; // (isignal)
  initial
    ad = 8'b00000000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:167:17 */
  always @*
    dl = n791; // (isignal)
  initial
    dl = 8'b00000000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:168:10 */
  assign pwithb = n644; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:169:10 */
  assign bah = n793; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:170:10 */
  assign bal = n795; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:171:10 */
  assign pbr = n797; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:172:10 */
  assign dbr = n799; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:173:10 */
  always @*
    pc = n801; // (isignal)
  initial
    pc = 16'b0000000000000000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:174:10 */
  always @*
    s = n803; // (isignal)
  initial
    s = 16'b0000000000000000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:175:10 */
  assign ef_i = n805; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:176:10 */
  assign mf_i = n807; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:177:10 */
  assign xf_i = n809; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:179:10 */
  always @*
    ir = n811; // (isignal)
  initial
    ir = 8'b00000000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:180:10 */
  always @*
    mcycle = n813; // (isignal)
  initial
    mcycle = 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:182:10 */
  always @*
    mode_r = n815; // (isignal)
  initial
    mode_r = 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:183:10 */
  assign bcd_en_r = n817; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:184:10 */
  assign alu_op_r = n819; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:185:10 */
  assign write_data_r = n821; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:186:10 */
  always @*
    set_addr_to_r = n823; // (isignal)
  initial
    set_addr_to_r = 2'b10;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:187:10 */
  always @*
    pcadder = n278; // (isignal)
  initial
    pcadder = 9'b000000000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:189:10 */
  assign rstcycle = n825; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:190:10 */
  assign irqcycle = n827; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:191:10 */
  assign nmicycle = n829; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:193:10 */
  assign so_n_o = n832; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:194:10 */
  assign irq_n_o = n836; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:195:10 */
  assign nmi_n_o = n840; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:196:10 */
  assign nmiact = n842; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:198:10 */
  assign break_s = n570; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:201:10 */
  assign busa = n615; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:202:10 */
  assign busa_r = n844; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:203:10 */
  assign busb = n846; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:204:10 */
  assign busb_r = n848; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:235:10 */
  assign res_n_i = n849; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:236:10 */
  assign res_n_d = n850; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:238:10 */
  assign really_rdy = n30; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:239:10 */
  assign wrn_i = n852; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:241:10 */
  assign nmi_entered = n856; // (signal)
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:247:24 */
  assign n29 = ~wrn_i;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:247:21 */
  assign n30 = Rdy | n29;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:248:27 */
  assign n33 = mcycle == 3'b000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:248:15 */
  assign n34 = n33 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:253:22 */
  assign n37 = ir[7:6]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:253:35 */
  assign n39 = n37 != 2'b10;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:253:49 */
  assign n40 = ir[2:1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:253:62 */
  assign n42 = n40 == 2'b11;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:253:43 */
  assign n43 = n42 & n39;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:253:79 */
  assign n44 = mcycle[2:1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:253:92 */
  assign n46 = n44 != 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:253:69 */
  assign n47 = n46 & n43;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:253:15 */
  assign n48 = n47 ? 1'b0 : 1'b1;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:254:47 */
  assign n52 = mcycle == 3'b101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:254:65 */
  assign n54 = mcycle == 3'b110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:254:55 */
  assign n55 = n52 | n54;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:254:35 */
  assign n56 = n55 & irqcycle;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:254:15 */
  assign n57 = n56 ? 1'b0 : 1'b1;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:255:33 */
  assign n61 = set_addr_to_r != 2'b10;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:255:14 */
  assign n62 = n61 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:256:23 */
  assign n65 = jump[1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:256:27 */
  assign n66 = ~n65;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:256:14 */
  assign n67 = n66 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:260:17 */
  assign n69 = abc[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:261:15 */
  assign n70 = x[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:262:15 */
  assign n71 = y[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:263:32 */
  assign n72 = s[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:266:3 */
  t65_mcode_Brtl mcode (
    .mode(mode_r),
    .ir(ir),
    .mcycle(mcycle),
    .p(p),
    .lcycle(lcycle),
    .alu_op(alu_op),
    .set_busa_to(set_busa_to),
    .set_addr_to(set_addr_to),
    .write_data(write_data),
    .jump(jump),
    .baadd(baadd),
    .breakatna(breakatna),
    .adadd(adadd),
    .addy(addy),
    .pcadd(pcadd),
    .inc_s(inc_s),
    .dec_s(dec_s),
    .lda(lda),
    .ldp(ldp),
    .ldx(ldx),
    .ldy(ldy),
    .lds(lds),
    .lddi(lddi),
    .ldalu(ldalu),
    .ldad(ldad),
    .ldbal(ldbal),
    .ldbah(ldbah),
    .savep(savep),
    .write(write));
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:301:3 */
  t65_alu_Brtl alu (
    .mode(mode_r),
    .bcd_en(bcd_en_r),
    .op(alu_op_r),
    .busa(busa_r),
    .busb(busb),
    .p_in(p),
    .p_out(p_out),
    .q(alu_q));
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:317:14 */
  assign n102 = ~Res_n;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:328:16 */
  assign n114 = ~res_n_i;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:349:20 */
  assign n116 = ~write;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:349:30 */
  assign n117 = n116 | rstcycle;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:357:22 */
  assign n119 = mcycle == 3'b000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:361:25 */
  assign n120 = ~irqcycle;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:361:44 */
  assign n121 = ~nmicycle;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:361:31 */
  assign n122 = n121 & n120;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:362:24 */
  assign n124 = pc + 16'b0000000000000001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:357:11 */
  assign n125 = n131 ? n124 : pc;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:365:31 */
  assign n126 = irqcycle | nmicycle;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:365:13 */
  assign n128 = n126 ? 8'b00000000 : DI;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:174:10 */
  assign n129 = s[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:357:11 */
  assign n130 = n133 ? alu_q : n129;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:357:11 */
  assign n131 = n122 & n119;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:357:11 */
  assign n133 = lds & n119;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:378:11 */
  assign n138 = break_s ? 2'b10 : set_addr_to;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:385:20 */
  assign n140 = s + 16'b0000000000000001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:174:10 */
  assign n141 = s[15:8]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:174:10 */
  assign n142 = {n141, n130};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:384:11 */
  assign n143 = inc_s ? n140 : n142;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:387:40 */
  assign n144 = ~rstcycle;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:387:53 */
  assign n146 = Mode == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:387:46 */
  assign n147 = n144 | n146;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:387:26 */
  assign n148 = n147 & dec_s;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:388:20 */
  assign n150 = s - 16'b0000000000000001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:387:11 */
  assign n151 = n148 ? n150 : n143;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:391:17 */
  assign n153 = ir == 8'b00000000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:391:41 */
  assign n155 = mcycle == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:391:30 */
  assign n156 = n155 & n153;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:391:62 */
  assign n157 = ~irqcycle;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:391:49 */
  assign n158 = n157 & n156;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:391:81 */
  assign n159 = ~nmicycle;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:391:68 */
  assign n160 = n159 & n158;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:392:22 */
  assign n162 = pc + 16'b0000000000000001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:391:11 */
  assign n163 = n160 ? n162 : n125;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:399:24 */
  assign n165 = pc + 16'b0000000000000001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:398:13 */
  assign n167 = jump == 2'b01;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:401:33 */
  assign n168 = {DI, dl};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:400:13 */
  assign n170 = jump == 2'b10;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:403:25 */
  assign n171 = pcadder[8]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:404:22 */
  assign n172 = dl[7]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:404:26 */
  assign n173 = ~n172;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:405:40 */
  assign n174 = pc[15:8]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:405:54 */
  assign n176 = n174 + 8'b00000001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:407:40 */
  assign n177 = pc[15:8]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:407:54 */
  assign n179 = n177 - 8'b00000001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:404:17 */
  assign n180 = n173 ? n176 : n179;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:173:10 */
  assign n181 = n163[15:8]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:403:15 */
  assign n182 = n171 ? n180 : n181;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:410:40 */
  assign n183 = pcadder[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:402:13 */
  assign n185 = jump == 2'b11;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:397:11 */
  assign n186 = {n185, n170, n167};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:399:24 */
  assign n187 = n165[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:401:33 */
  assign n188 = n168[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:173:10 */
  assign n189 = n163[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:397:11 */
  always @*
    case (n186)
      3'b100: n190 = n183;
      3'b010: n190 = n188;
      3'b001: n190 = n187;
      default: n190 = n189;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:399:24 */
  assign n191 = n165[15:8]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:401:33 */
  assign n192 = n168[15:8]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:173:10 */
  assign n193 = n163[15:8]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:397:11 */
  always @*
    case (n186)
      3'b100: n194 = n182;
      3'b010: n194 = n192;
      3'b001: n194 = n191;
      default: n194 = n193;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:348:9 */
  assign n200 = {n194, n190};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:348:9 */
  assign n209 = n119 & really_rdy;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:348:9 */
  assign n210 = n119 & really_rdy;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:348:9 */
  assign n211 = n119 & really_rdy;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:347:7 */
  assign n216 = really_rdy & Enable;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:347:7 */
  assign n217 = really_rdy & Enable;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:347:7 */
  assign n218 = really_rdy & Enable;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:347:7 */
  assign n219 = really_rdy & Enable;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:347:7 */
  assign n220 = really_rdy & Enable;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:347:7 */
  assign n221 = really_rdy & Enable;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:347:7 */
  assign n222 = really_rdy & Enable;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:347:7 */
  assign n223 = n209 & Enable;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:347:7 */
  assign n224 = n210 & Enable;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:347:7 */
  assign n225 = n211 & Enable;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:347:7 */
  assign n226 = really_rdy & Enable;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:347:7 */
  assign n227 = really_rdy & Enable;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:347:7 */
  assign n228 = really_rdy & Enable;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:347:7 */
  assign n229 = really_rdy & Enable;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:418:23 */
  assign n273 = pc[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:418:14 */
  assign n274 = {1'b0, n273};  // uext
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:418:59 */
  assign n275 = dl[7]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:418:63 */
  assign n276 = {n275, dl};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:418:39 */
  assign n277 = n274 + n276;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:418:72 */
  assign n278 = pcadd ? n277 : n281;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:419:23 */
  assign n279 = pc[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:419:19 */
  assign n281 = {1'b0, n279};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:424:16 */
  assign n285 = ~res_n_i;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:430:21 */
  assign n288 = mcycle == 3'b000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:440:21 */
  assign n295 = lda | ldx;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:440:28 */
  assign n296 = n295 | ldy;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:430:11 */
  assign n297 = n304 ? p_out : p;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:430:11 */
  assign n299 = lda & n288;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:430:11 */
  assign n301 = ldx & n288;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:430:11 */
  assign n303 = ldy & n288;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:430:11 */
  assign n304 = n296 & n288;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:444:11 */
  assign n305 = savep ? p_out : n297;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:447:11 */
  assign n306 = ldp ? alu_q : n305;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:450:16 */
  assign n307 = ir[4:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:450:29 */
  assign n309 = n307 == 5'b11000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:451:20 */
  assign n310 = ir[7:5]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:452:13 */
  assign n313 = n310 == 3'b000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:454:13 */
  assign n316 = n310 == 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:456:13 */
  assign n319 = n310 == 3'b010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:458:13 */
  assign n322 = n310 == 3'b011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:460:13 */
  assign n325 = n310 == 3'b101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:462:13 */
  assign n328 = n310 == 3'b110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:464:13 */
  assign n331 = n310 == 3'b111;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:451:13 */
  assign n332 = {n331, n328, n325, n322, n319, n316, n313};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:422:14 */
  assign n333 = n306[0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:451:13 */
  always @*
    case (n332)
      7'b1000000: n334 = n333;
      7'b0100000: n334 = n333;
      7'b0010000: n334 = n333;
      7'b0001000: n334 = n333;
      7'b0000100: n334 = n333;
      7'b0000010: n334 = 1'b1;
      7'b0000001: n334 = 1'b0;
      default: n334 = n333;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:422:14 */
  assign n335 = n306[2]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:451:13 */
  always @*
    case (n332)
      7'b1000000: n336 = n335;
      7'b0100000: n336 = n335;
      7'b0010000: n336 = n335;
      7'b0001000: n336 = 1'b1;
      7'b0000100: n336 = 1'b0;
      7'b0000010: n336 = n335;
      7'b0000001: n336 = n335;
      default: n336 = n335;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:422:14 */
  assign n337 = n306[3]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:451:13 */
  always @*
    case (n332)
      7'b1000000: n338 = 1'b1;
      7'b0100000: n338 = 1'b0;
      7'b0010000: n338 = n337;
      7'b0001000: n338 = n337;
      7'b0000100: n338 = n337;
      7'b0000010: n338 = n337;
      7'b0000001: n338 = n337;
      default: n338 = n337;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:422:14 */
  assign n339 = n306[6]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:451:13 */
  always @*
    case (n332)
      7'b1000000: n340 = n339;
      7'b0100000: n340 = n339;
      7'b0010000: n340 = 1'b0;
      7'b0001000: n340 = n339;
      7'b0000100: n340 = n339;
      7'b0000010: n340 = n339;
      7'b0000001: n340 = n339;
      default: n340 = n339;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:450:11 */
  assign n341 = {n338, n336};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:422:14 */
  assign n342 = n306[0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:450:11 */
  assign n343 = n309 ? n334 : n342;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:422:14 */
  assign n344 = n306[3:2]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:450:11 */
  assign n345 = n309 ? n341 : n344;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:422:14 */
  assign n346 = n306[6]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:450:11 */
  assign n347 = n309 ? n340 : n346;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:422:14 */
  assign n350 = n306[1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:422:14 */
  assign n351 = n306[7]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:470:17 */
  assign n356 = ir == 8'b00000000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:470:41 */
  assign n358 = mcycle == 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:470:30 */
  assign n359 = n358 & n356;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:470:62 */
  assign n360 = ~rstcycle;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:470:49 */
  assign n361 = n360 & n359;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:422:14 */
  assign n363 = n345[0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:470:11 */
  assign n364 = n361 ? 1'b1 : n363;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:422:14 */
  assign n365 = n345[1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:474:11 */
  assign n368 = {1'b0, 1'b1};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:422:14 */
  assign n369 = {n365, n364};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:474:11 */
  assign n370 = rstcycle ? n368 : n369;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:422:14 */
  assign n372 = {n351, n347, 1'b1, 1'b1, n370, n350, n343};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:482:16 */
  assign n373 = ir[4:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:482:28 */
  assign n375 = n373 != 5'b10000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:482:45 */
  assign n377 = jump != 2'b01;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:482:38 */
  assign n378 = n375 | n377;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:429:9 */
  assign n381 = n299 & really_rdy;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:429:9 */
  assign n383 = n301 & really_rdy;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:429:9 */
  assign n385 = n303 & really_rdy;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:428:7 */
  assign n386 = n403 ? n372 : p;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:429:9 */
  assign n387 = n378 & really_rdy;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:487:14 */
  assign n390 = ir[4:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:487:26 */
  assign n392 = n390 != 5'b10000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:487:43 */
  assign n394 = jump != 2'b01;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:487:36 */
  assign n395 = n392 | n394;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:428:7 */
  assign n398 = n381 & Enable;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:428:7 */
  assign n400 = n383 & Enable;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:428:7 */
  assign n402 = n385 & Enable;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:428:7 */
  assign n403 = really_rdy & Enable;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:428:7 */
  assign n404 = n387 & Enable;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:428:7 */
  assign n405 = n395 & Enable;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:494:42 */
  assign n407 = ~SO_n;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:494:33 */
  assign n408 = n407 & so_n_o;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:167:10 */
  assign n410 = n386[6]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:494:17 */
  assign n411 = n408 ? 1'b1 : n410;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:167:10 */
  assign n412 = n386[7]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:167:10 */
  assign n413 = n386[5:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:426:5 */
  assign n420 = {n412, n411, n413};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:509:16 */
  assign n441 = ~res_n_i;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:525:28 */
  assign n444 = set_addr_to_r == 2'b10;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:525:63 */
  assign n446 = set_addr_to_r == 2'b01;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:525:46 */
  assign n447 = n444 | n446;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:526:65 */
  assign n449 = DI + 8'b00000001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:532:49 */
  assign n452 = ad + 8'b00000001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:533:51 */
  assign n454 = bal + 9'b000000001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:530:11 */
  assign n456 = baadd == 2'b01;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:536:56 */
  assign n457 = bal[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:536:37 */
  assign n458 = {1'b0, n457};  // uext
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:536:75 */
  assign n459 = {1'b0, busa};  // uext
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:536:73 */
  assign n460 = n458 + n459;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:534:11 */
  assign n462 = baadd == 2'b10;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:539:19 */
  assign n463 = bal[8]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:540:53 */
  assign n465 = bah + 8'b00000001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:539:13 */
  assign n466 = n463 ? n465 : bah;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:537:11 */
  assign n468 = baadd == 2'b11;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:529:11 */
  assign n469 = {n468, n462, n456};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:529:11 */
  always @*
    case (n469)
      3'b100: n470 = ad;
      3'b010: n470 = ad;
      3'b001: n470 = n452;
      default: n470 = ad;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:529:11 */
  always @*
    case (n469)
      3'b100: n471 = n466;
      3'b010: n471 = bah;
      3'b001: n471 = bah;
      default: n471 = bah;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:529:11 */
  always @*
    case (n469)
      3'b100: n472 = bal;
      3'b010: n472 = n460;
      3'b001: n472 = n454;
      default: n472 = bal;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:548:63 */
  assign n473 = y[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:548:51 */
  assign n474 = ad + n473;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:550:63 */
  assign n475 = x[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:550:51 */
  assign n476 = ad + n475;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:547:13 */
  assign n477 = addy ? n474 : n476;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:546:11 */
  assign n478 = adadd ? n477 : n470;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:554:17 */
  assign n480 = ir == 8'b00000000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:559:61 */
  assign n483 = mcycle == 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:559:51 */
  assign n484 = n483 & nmiact;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:559:34 */
  assign n485 = nmicycle | n484;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:559:69 */
  assign n486 = n485 | nmi_entered;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:561:24 */
  assign n489 = mcycle == 3'b100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:561:15 */
  assign n492 = n489 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:559:13 */
  assign n494 = n486 ? 3'b010 : 3'b110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:559:13 */
  assign n496 = n486 ? n492 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:557:13 */
  assign n497 = rstcycle ? 3'b100 : n494;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:170:10 */
  assign n499 = n498[8:3]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:557:13 */
  assign n501 = rstcycle ? 1'b0 : n496;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:567:30 */
  assign n503 = set_addr_to_r == 2'b11;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:170:10 */
  assign n505 = n497[0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:567:13 */
  assign n506 = n503 ? 1'b1 : n505;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:170:10 */
  assign n507 = n497[2:1]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:554:11 */
  assign n509 = n480 ? 8'b11111111 : n471;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:554:11 */
  assign n510 = {n499, n507, n506};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:554:11 */
  assign n511 = n480 ? n510 : n472;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:554:11 */
  assign n513 = n480 ? n501 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:572:11 */
  assign n514 = lddi ? DI : dl;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:575:11 */
  assign n515 = ldalu ? alu_q : n514;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:578:11 */
  assign n516 = ldad ? DI : n478;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:170:10 */
  assign n517 = n511[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:581:11 */
  assign n518 = ldbal ? DI : n517;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:170:10 */
  assign n519 = n511[8]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:584:11 */
  assign n520 = ldbah ? DI : n509;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:520:9 */
  assign n524 = {n519, n518};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:520:9 */
  assign n528 = n447 & really_rdy;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:520:9 */
  assign n530 = really_rdy ? n513 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:518:7 */
  assign n532 = really_rdy & Enable;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:518:7 */
  assign n533 = really_rdy & Enable;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:518:7 */
  assign n534 = really_rdy & Enable;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:518:7 */
  assign n535 = really_rdy & Enable;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:518:7 */
  assign n536 = really_rdy & Enable;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:518:7 */
  assign n537 = really_rdy & Enable;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:518:7 */
  assign n538 = n528 & Enable;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:592:34 */
  assign n564 = bal[8]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:592:27 */
  assign n565 = ~n564;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:592:23 */
  assign n566 = breakatna & n565;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:592:64 */
  assign n567 = pcadder[8]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:592:53 */
  assign n568 = ~n567;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:592:49 */
  assign n569 = pcadd & n568;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:592:39 */
  assign n570 = n566 | n569;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:596:45 */
  assign n572 = set_busa_to == 4'b0000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:597:10 */
  assign n573 = abc[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:597:45 */
  assign n575 = set_busa_to == 4'b0001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:598:8 */
  assign n576 = x[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:598:45 */
  assign n578 = set_busa_to == 4'b0010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:599:8 */
  assign n579 = y[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:599:45 */
  assign n581 = set_busa_to == 4'b0011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:600:25 */
  assign n582 = s[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:600:45 */
  assign n584 = set_busa_to == 4'b0100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:601:45 */
  assign n586 = set_busa_to == 4'b0101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:602:10 */
  assign n587 = abc[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:602:23 */
  assign n588 = n587 & DI;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:602:45 */
  assign n590 = set_busa_to == 4'b0110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:603:11 */
  assign n591 = abc[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:603:24 */
  assign n593 = n591 | 8'b11101110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:603:34 */
  assign n594 = n593 & DI;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:603:45 */
  assign n596 = set_busa_to == 4'b0111;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:604:11 */
  assign n597 = abc[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:604:24 */
  assign n599 = n597 | 8'b11101110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:604:34 */
  assign n600 = n599 & DI;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:604:46 */
  assign n601 = x[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:604:41 */
  assign n602 = n600 & n601;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:604:62 */
  assign n604 = set_busa_to == 4'b1000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:605:10 */
  assign n605 = abc[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:605:28 */
  assign n606 = x[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:605:23 */
  assign n607 = n605 & n606;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:605:45 */
  assign n609 = set_busa_to == 4'b1001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:606:45 */
  assign n612 = set_busa_to == 4'b1010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:594:3 */
  assign n613 = {n612, n609, n604, n596, n590, n586, n584, n581, n578, n575, n572};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:594:3 */
  always @*
    case (n613)
      11'b10000000000: n615 = 8'bX;
      11'b01000000000: n615 = n607;
      11'b00100000000: n615 = n602;
      11'b00010000000: n615 = n594;
      11'b00001000000: n615 = n588;
      11'b00000100000: n615 = p;
      11'b00000010000: n615 = n582;
      11'b00000001000: n615 = n579;
      11'b00000000100: n615 = n576;
      11'b00000000010: n615 = n573;
      11'b00000000001: n615 = DI;
      default: n615 = 8'bX;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:610:46 */
  assign n616 = s[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:610:26 */
  assign n618 = {16'b0000000000000001, n616};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:610:87 */
  assign n620 = set_addr_to_r == 2'b00;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:611:11 */
  assign n622 = {dbr, 8'b00000000};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:611:24 */
  assign n623 = {n622, ad};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:611:87 */
  assign n625 = set_addr_to_r == 2'b01;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:612:18 */
  assign n627 = {8'b00000000, bah};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:612:29 */
  assign n628 = bal[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:612:24 */
  assign n629 = {n627, n628};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:612:87 */
  assign n631 = set_addr_to_r == 2'b11;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:613:32 */
  assign n632 = pc[15:8]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:613:11 */
  assign n633 = {pbr, n632};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:613:73 */
  assign n634 = pcadder[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:613:47 */
  assign n635 = {n633, n634};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:613:87 */
  assign n637 = set_addr_to_r == 2'b10;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:608:3 */
  assign n638 = {n637, n631, n625, n620};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:608:3 */
  always @*
    case (n638)
      4'b1000: n640 = n635;
      4'b0100: n640 = n629;
      4'b0010: n640 = n623;
      4'b0001: n640 = n618;
      default: n640 = 24'bX;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:616:14 */
  assign n642 = p & 8'b11101111;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:616:44 */
  assign n643 = irqcycle | nmicycle;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:616:25 */
  assign n644 = n643 ? n642 : p;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:620:43 */
  assign n646 = write_data_r == 4'b0000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:621:10 */
  assign n647 = abc[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:621:43 */
  assign n649 = write_data_r == 4'b0001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:622:8 */
  assign n650 = x[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:622:43 */
  assign n652 = write_data_r == 4'b0010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:623:8 */
  assign n653 = y[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:623:43 */
  assign n655 = write_data_r == 4'b0011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:624:25 */
  assign n656 = s[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:624:43 */
  assign n658 = write_data_r == 4'b0100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:625:43 */
  assign n660 = write_data_r == 4'b0101;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:626:26 */
  assign n661 = pc[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:626:43 */
  assign n663 = write_data_r == 4'b0110;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:627:26 */
  assign n664 = pc[15:8]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:627:43 */
  assign n666 = write_data_r == 4'b0111;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:628:10 */
  assign n667 = abc[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:628:28 */
  assign n668 = x[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:628:23 */
  assign n669 = n667 & n668;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:628:43 */
  assign n671 = write_data_r == 4'b1000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:629:10 */
  assign n672 = abc[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:629:28 */
  assign n673 = x[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:629:23 */
  assign n674 = n672 & n673;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:629:41 */
  assign n675 = n674 & busb_r;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:629:64 */
  assign n677 = write_data_r == 4'b1001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:630:8 */
  assign n678 = x[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:630:21 */
  assign n679 = n678 & busb_r;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:630:44 */
  assign n681 = write_data_r == 4'b1010;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:631:8 */
  assign n682 = y[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:631:21 */
  assign n683 = n682 & busb_r;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:631:44 */
  assign n685 = write_data_r == 4'b1011;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:632:43 */
  assign n688 = write_data_r == 4'b1100;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:618:3 */
  assign n689 = {n688, n685, n681, n677, n671, n666, n663, n660, n658, n655, n652, n649, n646};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:618:3 */
  always @*
    case (n689)
      13'b1000000000000: n691 = 8'bX;
      13'b0100000000000: n691 = n683;
      13'b0010000000000: n691 = n679;
      13'b0001000000000: n691 = n675;
      13'b0000100000000: n691 = n669;
      13'b0000010000000: n691 = n664;
      13'b0000001000000: n691 = n661;
      13'b0000000100000: n691 = pwithb;
      13'b0000000010000: n691 = n656;
      13'b0000000001000: n691 = n653;
      13'b0000000000100: n691 = n650;
      13'b0000000000010: n691 = n647;
      13'b0000000000001: n691 = dl;
      default: n691 = 8'bX;
    endcase
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:643:16 */
  assign n694 = ~res_n_i;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:652:21 */
  assign n696 = mcycle == lcycle;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:652:30 */
  assign n697 = n696 | break_s;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:657:35 */
  assign n699 = ir != 8'b00000000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:657:29 */
  assign n700 = n699 & nmiact;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:660:27 */
  assign n701 = ~irq_n_o;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:660:38 */
  assign n702 = p[2]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:660:47 */
  assign n703 = ~n702;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:660:33 */
  assign n704 = n703 & n701;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:660:13 */
  assign n707 = n704 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:657:13 */
  assign n709 = n700 ? 1'b0 : n707;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:657:13 */
  assign n713 = n700 ? 1'b1 : 1'b0;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:651:9 */
  assign n716 = n730 ? 1'b0 : nmiact;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:664:57 */
  assign n718 = mcycle + 3'b001;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:652:11 */
  assign n720 = n697 ? 3'b000 : n718;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:652:11 */
  assign n725 = n700 & n697;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:651:9 */
  assign n727 = n697 & really_rdy;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:651:9 */
  assign n728 = n697 & really_rdy;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:651:9 */
  assign n729 = n697 & really_rdy;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:651:9 */
  assign n730 = n725 & really_rdy;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:668:37 */
  assign n731 = ~NMI_n;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:668:50 */
  assign n732 = ir[4:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:668:62 */
  assign n734 = n732 != 5'b10000;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:668:79 */
  assign n736 = jump != 2'b01;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:668:72 */
  assign n737 = n734 | n736;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:668:43 */
  assign n738 = n737 & n731;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:668:26 */
  assign n739 = n738 & nmi_n_o;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:668:9 */
  assign n741 = n739 ? 1'b1 : n716;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:672:9 */
  assign n743 = nmi_entered ? 1'b0 : n741;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:650:7 */
  assign n744 = really_rdy & Enable;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:650:7 */
  assign n745 = n727 & Enable;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:650:7 */
  assign n746 = n728 & Enable;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:650:7 */
  assign n747 = n729 & Enable;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:166:10 */
  assign n766 = {8'bZ, n776};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:166:15 */
  assign n768 = {8'bZ, n781};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:166:18 */
  assign n770 = {8'bZ, n786};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:158:5 */
  assign n771 = {p, n72, n71, n70, n69, ir};
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:166:10 */
  assign n772 = ~n285;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:166:10 */
  assign n773 = n398 & n772;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:426:5 */
  assign n774 = abc[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:426:5 */
  assign n775 = n773 ? alu_q : n774;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:426:5 */
  always @(posedge Clk)
    n776 <= n775;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:166:15 */
  assign n777 = ~n285;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:166:15 */
  assign n778 = n400 & n777;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:426:5 */
  assign n779 = x[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:426:5 */
  assign n780 = n778 ? alu_q : n779;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:426:5 */
  always @(posedge Clk)
    n781 <= n780;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:166:18 */
  assign n782 = ~n285;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:166:18 */
  assign n783 = n402 & n782;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:426:5 */
  assign n784 = y[7:0]; // extract
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:426:5 */
  assign n785 = n783 ? alu_q : n784;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:426:5 */
  always @(posedge Clk)
    n786 <= n785;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:426:5 */
  always @(posedge Clk or posedge n285)
    if (n285)
      n787 <= 8'b00000000;
    else
      n787 <= n420;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:517:5 */
  assign n788 = n532 ? n516 : ad;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:517:5 */
  always @(posedge Clk or posedge n441)
    if (n441)
      n789 <= 8'b00000000;
    else
      n789 <= n788;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:517:5 */
  assign n790 = n533 ? n515 : dl;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:517:5 */
  always @(posedge Clk or posedge n441)
    if (n441)
      n791 <= 8'b00000000;
    else
      n791 <= n790;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:517:5 */
  assign n792 = n534 ? n520 : bah;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:517:5 */
  always @(posedge Clk or posedge n441)
    if (n441)
      n793 <= 8'b00000000;
    else
      n793 <= n792;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:517:5 */
  assign n794 = n535 ? n524 : bal;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:517:5 */
  always @(posedge Clk or posedge n441)
    if (n441)
      n795 <= 9'b000000000;
    else
      n795 <= n794;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:346:5 */
  assign n796 = n216 ? 8'b11111111 : pbr;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:346:5 */
  always @(posedge Clk or posedge n114)
    if (n114)
      n797 <= 8'b00000000;
    else
      n797 <= n796;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:346:5 */
  assign n798 = n217 ? 8'b11111111 : dbr;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:346:5 */
  always @(posedge Clk or posedge n114)
    if (n114)
      n799 <= 8'b00000000;
    else
      n799 <= n798;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:346:5 */
  assign n800 = n218 ? n200 : pc;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:346:5 */
  always @(posedge Clk or posedge n114)
    if (n114)
      n801 <= 16'b0000000000000000;
    else
      n801 <= n800;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:346:5 */
  assign n802 = n219 ? n151 : s;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:346:5 */
  always @(posedge Clk or posedge n114)
    if (n114)
      n803 <= 16'b0000000000000000;
    else
      n803 <= n802;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:346:5 */
  assign n804 = n220 ? 1'b0 : ef_i;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:346:5 */
  always @(posedge Clk or posedge n114)
    if (n114)
      n805 <= 1'b1;
    else
      n805 <= n804;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:346:5 */
  assign n806 = n221 ? 1'b0 : mf_i;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:346:5 */
  always @(posedge Clk or posedge n114)
    if (n114)
      n807 <= 1'b1;
    else
      n807 <= n806;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:346:5 */
  assign n808 = n222 ? 1'b0 : xf_i;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:346:5 */
  always @(posedge Clk or posedge n114)
    if (n114)
      n809 <= 1'b1;
    else
      n809 <= n808;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:346:5 */
  assign n810 = n223 ? n128 : ir;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:346:5 */
  always @(posedge Clk or posedge n114)
    if (n114)
      n811 <= 8'b00000000;
    else
      n811 <= n810;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:649:5 */
  assign n812 = n744 ? n720 : mcycle;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:649:5 */
  always @(posedge Clk or posedge n694)
    if (n694)
      n813 <= 3'b001;
    else
      n813 <= n812;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:346:5 */
  assign n814 = n224 ? Mode : mode_r;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:346:5 */
  always @(posedge Clk or posedge n114)
    if (n114)
      n815 <= 2'b00;
    else
      n815 <= n814;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:346:5 */
  assign n816 = n225 ? BCD_en : bcd_en_r;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:346:5 */
  always @(posedge Clk or posedge n114)
    if (n114)
      n817 <= 1'b1;
    else
      n817 <= n816;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:346:5 */
  assign n818 = n226 ? alu_op : alu_op_r;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:346:5 */
  always @(posedge Clk or posedge n114)
    if (n114)
      n819 <= 5'b01100;
    else
      n819 <= n818;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:346:5 */
  assign n820 = n227 ? write_data : write_data_r;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:346:5 */
  always @(posedge Clk or posedge n114)
    if (n114)
      n821 <= 4'b0000;
    else
      n821 <= n820;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:346:5 */
  assign n822 = n228 ? n138 : set_addr_to_r;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:346:5 */
  always @(posedge Clk or posedge n114)
    if (n114)
      n823 <= 2'b10;
    else
      n823 <= n822;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:649:5 */
  assign n824 = n745 ? 1'b0 : rstcycle;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:649:5 */
  always @(posedge Clk or posedge n694)
    if (n694)
      n825 <= 1'b1;
    else
      n825 <= n824;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:649:5 */
  assign n826 = n746 ? n709 : irqcycle;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:649:5 */
  always @(posedge Clk or posedge n694)
    if (n694)
      n827 <= 1'b0;
    else
      n827 <= n826;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:649:5 */
  assign n828 = n747 ? n713 : nmicycle;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:649:5 */
  always @(posedge Clk or posedge n694)
    if (n694)
      n829 <= 1'b0;
    else
      n829 <= n828;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:193:10 */
  assign n830 = ~n285;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:426:5 */
  assign n831 = n830 ? SO_n : so_n_o;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:426:5 */
  always @(posedge Clk)
    n832 <= n831;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:194:10 */
  assign n833 = ~n285;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:194:10 */
  assign n834 = n404 & n833;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:426:5 */
  assign n835 = n834 ? IRQ_n : irq_n_o;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:426:5 */
  always @(posedge Clk)
    n836 <= n835;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:195:10 */
  assign n837 = ~n285;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:195:10 */
  assign n838 = n405 & n837;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:426:5 */
  assign n839 = n838 ? NMI_n : nmi_n_o;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:426:5 */
  always @(posedge Clk)
    n840 <= n839;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:649:5 */
  assign n841 = Enable ? n743 : nmiact;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:649:5 */
  always @(posedge Clk or posedge n694)
    if (n694)
      n842 <= 1'b0;
    else
      n842 <= n841;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:517:5 */
  assign n843 = n536 ? busa : busa_r;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:517:5 */
  always @(posedge Clk or posedge n441)
    if (n441)
      n844 <= 8'b00000000;
    else
      n844 <= n843;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:517:5 */
  assign n845 = n537 ? DI : busb;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:517:5 */
  always @(posedge Clk or posedge n441)
    if (n441)
      n846 <= 8'b00000000;
    else
      n846 <= n845;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:517:5 */
  assign n847 = n538 ? n449 : busb_r;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:517:5 */
  always @(posedge Clk or posedge n441)
    if (n441)
      n848 <= 8'b00000000;
    else
      n848 <= n847;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:320:5 */
  always @(posedge Clk or posedge n102)
    if (n102)
      n849 <= 1'b0;
    else
      n849 <= res_n_d;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:320:5 */
  always @(posedge Clk or posedge n102)
    if (n102)
      n850 <= 1'b0;
    else
      n850 <= 1'b1;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:346:5 */
  assign n851 = n229 ? n117 : wrn_i;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:346:5 */
  always @(posedge Clk or posedge n114)
    if (n114)
      n852 <= 1'b1;
    else
      n852 <= n851;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:241:10 */
  assign n853 = ~n441;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:241:10 */
  assign n854 = Enable & n853;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:517:5 */
  assign n855 = n854 ? n530 : nmi_entered;
  /*# /mnt/c/repos/atarigx2-mister/mister/modules/cpu-t65/T65.vhd:517:5 */
  always @(posedge Clk)
    n856 <= n855;
endmodule

