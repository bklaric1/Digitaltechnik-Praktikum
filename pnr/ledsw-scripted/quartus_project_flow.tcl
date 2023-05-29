## ----------------------------------------------------------------------------
## Script     : quartus_project_flow.tcl
## ----------------------------------------------------------------------------
## Author     : Johann Faerber, F. Beckmann
## Company    : University of Applied Sciences Augsburg
## ----------------------------------------------------------------------------
## Description: executes process steps in a quartus project
##              quartus_sh -t quartus_project_flow.tcl 

# Load Quartus II Tcl Project package
package require ::quartus::project


    # ----------------------------------------------------------------------------
    # Open project
    # ----------------------------------------------------------------------------
    project_open ledsw

    # ----------------------------------------------------------------------------
    # Run design flow 
    # ----------------------------------------------------------------------------
    load_package flow

    execute_flow -compile

    # ----------------------------------------------------------------------------
    # Write Reports
    # ----------------------------------------------------------------------------
    load_package report
    load_report  ledsw
    write_report_panel -file flowsummary.log "Flow Summary"

    # ----------------------------------------------------------------------------
    # Close project
    # ----------------------------------------------------------------------------
    project_close

