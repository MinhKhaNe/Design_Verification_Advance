+incdir+${AHB_VIP_VERIF_PATH}/testcases
+incdir+${AHB_VIP_VERIF_PATH}/tb

// Compilation VIP design (agent) list
-f ${AHB_VIP_ROOT}/ahb_vip.f

// Compilation Environment
${AHB_VIP_VERIF_PATH}/tb/testbench.sv
${AHB_VIP_VERIF_PATH}/tb/ahb_scoreboard.sv
${AHB_VIP_VERIF_PATH}/tb/ahb_environment.sv
${AHB_VIP_VERIF_PATH}/testcases/ahb_base_test.sv

