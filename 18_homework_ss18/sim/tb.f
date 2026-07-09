+incdir+${AHB_VIP_VERIF_PATH}/sequences
+incdir+${AHB_VIP_VERIF_PATH}/testcases
+incdir+${AHB_VIP_VERIF_PATH}/tb
+incdir+${AHB_VIP_VERIF_PATH}/regmodel
+incdir+${AHB_VIP_VERIF_PATH}/regmodel/register

// Compilation VIP design (agent) list
-f ${AHB_VIP_ROOT}/ahb_vip.f

// Compilation Environment
${AHB_VIP_VERIF_PATH}/regmodel/register/uart_register_pkg.sv
${AHB_VIP_VERIF_PATH}/regmodel/uart_regmodel_pkg.sv
${AHB_VIP_VERIF_PATH}/tb/env_pkg.sv
${AHB_VIP_VERIF_PATH}/sequences/seq_pkg.sv
${AHB_VIP_VERIF_PATH}/testcases/test_pkg.sv
${AHB_VIP_VERIF_PATH}/tb/testbench.sv

