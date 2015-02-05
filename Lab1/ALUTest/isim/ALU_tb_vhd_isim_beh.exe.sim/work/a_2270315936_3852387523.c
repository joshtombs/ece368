/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/Josh/Documents/College/Junior/Spring/ALUTest/alu_logic_unit.vhd";
extern char *IEEE_P_2592010699;
extern char *IEEE_P_3620187407;

char *ieee_p_2592010699_sub_1735675855_503743352(char *, char *, char *, char *, char *, char *);
char *ieee_p_2592010699_sub_795620321_503743352(char *, char *, char *, char *, char *, char *);
unsigned char ieee_p_3620187407_sub_1742983514_3965413181(char *, char *, char *, char *, char *);


static void work_a_2270315936_3852387523_p_0(char *t0)
{
    char t12[16];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    int t5;
    char *t6;
    char *t7;
    int t8;
    char *t9;
    char *t10;
    int t11;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    unsigned int t19;
    unsigned int t20;
    unsigned char t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;

LAB0:    t1 = (t0 + 2992U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(33, ng0);
    t2 = (t0 + 1352U);
    t3 = *((char **)t2);
    t2 = (t0 + 6739);
    t5 = xsi_mem_cmp(t2, t3, 3U);
    if (t5 == 1)
        goto LAB5;

LAB9:    t6 = (t0 + 6742);
    t8 = xsi_mem_cmp(t6, t3, 3U);
    if (t8 == 1)
        goto LAB6;

LAB10:    t9 = (t0 + 6745);
    t11 = xsi_mem_cmp(t9, t3, 3U);
    if (t11 == 1)
        goto LAB7;

LAB11:
LAB8:    xsi_set_current_line(35, ng0);
    t2 = (t0 + 1032U);
    t3 = *((char **)t2);
    t2 = (t0 + 6612U);
    t4 = (t0 + 1192U);
    t6 = *((char **)t4);
    t4 = (t0 + 6628U);
    t7 = ieee_p_2592010699_sub_795620321_503743352(IEEE_P_2592010699, t12, t3, t2, t6, t4);
    t9 = (t12 + 12U);
    t19 = *((unsigned int *)t9);
    t20 = (1U * t19);
    t21 = (8U != t20);
    if (t21 == 1)
        goto LAB17;

LAB18:    t10 = (t0 + 4184);
    t13 = (t10 + 56U);
    t14 = *((char **)t13);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t7, 8U);
    xsi_driver_first_trans_fast_port(t10);

LAB4:    xsi_set_current_line(33, ng0);

LAB21:    t2 = (t0 + 4056);
    *((int *)t2) = 1;
    *((char **)t1) = &&LAB22;

LAB1:    return;
LAB5:    xsi_set_current_line(35, ng0);
    t13 = (t0 + 1032U);
    t14 = *((char **)t13);
    t13 = (t0 + 6612U);
    t15 = (t0 + 1192U);
    t16 = *((char **)t15);
    t15 = (t0 + 6628U);
    t17 = ieee_p_2592010699_sub_795620321_503743352(IEEE_P_2592010699, t12, t14, t13, t16, t15);
    t18 = (t12 + 12U);
    t19 = *((unsigned int *)t18);
    t20 = (1U * t19);
    t21 = (8U != t20);
    if (t21 == 1)
        goto LAB13;

LAB14:    t22 = (t0 + 4184);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    t25 = (t24 + 56U);
    t26 = *((char **)t25);
    memcpy(t26, t17, 8U);
    xsi_driver_first_trans_fast_port(t22);
    goto LAB4;

LAB6:    xsi_set_current_line(35, ng0);
    t2 = (t0 + 1032U);
    t3 = *((char **)t2);
    t2 = (t0 + 6612U);
    t4 = (t0 + 1192U);
    t6 = *((char **)t4);
    t4 = (t0 + 6628U);
    t7 = ieee_p_2592010699_sub_1735675855_503743352(IEEE_P_2592010699, t12, t3, t2, t6, t4);
    t9 = (t12 + 12U);
    t19 = *((unsigned int *)t9);
    t20 = (1U * t19);
    t21 = (8U != t20);
    if (t21 == 1)
        goto LAB15;

LAB16:    t10 = (t0 + 4184);
    t13 = (t10 + 56U);
    t14 = *((char **)t13);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t7, 8U);
    xsi_driver_first_trans_fast_port(t10);
    goto LAB4;

LAB7:    xsi_set_current_line(35, ng0);
    t2 = (t0 + 6748);
    t4 = (t0 + 4184);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t9 = (t7 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast_port(t4);
    goto LAB4;

LAB12:;
LAB13:    xsi_size_not_matching(8U, t20, 0);
    goto LAB14;

LAB15:    xsi_size_not_matching(8U, t20, 0);
    goto LAB16;

LAB17:    xsi_size_not_matching(8U, t20, 0);
    goto LAB18;

LAB19:    t3 = (t0 + 4056);
    *((int *)t3) = 0;
    goto LAB2;

LAB20:    goto LAB19;

LAB22:    goto LAB20;

}

static void work_a_2270315936_3852387523_p_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    unsigned char t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;

LAB0:    xsi_set_current_line(41, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t1 = (t0 + 6612U);
    t3 = (t0 + 1192U);
    t4 = *((char **)t3);
    t3 = (t0 + 6628U);
    t5 = ieee_p_3620187407_sub_1742983514_3965413181(IEEE_P_3620187407, t2, t1, t4, t3);
    if (t5 != 0)
        goto LAB3;

LAB4:
LAB5:    t11 = (t0 + 4248);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    *((unsigned char *)t15) = (unsigned char)2;
    xsi_driver_first_trans_delta(t11, 0U, 1, 0LL);

LAB2:    t16 = (t0 + 4072);
    *((int *)t16) = 1;

LAB1:    return;
LAB3:    t6 = (t0 + 4248);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = (unsigned char)3;
    xsi_driver_first_trans_delta(t6, 0U, 1, 0LL);
    goto LAB2;

LAB6:    goto LAB2;

}

static void work_a_2270315936_3852387523_p_2(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    unsigned char t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;

LAB0:    xsi_set_current_line(42, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t1 = (t0 + 6612U);
    t3 = (t0 + 1192U);
    t4 = *((char **)t3);
    t3 = (t0 + 6628U);
    t5 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t2, t1, t4, t3);
    if (t5 != 0)
        goto LAB3;

LAB4:
LAB5:    t11 = (t0 + 4312);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    *((unsigned char *)t15) = (unsigned char)2;
    xsi_driver_first_trans_delta(t11, 1U, 1, 0LL);

LAB2:    t16 = (t0 + 4088);
    *((int *)t16) = 1;

LAB1:    return;
LAB3:    t6 = (t0 + 4312);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = (unsigned char)3;
    xsi_driver_first_trans_delta(t6, 1U, 1, 0LL);
    goto LAB2;

LAB6:    goto LAB2;

}

static void work_a_2270315936_3852387523_p_3(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    int t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;

LAB0:    t1 = (t0 + 3736U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(45, ng0);
    t2 = (t0 + 1352U);
    t3 = *((char **)t2);
    t2 = (t0 + 6756);
    t5 = xsi_mem_cmp(t2, t3, 3U);
    if (t5 == 1)
        goto LAB5;

LAB7:
LAB6:    xsi_set_current_line(47, ng0);
    t2 = (t0 + 6759);
    t4 = (t0 + 4376);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 4U);
    xsi_driver_first_trans_fast_port(t4);

LAB4:    xsi_set_current_line(45, ng0);

LAB11:    t2 = (t0 + 4104);
    *((int *)t2) = 1;
    *((char **)t1) = &&LAB12;

LAB1:    return;
LAB5:    xsi_set_current_line(47, ng0);
    t6 = (t0 + 1832U);
    t7 = *((char **)t6);
    t6 = (t0 + 4376);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    memcpy(t11, t7, 4U);
    xsi_driver_first_trans_fast_port(t6);
    goto LAB4;

LAB8:;
LAB9:    t3 = (t0 + 4104);
    *((int *)t3) = 0;
    goto LAB2;

LAB10:    goto LAB9;

LAB12:    goto LAB10;

}


extern void work_a_2270315936_3852387523_init()
{
	static char *pe[] = {(void *)work_a_2270315936_3852387523_p_0,(void *)work_a_2270315936_3852387523_p_1,(void *)work_a_2270315936_3852387523_p_2,(void *)work_a_2270315936_3852387523_p_3};
	xsi_register_didat("work_a_2270315936_3852387523", "isim/ALU_tb_vhd_isim_beh.exe.sim/work/a_2270315936_3852387523.didat");
	xsi_register_executes(pe);
}
