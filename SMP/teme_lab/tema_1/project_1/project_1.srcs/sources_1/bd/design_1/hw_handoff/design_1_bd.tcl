
################################################################
# This is a generated script based on design: design_1
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2019.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_1_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# ddr, gmch, ich8, processor, usb

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7a100tcsg324-1
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name design_1

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports

  # Create instance: ddr_0, and set properties
  set block_name ddr
  set block_cell_name ddr_0
  if { [catch {set ddr_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $ddr_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: gmch_0, and set properties
  set block_name gmch
  set block_cell_name gmch_0
  if { [catch {set gmch_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $gmch_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: ich8_0, and set properties
  set block_name ich8
  set block_cell_name ich8_0
  if { [catch {set ich8_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $ich8_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: processor_0, and set properties
  set block_name processor
  set block_cell_name processor_0
  if { [catch {set processor_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $processor_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: usb_0, and set properties
  set block_name usb
  set block_cell_name usb_0
  if { [catch {set usb_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $usb_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create port connections
  connect_bd_net -net Net [get_bd_pins gmch_0/HA] [get_bd_pins processor_0/HA]
  connect_bd_net -net Net1 [get_bd_pins gmch_0/HD] [get_bd_pins processor_0/HD]
  connect_bd_net -net Net2 [get_bd_pins gmch_0/HADS] [get_bd_pins processor_0/HADS]
  connect_bd_net -net Net3 [get_bd_pins gmch_0/HBNR] [get_bd_pins processor_0/HBNR]
  connect_bd_net -net Net4 [get_bd_pins gmch_0/HDBSY] [get_bd_pins processor_0/HDBSY]
  connect_bd_net -net Net5 [get_bd_pins gmch_0/HHIT] [get_bd_pins processor_0/HHIT]
  connect_bd_net -net Net6 [get_bd_pins gmch_0/HHITM] [get_bd_pins processor_0/HHITM]
  connect_bd_net -net Net7 [get_bd_pins gmch_0/HLOCK] [get_bd_pins processor_0/HLOCK]
  connect_bd_net -net Net8 [get_bd_pins gmch_0/HREQ] [get_bd_pins processor_0/HREQ]
  connect_bd_net -net Net9 [get_bd_pins gmch_0/HBREQ0] [get_bd_pins processor_0/HBREQ0]
  connect_bd_net -net Net10 [get_bd_pins gmch_0/HDINV] [get_bd_pins processor_0/HDINV]
  connect_bd_net -net Net11 [get_bd_pins gmch_0/HADSTB] [get_bd_pins processor_0/HADSTB]
  connect_bd_net -net Net12 [get_bd_pins gmch_0/HDSTBP] [get_bd_pins processor_0/HDSTBP]
  connect_bd_net -net Net13 [get_bd_pins gmch_0/HRCOMP] [get_bd_pins processor_0/HRCOMP]
  connect_bd_net -net Net14 [get_bd_pins gmch_0/HSCOMP] [get_bd_pins processor_0/HSCOMP]
  connect_bd_net -net Net15 [get_bd_pins gmch_0/HSCOMP_C] [get_bd_pins processor_0/HSCOMP_C]
  connect_bd_net -net Net16 [get_bd_pins ich8_0/P] [get_bd_pins usb_0/P]
  connect_bd_net -net Net17 [get_bd_pins ich8_0/N] [get_bd_pins usb_0/N]
  connect_bd_net -net Net18 [get_bd_pins ddr_0/SDQ_A] [get_bd_pins gmch_0/SDQ_A]
  connect_bd_net -net Net19 [get_bd_pins ddr_0/SDQS_A] [get_bd_pins gmch_0/SDQS_A]
  connect_bd_net -net ddr_0_SBS_A [get_bd_pins ddr_0/SBS_A] [get_bd_pins gmch_0/SBS_A]
  connect_bd_net -net ddr_0_SCAS_A [get_bd_pins ddr_0/SCAS_A] [get_bd_pins gmch_0/SCAS_A]
  connect_bd_net -net ddr_0_SCKE_A [get_bd_pins ddr_0/SCKE_A] [get_bd_pins gmch_0/SCKE_A]
  connect_bd_net -net ddr_0_SCLK_A [get_bd_pins ddr_0/SCLK_A] [get_bd_pins gmch_0/SCLK_A]
  connect_bd_net -net ddr_0_SCS_A [get_bd_pins ddr_0/SCS_A] [get_bd_pins gmch_0/SCS_A]
  connect_bd_net -net ddr_0_SDM_A [get_bd_pins ddr_0/SDM_A] [get_bd_pins gmch_0/SDM_A]
  connect_bd_net -net ddr_0_SMA_A [get_bd_pins ddr_0/SMA_A] [get_bd_pins gmch_0/SMA_A]
  connect_bd_net -net ddr_0_SODT_A [get_bd_pins ddr_0/SODT_A] [get_bd_pins gmch_0/SODT_A]
  connect_bd_net -net ddr_0_SRAS_A [get_bd_pins ddr_0/SRAS_A] [get_bd_pins gmch_0/SRAS_A]
  connect_bd_net -net ddr_0_SWE_A [get_bd_pins ddr_0/SWE_A] [get_bd_pins gmch_0/SWE_A]
  connect_bd_net -net gmch_0_BSEL [get_bd_pins gmch_0/BSEL] [get_bd_pins processor_0/BSEL]
  connect_bd_net -net gmch_0_DMI_ZCOMP [get_bd_pins gmch_0/DMI_ZCOMP] [get_bd_pins ich8_0/DMI_ZCOMP]
  connect_bd_net -net gmch_0_HACCVREF [get_bd_pins gmch_0/HACCVREF] [get_bd_pins processor_0/HACCVREF]
  connect_bd_net -net gmch_0_HDVREF [get_bd_pins gmch_0/HDVREF] [get_bd_pins processor_0/HDVREF]
  connect_bd_net -net gmch_0_HPCREQ [get_bd_pins gmch_0/HPCREQ] [get_bd_pins processor_0/HPCREQ]
  connect_bd_net -net gmch_0_HSWING [get_bd_pins gmch_0/HSWING] [get_bd_pins processor_0/HSWING]
  connect_bd_net -net gmch_0_RXN [get_bd_pins gmch_0/RXN] [get_bd_pins ich8_0/RXN]
  connect_bd_net -net gmch_0_RXN_A [get_bd_pins gmch_0/RXN_A] [get_bd_pins ich8_0/RXN_A]
  connect_bd_net -net gmch_0_RXP [get_bd_pins gmch_0/RXP] [get_bd_pins ich8_0/RXP]
  connect_bd_net -net gmch_0_RXP_A [get_bd_pins gmch_0/RXP_A] [get_bd_pins ich8_0/RXP_A]
  connect_bd_net -net ich8_0_DMI_IRCOMP [get_bd_pins gmch_0/DMI_IRCOMP] [get_bd_pins ich8_0/DMI_IRCOMP]
  connect_bd_net -net ich8_0_GPIO29 [get_bd_pins ich8_0/GPIO29] [get_bd_pins usb_0/GPIO29]
  connect_bd_net -net ich8_0_GPIO30 [get_bd_pins ich8_0/GPIO30] [get_bd_pins usb_0/GPIO30]
  connect_bd_net -net ich8_0_GPIO31 [get_bd_pins ich8_0/GPIO31] [get_bd_pins usb_0/GPIO31]
  connect_bd_net -net ich8_0_OC [get_bd_pins ich8_0/OC] [get_bd_pins usb_0/OC]
  connect_bd_net -net ich8_0_TXN [get_bd_pins gmch_0/TXN] [get_bd_pins ich8_0/TXN]
  connect_bd_net -net ich8_0_TXN_A [get_bd_pins gmch_0/TXN_A] [get_bd_pins ich8_0/TXN_A]
  connect_bd_net -net ich8_0_TXP [get_bd_pins gmch_0/TXP] [get_bd_pins ich8_0/TXP]
  connect_bd_net -net ich8_0_TXP_A [get_bd_pins gmch_0/TXP_A] [get_bd_pins ich8_0/TXP_A]
  connect_bd_net -net ich8_0_USBRBIAS_I [get_bd_pins ich8_0/USBRBIAS_I] [get_bd_pins usb_0/USBRBIAS_I]
  connect_bd_net -net processor_0_HBPRI [get_bd_pins gmch_0/HBPRI] [get_bd_pins processor_0/HBPRI]
  connect_bd_net -net processor_0_HDEFER [get_bd_pins gmch_0/HDEFER] [get_bd_pins processor_0/HDEFER]
  connect_bd_net -net processor_0_HRS [get_bd_pins gmch_0/HRS] [get_bd_pins processor_0/HRS]
  connect_bd_net -net processor_0_HTRDY [get_bd_pins gmch_0/HTRDY] [get_bd_pins processor_0/HTRDY]
  connect_bd_net -net usb_0_USBRBIAS_O [get_bd_pins ich8_0/USBRBIAS_O] [get_bd_pins usb_0/USBRBIAS_O]

  # Create address segments


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


