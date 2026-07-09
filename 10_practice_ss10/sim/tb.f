+incdir+${APB_VIP_VERIF_PATH}/testcases
+incdir+${APB_VIP_VERIF_PATH}/tb

// Compilation VIP design (agent) list
-f ${APB_VIP_ROOT}/apb_vip.f

// Compilation Environment
${APB_VIP_VERIF_PATH}/tb/testbench.sv
${APB_VIP_VERIF_PATH}/tb/apb_scoreboard.sv
${APB_VIP_VERIF_PATH}/tb/apb_environment.sv
${APB_VIP_VERIF_PATH}/testcases/apb_base_test.sv

