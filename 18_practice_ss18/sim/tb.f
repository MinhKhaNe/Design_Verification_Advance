+incdir+${APB_VIP_VERIF_PATH}/sequences
+incdir+${APB_VIP_VERIF_PATH}/testcases
+incdir+${APB_VIP_VERIF_PATH}/tb
+incdir+${APB_VIP_VERIF_PATH}/regmodel
+incdir+${APB_VIP_VERIF_PATH}/regmodel/register

+define+APB_ADDR_WIDTH=8
+define+APB_DATA_WIDTH=8
// Compilation VIP design (agent) list
-f ${APB_VIP_ROOT}/apb_vip.f

// Compilation Environment
${APB_VIP_VERIF_PATH}/regmodel/register/timer_register_pkg.sv
${APB_VIP_VERIF_PATH}/regmodel/timer_regmodel_pkg.sv
${APB_VIP_VERIF_PATH}/tb/env_pkg.sv
${APB_VIP_VERIF_PATH}/sequences/seq_pkg.sv
${APB_VIP_VERIF_PATH}/testcases/test_pkg.sv
${APB_VIP_VERIF_PATH}/tb/testbench.sv

