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

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    work_m_00000000000366519932_2481906732_init();
    work_m_00000000002915201283_3866583278_init();
    work_m_00000000001569977108_3279647261_init();
    work_m_00000000002564699464_2250382437_init();
    work_m_00000000002018769077_0855183448_init();
    work_m_00000000001418932683_0948142031_init();
    work_m_00000000001125515781_1934828007_init();
    work_m_00000000004134447467_2073120511_init();


    xsi_register_tops("work_m_00000000001125515781_1934828007");
    xsi_register_tops("work_m_00000000004134447467_2073120511");


    return xsi_run_simulation(argc, argv);

}
