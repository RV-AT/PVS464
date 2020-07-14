-------------------------------------------------------------------------------
--  File name : spansion_tc_pkg.vhd
-------------------------------------------------------------------------------
--  Copyright (C) 2014 Spansion, LLC.
--
--  MODIFICATION HISTORY :
--
--  version: |    author:      |  mod date: | changes made:
--    V1.0      M.Stojanovic     15 Aug 10    Initial release
-------------------------------------------------------------------------------
--  PART DESCRIPTION:
--
--  Description:
--              Generic test environment for verification of flash memory
--              VITAL models.
--              For models:
--                  S25FL256L
--
-------------------------------------------------------------------------------
--  Known Bugs:
--
-------------------------------------------------------------------------------
LIBRARY IEEE;
                USE IEEE.std_logic_1164.ALL;
                USE STD.textio.ALL;

LIBRARY FMF;
                USE FMF.gen_utils.all;
                USE FMF.conversions.all;
-------------------------------------------------------------------------------
-- ENTITY DECLARATION
-------------------------------------------------------------------------------
PACKAGE spansion_tc_pkg IS
    ---------------------------------------------------------------------------
    --Values specified in this section determine wait periods of programming,
    --erase and internal device operation
    --Min, typ and max SDF parameters should all be supported for all timing
    --models.When FTM or SDF values change,and are not supported
    --these values may need to be updated.
    ---------------------------------------------------------------------------
    SHARED VARIABLE   tW       : time;  -- WRR cycle time
    SHARED VARIABLE   tPP      : time;  -- page program time
    SHARED VARIABLE   tBP1     : time;  -- page program time
    SHARED VARIABLE   tBP2     : time;  -- sector erase time
    SHARED VARIABLE   tSE      : time;  -- sector erase time
    SHARED VARIABLE   tBE      : time;  -- bulk (chip) erase time
    SHARED VARIABLE   tHBE     : time;  -- Evaluate Erase Status Time
    SHARED VARIABLE   tCE      : time;  -- Evaluate Erase Status Time
    SHARED VARIABLE   tEPS     : time;  -- program/erase suspend time
    SHARED VARIABLE   tRS      : time;  -- Resume to next Suspend Time
    SHARED VARIABLE   tPU      : time;  -- VCC (min) to CS# Low time
    SHARED VARIABLE   tRPH     : time;  -- RESET# low to next instruction time
    SHARED VARIABLE   tPACC    : time;  -- Ready to accept PASSU command
    SHARED VARIABLE   tRES     : time;  -- Time to enter Deep Power Down  mode
    SHARED VARIABLE   tDPD     : time;  -- Time to release from Deep Power Down mode
    SHARED VARIABLE   tQEN     : time;  -- QIO, QPI mode enter to the next command
    SHARED VARIABLE   tQEX     : time;  -- QIO, QPI mode exit to the next command

    ---------------------------------------------------------------------------
    --TC type
    ---------------------------------------------------------------------------
    TYPE TC_type IS RECORD
                        SERIES   : NATURAL RANGE 1 TO 45;
                        TESTCASE : NATURAL RANGE 1 TO 15;
                    END RECORD;
    ---------------------------------------------------------------------------
    -- commands to the device
    ---------------------------------------------------------------------------
    TYPE cmd_type IS (  done,
                        idle,
                        w_enable,
                        w_enablev,
                        w_disable,
                        mbr,
                        reset_en,
                        rst,
                        bam4,
                        set_bl,
                        h_reset,
                        h_reset_io3,
                        wrar,
                        rdar,
                        clr_sr,
                        rd_dlp,
                        rd,
                        rd_4,
                        fast_rd,
                        fast_rd4,
                        dual_output_rd,
                        dual_output_rd4,
                        quad_output_rd,
                        quad_output_rd4,
                        dual_IO_rd,
                        dual_IO_rd4,
                        quad_IO_rd,
                        quad_IO_rd4,
                        ddr_quad_IO_rd,
                        ddr_quad_IO_rd4,
                        read_JID,
                        read_JQID,
                        read_SFDP,
                        read_UID,
                        read_SR1,
                        read_SR2,
                        read_CR1,
                        read_CR2,
                        read_CR3,
                        sector_erase,
                        sector_erase4,
                        block_erase,
                        block_erase4,
                        halfblock_erase,
                        halfblock_erase4,
                        chip_erase,
                        ers_susp,
                        ers_resume,
                        pg_prog,
                        pg_prog4,
                        qpg_prog,
                        qpg_prog4,
                        prg_susp,
                        prg_resume,
                        secr_prog,
                        secr_read,
                        secr_erase,
                        w_vdlr,
                        w_nvdlr,
                        irp_reg_rd,
                        w_irpp,
                        pass_reg_rd,
                        w_password,
                        psw_unlock,
                        pr_rd,
                        w_pr,
                        ibl_rd,
                        ibl_rd4,
                        w_ibl,
                        w_ibl4,
                        w_ibul,
                        w_ibul4,
                        w_gbl,
                        w_gbul,
                        w_sprp,
                        w_sprp4,
                        rdar_read,
                        wt,
                        w_dpd,
                        w_res,
                        w_wrr,
                        w_qpien,
                        w_qpiex,
                        res_rd
                     );

    ---------------------------------------------------------------------------
    -- condition to be verified
    ---------------------------------------------------------------------------
    -- list of data/ status to be veriied by checker
    TYPE status_type IS ( none,
                          read,
                          read_4,
                          read_fast,
                          read_fast_4,
                          read_dual_O,
                          read_dual_O4,
                          read_dual_IO,
                          read_dual_IO4,
                          rd_cont,
                          read_quad_O,
                          read_quad_O4,
                          read_quad_IO,
                          read_quad_IO4,
                          read_ddr_quad_IO,
                          read_ddr_quad_IO4,
                          rd_HiZ,
                          rd_U,
                          read_secr,
                          rd_JID,
                          rd_JQID,
                          rd_SFDP,
                          rd_UID,
                          rd_SR1,
                          rd_SR2,
                          rd_CR1,
                          rd_CR2,
                          rd_CR3,
                          read_rdar,
                          read_dlp,
                          read_irp,
                          read_pass_reg,
                          read_ibl,
                          read_ibl4,
                          read_pr,
                          rd_wip_0,
                          rd_wip_1,
                          rd_wel_0,
                          rd_wel_1,
                          erase_succ,
                          erase_nosucc,
                          pgm_succ,
                          pgm_nosucc,
                          rd_ps_0,
                          rd_ps_1,
                          rd_es_0,
                          rd_es_1,
                          read_ibl_0,
                          read_ibl_1,
                          rd_res,
                          err
                        );
    ---------------------------------------------------------------------------
    --
    ---------------------------------------------------------------------------
    TYPE Aux_type IS (  valid,
                        violate,
                        clock_num,
                        break,
                        PowerUp,
                        DontAssertCSNeg
                     );

    TYPE cmd_rec IS
        RECORD
            cmd      :   cmd_type;
            status   :   status_type;
            byte_num :   NATURAL RANGE 0 TO 16#2000#;
            data1    :   NATURAL;
            sect     :   NATURAL;
            addr     :   INTEGER;
            aux      :   Aux_type;
            wtime    :   time;
        END RECORD;

    --number of testcases per testseries
    TYPE tc_list IS  ARRAY (1 TO 19) OF NATURAL;
    CONSTANT tc : tc_list :=
    --0                 1                   2                   3
    --1-2-3-4-5-6-7-8-9-0-1-2-3-4-5-6-7-8-9-0-1-2-3-4-5-6-7-8-9-0-1-2-3
     (1,1,2,4,3,2,3,2,7,2,2,1,1,1,3,2,1,1,9);

    --TC command sequence
    TYPE cmd_seq_type IS ARRAY(0 TO 300) OF cmd_rec;

    ---------------------------------------------------------------------------
    --PUBLIC
    --PROCEDURE to generate command sequence
    ---------------------------------------------------------------------------
    PROCEDURE   Generate_TC
         (  Model       : IN  STRING  ;
            Series      : IN  NATURAL RANGE 1 TO 45;
            TestCase    : IN  NATURAL RANGE 1 TO 15;
            command_seq : OUT cmd_seq_type
         );
    ---------------------------------------------------------------------------
    --PUBLIC
    --PROCEDURE to set DUT dependant parameters
    ---------------------------------------------------------------------------
    PROCEDURE   TestInit (
            Model        : IN  STRING;
            LongTimming  : IN  boolean);
    ---------------------------------------------------------------------------
    --PUBLIC
    -- CHECKER PROCEDURES
    ---------------------------------------------------------------------------
    PROCEDURE   Check_read (
        DQ       :  IN std_logic_vector(7 downto 0);
        DQ_reg0  :  IN std_logic_vector(7 downto 0);
        D_mem    :  IN NATURAL;
        DLP_reg  :  IN NATURAL;
        DLP_EN   :  IN std_logic;
        SIGNAL check_err:  OUT std_logic);

    PROCEDURE   Check_Z (
        DQ   :  IN std_logic;
        SIGNAL check_err:  OUT std_logic);

    PROCEDURE   Check_X (
        DQ   :  IN std_logic;
        SIGNAL check_err:  OUT std_logic);

    PROCEDURE   Check_secr_read (
        DQ   :  IN std_logic_vector(7 downto 0);
        otp_mem:  IN NATURAL;
        SIGNAL check_err:  OUT std_logic);

    PROCEDURE   Check_read_JID (
        DQ               :  IN std_logic_vector(7 downto 0);
        VDATA            :  IN NATURAL;
        SIGNAL check_err :  OUT std_logic);

    PROCEDURE   Check_read_DevID (
        DQ               :  IN std_logic_vector(7 downto 0);
        VDATA            :  IN NATURAL;
        SIGNAL check_err :  OUT std_logic);

    PROCEDURE   Check_read_SFDP (
        DQ               :  IN std_logic_vector(7 downto 0);
        VDATA            :  IN NATURAL;
        SIGNAL check_err :  OUT std_logic);

    PROCEDURE   Check_read_UID (
        DQ               :  IN std_logic_vector(7 downto 0);
        VDATA            :  IN NATURAL;
        SIGNAL check_err :  OUT std_logic);

    PROCEDURE   Check_read_reg (
        DQ               :  IN std_logic_vector(7 downto 0);
        VDATA            :  IN NATURAL;
        sts              :  IN NATURAL;
        SIGNAL check_err :  OUT std_logic);

    PROCEDURE   Check_rdar (
        DQ   :  IN std_logic_vector(7 downto 0);
        D_mem:  IN NATURAL;
        SIGNAL check_err:  OUT std_logic);

    PROCEDURE   Check_read_dlp (
        DQ     :  IN std_logic_vector(7 downto 0);
        DLP_reg:  IN NATURAL;
        SIGNAL check_err:  OUT std_logic);

    PROCEDURE   Check_read_irp (
        DQ   :  IN std_logic_vector(15 downto 0);
        D_mem:  IN NATURAL;
        SIGNAL check_err:  OUT std_logic);

    PROCEDURE   Check_read_pr (
        DQ   :  IN std_logic_vector(7 downto 0);
        D_mem:  IN NATURAL;
        SIGNAL check_err:  OUT std_logic);

    PROCEDURE   Check_read_pass_reg (
        DQ   :  IN std_logic_vector(63 downto 0);
        D_mem:  IN NATURAL;
        SIGNAL check_err:  OUT std_logic);

    PROCEDURE   Check_WIP_bit (
        DQ   :  IN std_logic;
        sts  :  IN  status_type;
        SIGNAL check_err:  OUT std_logic);

    PROCEDURE   Check_WEL_bit (
        DQ   :  IN std_logic;
        sts  :  IN  status_type;
        SIGNAL check_err:  OUT std_logic);

    PROCEDURE   Check_eers_bit (
        DQ   :  IN std_logic;
        sts  :  IN  status_type;
        SIGNAL check_err:  OUT std_logic);

    PROCEDURE   Check_epgm_bit (
        DQ   :  IN std_logic;
        sts  :  IN  status_type;
        SIGNAL check_err:  OUT std_logic);

    PROCEDURE Check_PS_bit (
        DQ   :  IN std_logic;
        sts  :  IN  status_type;
        SIGNAL check_err:  OUT std_logic);

    PROCEDURE Check_ES_bit (
        DQ   :  IN std_logic;
        sts  :  IN  status_type;
        SIGNAL check_err:  OUT std_logic);

    PROCEDURE   Check_IBL_reg (
        DQ   :  IN std_logic_vector(7 downto 0);
        sts  :  IN  status_type;
        SIGNAL check_err:  OUT std_logic);

END PACKAGE  spansion_tc_pkg;

PACKAGE BODY spansion_tc_pkg IS

    PROCEDURE   TestInit ( Model       : IN  STRING;
                           LongTimming  : IN  BOOLEAN  )
    IS
    BEGIN
        IF LongTimming THEN
            tW     := 750 ms;
            tPP    := 900 us;
            tBP1   := 25 us;
            tBP2   := 20 ms;
            tSE    := 200 ms;
            tHBE   := 363 ms;
            tBE    := 725 ms;
            tCE    := 360000 ms;
            tEPS   := 40 us;
            tRS    := 100 us;
            tPU    := 300 us;
            tRPH   := 100 us;
            tPACC  := 100 us;
            tDPD   := 3 us;
            tRES   := 3 us;
            tQEN   := 1.5 us;
            tQEX   := 1 us;

        ELSE
            tW     := 750 us;
            tPP    := 900 us;
            tBP1   := 25 us;
            tBP2   := 20 us;
            tSE    := 200 us;
            tHBE   := 363 us;
            tBE    := 725 us;
            tCE    := 360 ms;
            tEPS   := 40 us;
            tRS    := 100 us;
            tPU    := 300 us;
            tRPH   := 100 us;
            tPACC  := 100 us;
            tDPD   := 3 us;
            tRES   := 3 us;
            tQEN   := 1.5 us;
            tQEX   := 1 us;
        END IF;


    END PROCEDURE TestInit;
    ---------------------------------------------------------------------------
    --Public PROCEDURE to generate command sequence
    ---------------------------------------------------------------------------
    PROCEDURE   Generate_TC
         (  Model       : IN  STRING;
            Series      : IN  NATURAL RANGE 1 TO 45;
            TestCase    : IN  NATURAL RANGE 1 TO 15;
            command_seq : OUT cmd_seq_type
         )
    IS

    BEGIN

        FOR i IN 1 TO 200 LOOP
            --cmd,sts,byte_num,data1,sect,addr,aux_t,time
            command_seq(i) :=(done,none,0,0,0,0,valid,0 ns);
        END LOOP;

        REPORT "------------------------------------------------------" ;
        REPORT "------------------------------------------------------" ;
        REPORT "TestSeries : "& to_int_str(Series )&"   "&
               "TC         : "& to_int_str(TestCase);
        REPORT "------------------------------------------------------" ;
        CASE Series IS
            WHEN 1  =>
                CASE Testcase IS
                    WHEN 1  =>
                    REPORT "POWERUP negative test";
                    -- warning is generated if device is selected on PowerUp
                    command_seq(1) :=(idle   ,none  ,0,0,0,0,valid,0 ns);
                    command_seq(2) :=(wt     ,none  ,0,0,0,0,valid,200 ns);
                    command_seq(3) :=(rd     ,rd_HiZ,2,0,0,0,valid,0 ns);
                    command_seq(4) :=(wt     ,none  ,0,0,0,0,valid,tPU);
                    command_seq(5) :=(idle   ,none  ,0,0,0,0,valid,0 ns);
                    command_seq(6) :=(w_enable,none ,0,0,0,0,valid,0 ns);
                    command_seq(7) :=(idle   ,none  ,0,0,0,0,valid,0 ns);
                    command_seq(8) :=(wrar,none,1,16#79#,16#800#,4,valid,0 ns);
                    command_seq(9) :=(idle   ,none     ,0,0,0,0,valid,0 ns);
                    command_seq(10) :=(wt   ,none     ,0,0,0,0,valid,50 ns);
                    command_seq(11) :=(rdar,read_rdar,1,0,16#800#,0,valid,0 ns);
                    command_seq(12) :=(idle   ,none     ,0,0,0,0,valid,0 ns);
                    command_seq(13) :=(rdar,read_rdar,1,0,16#800#,4,valid,0 ns);
                    command_seq(14) :=(idle   ,none     ,0,0,0,0,valid,0 ns);
                    command_seq(15):=(done   ,none  ,0,0,0,0,valid,0 ns);

                    WHEN OTHERS => NULL;
                END CASE;

            WHEN 2  =>
                REPORT "POWERUP positive test";
                --cmd,sts,byte_num,data1,sect,addr,aux_t,time
                command_seq(1) :=(idle   ,none  ,0,0,0,0,valid,0 ns);
                command_seq(2) :=(rd     ,read  ,2,0,0,0,valid,0 ns);
                command_seq(3) :=(idle   ,none  ,0,0,0,0,valid,0 ns);
                command_seq(4) :=(done   ,none  ,0,0,0,0,valid,0 ns);

            WHEN 3  =>  --write enable/write disable positive tests
                CASE Testcase IS
                    WHEN 1  =>
                    REPORT "WREN positive test";
                    command_seq(1) :=(idle   ,none  ,0,0,0,0,valid,0 ns);
                    command_seq(2) :=(w_enable,none ,0,0,0,0,valid,0 ns);
                    command_seq(3) :=(idle   ,none  ,0,0,0,0,valid,0 ns);
                    command_seq(4) :=(rdar,rd_wel_1,1,0,16#800#,0,valid,0 ns);
                    command_seq(5) :=(idle   ,none  ,0,0,0,0,valid,0 ns);
                    command_seq(6) :=(done   ,none  ,0,0,0,0,valid,0 ns);

                    WHEN 2  =>
                    REPORT "WRDI positive test";
                    command_seq(1) :=(idle   ,none  ,0,0,0,0,valid,0 ns);
                    command_seq(2) :=(w_disable,none,0,0,0,0,valid,0 ns);
                    command_seq(3) :=(idle   ,none  ,0,0,0,0,valid,0 ns);
                    command_seq(4) :=(rdar,rd_wel_0,1,0,16#800#,0,valid,0 ns);
                    command_seq(5) :=(idle   ,none  ,0,0,0,0,valid,0 ns);
                    command_seq(6) :=(done   ,none  ,0,0,0,0,valid,0 ns);

                    WHEN OTHERS => NULL;
                END CASE;
 
            WHEN 4  => -- Identification commands
                CASE Testcase IS
                    WHEN 1  =>
                    REPORT "Read Device ID, positive test";
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(2)  :=(read_JID,rd_JID ,3,0,0,0,valid,0 ns);
                    command_seq(3)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- enter QPI mode
                    command_seq(4)  :=(w_enablev,none ,0,0,0,0,valid,0 ns);
                    command_seq(5)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(6)  :=(w_wrr,none ,3,16#680000#,0,0,valid,0 ns);
                    command_seq(7)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(8)  :=(wt   ,none     ,0,0,0,0,valid,tQEN);
                    command_seq(9)  :=(read_JID,rd_JID ,3,0,0,0,valid,0 ns);
                    command_seq(10) :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(11) :=(read_JQID,rd_JQID ,3,0,0,0,valid,0 ns);
                    command_seq(12) :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- exit QPI mode
                    command_seq(13)  :=(w_enablev,none ,0,0,0,0,valid,0 ns);
                    command_seq(14)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(15)  :=(w_wrr,none ,3,16#600000#,0,0,valid,0 ns);
                    command_seq(16)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(17)  :=(wt   ,none     ,0,0,0,0,valid,tQEX);
                    -- enter QUAD mode
                    command_seq(18)  :=(w_enablev,none ,0,0,0,0,valid,0 ns);
                    command_seq(19)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(20)  :=(w_wrr,none ,2,16#0200#,0,0,valid,0 ns);
                    command_seq(21)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(22)  :=(wt   ,none     ,0,0,0,0,valid,tQEN);
                    command_seq(23)  :=(read_JQID,rd_JQID ,3,0,0,0,valid,0 ns);
                    command_seq(24)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- exit QUAD mode
                    command_seq(25)  :=(w_enablev,none ,0,0,0,0,valid,0 ns);
                    command_seq(26)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(27)  :=(w_wrr,none ,2,16#0000#,0,0,valid,0 ns);
                    command_seq(28)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(29)  :=(wt   ,none     ,0,0,0,0,valid,tQEX);
                    command_seq(30)  :=(done   ,none,0,0,0,0,valid,0 ns);

                    WHEN 2  =>
                    REPORT "Read SFDP table, positive test";
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(2)  :=(read_SFDP,rd_SFDP ,3,0,0,0,valid,0 ns);
                    command_seq(3)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- enter QPI mode
                    command_seq(4)  :=(w_qpien,none ,0,0,0,0,valid,0 ns);
                    command_seq(5)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(6)  :=(wt   ,none     ,0,0,0,0,valid,tQEN);
                    command_seq(7)  :=(read_SFDP,rd_SFDP ,3,0,0,0,valid,0 ns);
                    command_seq(8)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- exit QPI mode
                    command_seq(9)  :=(w_qpiex,none ,0,0,0,0,valid,0 ns);
                    command_seq(10) :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(11) :=(wt   ,none     ,0,0,0,0,valid,tQEX);
                    command_seq(12) :=(done   ,none,0,0,0,0,valid,0 ns);

                    WHEN 3  =>
                    REPORT "Read UID, positive test";
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(2)  :=(read_UID,rd_UID ,3,0,0,0,valid,0 ns);
                    command_seq(3)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- enter QPI mode
                    command_seq(4)  :=(w_qpien,none ,0,0,0,0,valid,0 ns);
                    command_seq(5)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(6)  :=(wt   ,none     ,0,0,0,0,valid,tQEN);
                    command_seq(7)  :=(read_UID,rd_UID ,3,0,0,0,valid,0 ns);
                    command_seq(8)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- exit QPI mode
                    command_seq(9)  :=(w_qpiex,none ,0,0,0,0,valid,0 ns);
                    command_seq(10) :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(11) :=(wt   ,none     ,0,0,0,0,valid,tQEX);
                    command_seq(12) :=(done   ,none,0,0,0,0,valid,0 ns);

                    WHEN 4  =>
                    REPORT "RES / read DeviceID, positive test";
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(2)  :=(res_rd,rd_res ,2,0,0,0,valid,0 ns);
                    command_seq(3)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- enter QPI mode
                    command_seq(4)  :=(w_qpien,none ,0,0,0,0,valid,0 ns);
                    command_seq(5)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(6)  :=(wt   ,none     ,0,0,0,0,valid,tQEN);
                    command_seq(7)  :=(res_rd,rd_res ,2,0,0,0,valid,0 ns);
                    command_seq(8)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- exit QPI mode
                    command_seq(9)  :=(w_qpiex,none ,0,0,0,0,valid,0 ns);
                    command_seq(10) :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(11) :=(wt   ,none     ,0,0,0,0,valid,tQEX);
                    command_seq(12) :=(done   ,none,0,0,0,0,valid,0 ns);

                    WHEN OTHERS => NULL;
                END CASE;

            WHEN 5  => -- Register access commands
                CASE Testcase IS
                    WHEN 1  =>
                    REPORT "Read SR1, SR2, CR1, CR2, CR3, positive test";
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(2)  :=(read_SR1,rd_SR1 ,2,0,0,0,valid,0 ns);
                    command_seq(3)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(4)  :=(read_SR2,rd_SR2 ,2,0,0,0,valid,0 ns);
                    command_seq(5)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(6)  :=(read_CR1,rd_CR1 ,2,0,0,0,valid,0 ns);
                    command_seq(7)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(8)  :=(read_CR2,rd_CR2 ,2,0,0,0,valid,0 ns);
                    command_seq(9)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(10)  :=(read_CR3,rd_CR3 ,2,0,0,0,valid,0 ns);
                    command_seq(11)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- enter QPI mode
                    command_seq(12)  :=(w_qpien,none ,0,0,0,0,valid,0 ns);
                    command_seq(13)  :=(wt   ,none     ,0,0,0,0,valid,tQEN);
                    command_seq(14)  :=(read_SR1,rd_SR1 ,2,0,0,0,valid,0 ns);
                    command_seq(15)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- exit QPI mode
                    command_seq(16)  :=(w_qpiex,none ,0,0,0,0,valid,0 ns);
                    command_seq(17)  :=(wt   ,none     ,0,0,0,0,valid,tQEX);
                    command_seq(18)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(19)  :=(done   ,none,0,0,0,0,valid,0 ns);

                    WHEN 2  =>
                    REPORT "Write registers, positive test";
                    REPORT "Write SR1, positive test";
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(2)  :=(w_enable,none ,0,0,0,0,valid,0 ns);
                    command_seq(3)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- SR1_NV
                    -- write SRP0_NV, SEC_NV, TBPROT_NV, BP_NV
                    command_seq(4)  :=(w_wrr,none ,1,16#E4#,0,0,valid,0 ns);
                    command_seq(5)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(6)  :=(wt   ,none     ,0,0,0,0,valid,tW);
                    command_seq(7)  :=(read_SR1,rd_SR1 ,1,0,0,0,valid,0 ns);
                    -- enter QPI mode
                    command_seq(8)  :=(w_qpien,none ,0,0,0,0,valid,0 ns);
                    command_seq(9)  :=(wt   ,none     ,0,0,0,0,valid,tQEN);
                    command_seq(10)  :=(w_enable,none ,0,0,0,0,valid,0 ns);
                    command_seq(11)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(12)  :=(w_wrr,none ,1,16#00#,0,0,valid,0 ns);
                    command_seq(13)  :=(wt   ,none     ,0,0,0,0,valid,tW);
                    command_seq(14)  :=(read_SR1,rd_SR1 ,1,0,0,0,valid,0 ns);
                    command_seq(15)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- exit QPI mode
                    command_seq(16)  :=(w_qpiex,none ,0,0,0,0,valid,0 ns);
                    command_seq(17)  :=(wt   ,none     ,0,0,0,0,valid,tQEX);
                    command_seq(18)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- SR1_V
                    -- write SRP0, SEC, TBPROT, BP
                    command_seq(19)  :=(w_enablev,none ,0,0,0,0,valid,0 ns);
                    command_seq(20)  :=(w_wrr,none ,1,16#E4#,0,0,valid,0 ns);
                    command_seq(21)  :=(wt   ,none     ,0,0,0,0,valid,50 ns);
                    command_seq(22)  :=(read_SR1,rd_SR1 ,1,0,0,0,valid,0 ns);
                    -- enter QPI mode
                    command_seq(23)  :=(w_qpien,none ,0,0,0,0,valid,0 ns);
                    command_seq(24)  :=(wt   ,none     ,0,0,0,0,valid,tQEN);
                    command_seq(25)  :=(w_enablev,none ,0,0,0,0,valid,0 ns);
                    command_seq(26)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(27)  :=(w_wrr,none ,1,16#00#,0,0,valid,0 ns);
                    command_seq(28)  :=(wt   ,none     ,0,0,0,0,valid,50 ns);
                    command_seq(29)  :=(read_SR1,rd_SR1 ,1,0,0,0,valid,0 ns);
                    command_seq(30)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- exit QPI mode
                    command_seq(31)  :=(w_qpiex,none ,0,0,0,0,valid,0 ns);
                    command_seq(32)  :=(wt   ,none     ,0,0,0,0,valid,tQEX);
                    command_seq(33)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(34)  :=(read_SR1,rd_SR1 ,1,0,0,0,valid,0 ns);

                    command_seq(35) :=(done   ,none,0,0,0,0,valid,0 ns);

                    WHEN 3  =>
                    REPORT "Write Any Register, positive test";
                    REPORT "Write SR1NV, SR1V";
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(2)  :=(w_enable,none ,0,0,0,0,valid,0 ns);
                    command_seq(3)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- SR1_NV
                    -- write SRP0_NV, SEC_NV, TBPROT_NV, BP_NV
                    command_seq(4)  :=(wrar,none ,1,16#E4#,0,0,valid,0 ns);
                    command_seq(5)  :=(rdar ,rd_wip_1 ,1,0,16#800#,0,valid,0 ns);
                    command_seq(6)  :=(wt   ,none     ,0,0,0,0,valid,tW);
                    command_seq(7)  :=(read_SR1,rd_SR1 ,1,0,0,0,valid,0 ns);
                    -- enter QPI mode
                    command_seq(8)  :=(w_qpien,none ,0,0,0,0,valid,0 ns);
                    command_seq(9)  :=(wt   ,none     ,0,0,0,0,valid,tQEN);
                    command_seq(10)  :=(w_enable,none ,0,0,0,0,valid,0 ns);
                    command_seq(11)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(12)  :=(wrar,none ,1,16#00#,0,0,valid,0 ns);
                    command_seq(13)  :=(rdar ,rd_wip_1 ,1,0,16#800#,0,valid,0 ns);
                    command_seq(14)  :=(wt   ,none     ,0,0,0,0,valid,tW);
                    command_seq(15)  :=(read_SR1,rd_SR1 ,1,0,0,0,valid,0 ns);
                    command_seq(16)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- exit QPI mode
                    command_seq(17)  :=(w_qpiex,none ,0,0,0,0,valid,0 ns);
                    command_seq(18)  :=(wt   ,none     ,0,0,0,0,valid,tQEX);
                    command_seq(19)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- SR1_V
                    -- write SRP0, SEC, TBPROT, BP
                    command_seq(20)  :=(w_enable,none ,0,0,0,0,valid,0 ns);
                    command_seq(21)  :=(wrar,none ,1,16#E4#,16#800#,0,valid,0 ns);
                    command_seq(22)  :=(wt   ,none     ,0,0,0,0,valid,50 ns);
                    command_seq(23)  :=(read_SR1,rd_SR1 ,1,0,0,0,valid,0 ns);
                    -- enter QPI mode
                    command_seq(24)  :=(w_qpien,none ,0,0,0,0,valid,0 ns);
                    command_seq(25)  :=(wt   ,none     ,0,0,0,0,valid,tQEN);
                    command_seq(26)  :=(w_enable,none ,0,0,0,0,valid,0 ns);
                    command_seq(27)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(28)  :=(wrar,none ,1,16#00#,16#800#,0,valid,0 ns);
                    command_seq(29)  :=(wt   ,none     ,0,0,0,0,valid,50 ns);
                    command_seq(30)  :=(read_SR1,rd_SR1 ,1,0,0,0,valid,0 ns);
                    command_seq(31)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- exit QPI mode
                    command_seq(32)  :=(w_qpiex,none ,0,0,0,0,valid,0 ns);
                    command_seq(33)  :=(wt   ,none     ,0,0,0,0,valid,tQEX);
                    command_seq(34)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(35)  :=(read_SR1,rd_SR1 ,1,0,0,0,valid,0 ns);
                    command_seq(36)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(37) :=(done   ,none,0,0,0,0,valid,0 ns);

                    WHEN OTHERS => NULL;
                END CASE;

            WHEN 6  => -- Status Registers protection
                CASE Testcase IS
                    WHEN 1  =>
                    REPORT "Hardware protection, WP#=0, SR0=1, positive test";
                    -- WP# low
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,violate,0 ns);
                    -- write SRP0
                    command_seq(2)  :=(w_enablev,none ,0,0,0,0,valid,0 ns);
                    command_seq(3)  :=(w_wrr,none ,1,16#80#,16#800#,0,valid,0 ns);
                    command_seq(4)  :=(wt   ,none     ,0,0,0,0,valid,50 ns);
                    command_seq(5)  :=(read_SR1,rd_SR1 ,1,0,0,0,valid,0 ns);
                    -- enter WRR command
                    command_seq(6)  :=(w_enable,none ,0,0,0,0,valid,0 ns);
                    command_seq(7)  :=(w_wrr,none ,1,16#00#,0,0,valid,0 ns);
                    command_seq(8)  :=(read_SR1 ,rd_wip_0 ,1,0,0,0,valid,0 ns);
                    -- enter WRAR command
                    command_seq(9)  :=(w_enable,none ,0,0,0,0,valid,0 ns);
                    command_seq(10)  :=(wrar,none ,1,16#00#,0,0,valid,0 ns);
                    command_seq(11)  :=(read_SR1 ,rd_wip_0 ,1,0,0,0,valid,0 ns);
                    -- enter Program DLRNV command
                    command_seq(12)  :=(w_enable,none ,0,0,0,0,valid,0 ns);
                    command_seq(13)  :=(w_nvdlr,err ,1,16#34#,0,0,valid,0 ns);
                    command_seq(14)  :=(read_SR1 ,rd_wip_0 ,1,0,0,0,valid,0 ns);
                    -- enter Write DLRV command
                    command_seq(15)  :=(w_enable,none ,0,0,0,0,valid,0 ns);
                    command_seq(16)  :=(w_vdlr,err ,1,16#34#,0,0,valid,0 ns);
                    command_seq(17)  :=(rd_dlp ,read_dlp ,1,0,0,0,valid,0 ns);
                    command_seq(18)  :=(idle   ,none    ,0,0,0,0,violate,0 ns);
                    command_seq(19)  :=(done   ,none,0,0,0,0,valid,0 ns);

                    WHEN 2  =>
                    REPORT "Power Suply Lock-Down, SR1=1, positive test";
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- write SRP1=1
                    command_seq(2)  :=(w_enablev,none ,0,0,0,0,valid,0 ns);
                    command_seq(3)  :=(w_wrr,none ,2,16#0100#,16#800#,16#02#,valid,0 ns);
                    command_seq(4)  :=(wt   ,none     ,0,0,0,0,valid,50 ns);
                    command_seq(5)  :=(read_CR1,rd_CR1 ,1,0,0,0,valid,0 ns);
                    -- enter WRR command
                    command_seq(6)  :=(w_enable,none ,0,0,0,0,valid,0 ns);
                    command_seq(7)  :=(w_wrr,none ,1,16#00#,0,0,valid,0 ns);
                    command_seq(8)  :=(read_SR1 ,rd_wip_0 ,1,0,0,0,valid,0 ns);
                    -- enter WRAR command
                    command_seq(9)  :=(w_enable,none ,0,0,0,0,valid,0 ns);
                    command_seq(10)  :=(wrar,none ,1,16#00#,0,0,valid,0 ns);
                    command_seq(11)  :=(read_SR1 ,rd_wip_0 ,1,0,0,0,valid,0 ns);
                    -- enter Program DLRNV command
                    command_seq(12)  :=(w_enable,none ,0,0,0,0,valid,0 ns);
                    command_seq(13)  :=(w_nvdlr,err ,1,16#34#,0,0,valid,0 ns);
                    command_seq(14)  :=(read_SR1 ,rd_wip_0 ,1,0,0,0,valid,0 ns);
                    -- enter Write DLRV command
                    command_seq(15)  :=(w_enable,none ,0,0,0,0,valid,0 ns);
                    command_seq(16)  :=(w_vdlr,err ,1,16#34#,0,0,valid,0 ns);
                    command_seq(17)  :=(wt   ,none     ,0,0,0,0,valid,50 ns);
                    command_seq(18)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(19)  :=(rd_dlp ,read_dlp ,1,0,0,0,valid,0 ns);
                    command_seq(20)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);

                    command_seq(21)  :=(h_reset,none ,0,0,0,0,valid,201 ns);
                    command_seq(22)  :=(wt   ,none     ,0,0,0,0,valid,tRPH+100 ns);
                    command_seq(23)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(24)  :=(read_CR1,rd_CR1 ,1,0,0,0,valid,0 ns);

                    command_seq(25)  :=(w_enable,none ,0,0,0,0,valid,0 ns);
                    command_seq(26) :=(wrar,none,1,16#79#,16#800#,4,valid,0 ns);
                    command_seq(27) :=(idle   ,none     ,0,0,0,0,valid,0 ns);
                    command_seq(28)  :=(done   ,none,0,0,0,0,valid,0 ns);
                    WHEN OTHERS => NULL;
                END CASE;

            WHEN 7  => -- Read Memory Array commands
                CASE Testcase IS
                    WHEN 1  =>
                    REPORT "Single, Dual Output, Dual I/O Read commands for the main flash array, positive test";
                    -- Read
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(2)  :=(rd     ,read    ,5,0,0,0,valid,0 ns);
                    command_seq(3)  :=(rd     ,read    ,10,0,16#FFF#,16#FFA#,valid,0 ns);
                    command_seq(4)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- Fast Read
                    command_seq(5)  :=(fast_rd     ,read_fast    ,5,0,1,0,valid,0 ns);
                    command_seq(6)  :=(fast_rd     ,read_fast    ,10,0,16#FFF#,16#FFA#,valid,0 ns);
                    command_seq(7)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- Dual Output Read
                    command_seq(8)  :=(dual_output_rd     ,read_dual_O    ,5,0,2,0,valid,0 ns);
                    command_seq(9)  :=(dual_output_rd     ,read_dual_O    ,10,0,16#FFF#,16#FFA#,valid,0 ns);
                    command_seq(10)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- Dual IO Read
                    command_seq(11)  :=(dual_IO_rd     ,read_dual_IO    ,5,0,3,0,valid,0 ns);
                    command_seq(12)  :=(dual_IO_rd     ,read_dual_IO    ,10,0,16#FFF#,16#FFA#,valid,0 ns);
                    command_seq(13)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- Dual IO Continuous Read
                    command_seq(14)  :=(dual_IO_rd     ,read_dual_IO    ,3,16#A0#,4,0,valid,0 ns);
                    command_seq(15)  :=(dual_IO_rd     ,rd_cont    ,3,0,5,0,valid,0 ns);
                    command_seq(16)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- Dual IO Continuous Read exit with mode reset command
                    command_seq(17)  :=(dual_IO_rd     ,read_dual_IO    ,3,16#A0#,5,0,valid,0 ns);
                    command_seq(18)  :=(mbr     ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(19)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(20)  :=(done   ,none    ,0,0,0,0,valid,0 ns);

                    WHEN 2  =>
                    REPORT "Quad Output Read and Quad I/O Read commands for the main flash array, positive test";
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- enter QUAD mode
                    command_seq(2)  :=(w_enablev,none ,0,0,0,0,valid,0 ns);
                    command_seq(3)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(4)  :=(w_wrr,none ,2,16#0200#,0,0,valid,0 ns);
                    command_seq(5)  :=(wt   ,none     ,0,0,0,0,valid,tQEN);
                    -- set RL=13
                    command_seq(6)  :=(w_enablev,none ,0,0,0,0,valid,0 ns);
                    command_seq(7)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(8)  :=(w_wrr,none ,4,16#7D600200#,0,0,valid,0 ns);
                    command_seq(9)  :=(wt   ,none     ,0,0,0,0,valid,50 ns);
                    -- Quad Output Read
                    command_seq(10)  :=(quad_output_rd     ,read_quad_O    ,5,0,7,0,valid,0 ns);
                    command_seq(11)  :=(quad_output_rd     ,read_quad_O    ,10,0,16#FFF#,16#FFA#,valid,0 ns);
                    command_seq(12)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- Quad IO Read
                    command_seq(13)  :=(quad_IO_rd     ,read_quad_IO    ,5,0,3,0,valid,0 ns);
                    command_seq(14)  :=(quad_IO_rd     ,read_quad_IO    ,10,0,16#FFF#,16#FFA#,valid,0 ns);
                    command_seq(15)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- Dual IO Continuous Read
                    command_seq(16)  :=(quad_IO_rd     ,read_quad_IO    ,3,16#A0#,4,0,valid,0 ns);
                    command_seq(17)  :=(quad_IO_rd     ,rd_cont    ,3,0,5,0,valid,0 ns);
                    command_seq(18)  :=(idle   ,none   ,0,0,0,0,valid,0 ns);
                    -- Dual IO Continuous Read exit with mode reset command
                    command_seq(19)  :=(quad_IO_rd     ,read_quad_IO    ,3,16#A0#,5,0,valid,0 ns);
                    command_seq(20)  :=(mbr     ,none   ,0,0,0,0,valid,0 ns);
                    command_seq(21)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- QPI mode
                    command_seq(22)  :=(w_qpien,none ,0,0,0,0,valid,0 ns);
                    command_seq(23)  :=(wt   ,none     ,0,0,0,0,valid,tQEN);
                    command_seq(24)  :=(quad_IO_rd     ,read_quad_IO    ,5,0,0,0,valid,0 ns);
                    command_seq(25)  :=(w_qpiex,none ,0,0,0,0,valid,0 ns);
                    command_seq(26)  :=(wt   ,none     ,0,0,0,0,valid,tQEX);

                    -- set 8-bit burst wrap mode
                    command_seq(27)  :=(w_enablev,none ,0,0,0,0,valid,0 ns);
                    command_seq(28)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(29)  :=(w_wrr,none ,4,16#0d600200#,0,0,valid,0 ns);
                    command_seq(30)  :=(wt   ,none     ,0,0,0,0,valid,50 ns);
                    command_seq(31)  :=(read_CR3,rd_CR3 ,1,0,0,0,valid,0 ns);
                    command_seq(32)  :=(quad_IO_rd     ,read_quad_IO    ,10,0,0,3,valid,0 ns);

                    -- set 16-bit burst wrap mode
                    command_seq(33)  :=(w_enable,none ,0,0,0,0,valid,0 ns);
                    command_seq(34)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(35)  :=(wrar,none ,4,16#2d#,16#800#,4,valid,0 ns);
                    command_seq(36)  :=(wt   ,none     ,0,0,0,0,valid,50 ns);
                    command_seq(37)  :=(read_CR3,rd_CR3 ,1,0,0,0,valid,0 ns);
                    command_seq(38)  :=(quad_IO_rd     ,read_quad_IO    ,20,0,3,3,valid,0 ns);
                    -- set 32-bit burst wrap mode
                    command_seq(39)  :=(set_bl,none ,0,16#40#,0,0,valid,0 ns);
                    command_seq(40)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(41)  :=(read_CR3,rd_CR3 ,1,0,0,0,valid,0 ns);
                    command_seq(42)  :=(quad_IO_rd     ,read_quad_IO    ,40,0,4,4,valid,0 ns);
                    -- disable burst wrap mode
                    command_seq(43)  :=(set_bl,none ,0,16#10#,0,0,valid,0 ns);
                    command_seq(44)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(45)  :=(done   ,none    ,0,0,0,0,valid,0 ns);

                    WHEN 3  =>
                    REPORT " DDR Quad I/O read commands for the main flash array, positive test";
                    command_seq(1)  :=(idle   ,none   ,0,0,0,0,valid,0 ns);
                    command_seq(2)  :=(ddr_quad_IO_rd ,read_ddr_quad_IO    ,5,0,5,0,valid,0 ns);
                    command_seq(3)  :=(ddr_quad_IO_rd ,read_ddr_quad_IO    ,10,0,16#FFF#,16#FFA#,valid,0 ns);
                    command_seq(4)  :=(idle   ,none   ,0,0,0,0,valid,0 ns);
                    -- DDR QUAD IO Continuous Read
                    command_seq(5)  :=(ddr_quad_IO_rd ,read_ddr_quad_IO    ,3,16#A5#,4,0,valid,0 ns);
                    command_seq(6)  :=(ddr_quad_IO_rd ,rd_cont    ,3,0,5,0,valid,0 ns);
                    command_seq(7)  :=(idle   ,none   ,0,0,0,0,valid,0 ns);
                    --DDR QUAD IO Continuous Read exit with mode reset command
                    command_seq(8)  :=(ddr_quad_IO_rd ,read_ddr_quad_IO    ,3,16#5A#,1,0,valid,0 ns);
                    command_seq(9)  :=(mbr     ,none   ,0,0,0,0,valid,0 ns);
                    command_seq(10)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- program non-volatile data learning register
                    command_seq(11)  :=(w_enable,none ,0,0,0,0,valid,0 ns);
                    command_seq(12)  :=(w_nvdlr,none ,1,16#34#,0,0,valid,0 ns);
                    command_seq(13)  :=(read_SR1,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(14)  :=(wt   ,none     ,0,0,0,0,valid,tPP);
                    command_seq(15)  :=(rdar,rd_wip_0 ,1,0,16#800#,0,valid,0 ns);
                    command_seq(16)  :=(rd_dlp,read_dlp ,1,0,0,0,valid,0 ns);
                    command_seq(17)  :=(idle   ,none   ,0,0,0,0,valid,0 ns);
                    -- DDR Quad I/O read with Data Learning Pattern read out
                    command_seq(18)  :=(ddr_quad_IO_rd ,read_ddr_quad_IO    ,5,0,1,0,valid,0 ns);
                    -- set read latency to 5
                    command_seq(19)  :=(w_enable,none ,0,0,0,0,valid,0 ns);
                    command_seq(20)  :=(wrar,none ,4,16#15#,16#800#,4,valid,0 ns);
                    command_seq(21)  :=(wt   ,none     ,0,0,0,0,valid,50 ns);
                    -- enter QPI mode
                    command_seq(22)  :=(w_qpien,none ,0,0,0,0,valid,0 ns);
                    command_seq(23)  :=(wt   ,none     ,0,0,0,0,valid,tQEN);
                    command_seq(24)  :=(ddr_quad_IO_rd ,read_ddr_quad_IO    ,5,0,7,1,valid,0 ns);
                    -- set 8-bit burst wrap mode
                    command_seq(25)  :=(set_bl,none ,0,16#00#,0,0,valid,0 ns);
                    command_seq(26)  :=(ddr_quad_IO_rd ,read_ddr_quad_IO    ,5,0,5,5,valid,0 ns);
                    -- disable burst wrap mode
                    command_seq(27)  :=(set_bl,none ,0,16#10#,0,0,valid,0 ns);
                    command_seq(28)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- exit QPI mode
                    command_seq(29)  :=(w_qpiex,none ,0,0,0,0,valid,0 ns);
                    command_seq(30)  :=(wt   ,none     ,0,0,0,0,valid,tQEX);
                    -- set read latency to 13
                    command_seq(31)  :=(w_enable,none ,0,0,0,0,valid,0 ns);
                    command_seq(32)  :=(wrar,none ,4,16#1d#,16#800#,4,valid,0 ns);
                    command_seq(33)  :=(wt   ,none     ,0,0,0,0,valid,50 ns);
                    command_seq(34)  :=(read_CR3,rd_CR3 ,2,0,0,0,valid,0 ns);
                    command_seq(35)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(36)  :=(done   ,none    ,0,0,0,0,valid,0 ns);

                    WHEN OTHERS => NULL;
                END CASE;

            WHEN 8  => -- Program Flash Array commands
                CASE Testcase IS
                    WHEN 1  =>
                    REPORT "Page Program and Quad Page Program, positive test";
                    -- Program 5 bytes
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(2)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(3)  :=(pg_prog,none    ,5,16#10#,0,16#10#,valid,0 ns);
                    command_seq(4)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(5)  :=(wt   ,none     ,0,0,0,0,valid,(tBP1+4*tBP2));
                    command_seq(6)  :=(read_SR1 ,rd_wip_0 ,1,0,0,0,valid,0 ns);
                    command_seq(7)  :=(fast_rd     ,read_fast    ,5,0,0,16#10#,valid,0 ns);
                    -- Program entire page
                    command_seq(8)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(9)  :=(pg_prog,none    ,260,0,10,0,valid,0 ns);
                    command_seq(10)  :=(wt   ,none     ,0,0,0,0,valid,tPP);
                    command_seq(11)  :=(fast_rd     ,read_fast    ,5,0,10,0,valid,0 ns);
                    -- Program 5 bytes in Quad Page Program mode
                    command_seq(12)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(13)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(14)  :=(qpg_prog,none    ,5,16#10#,11,0,valid,0 ns);
                    command_seq(15)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(16)  :=(wt   ,none     ,0,0,0,0,valid,(tBP1+4*tBP2));
                    command_seq(17)  :=(read_SR1 ,rd_wip_0 ,1,0,0,0,valid,0 ns);
                    command_seq(18)  :=(fast_rd     ,read_fast    ,5,0,11,0,valid,0 ns);

                    -- Page Program in QPI mode
                    -- Enter QPI mode
                    command_seq(19)  :=(w_qpien,none ,0,0,0,0,valid,0 ns);
                    command_seq(20)  :=(wt   ,none     ,0,0,0,0,valid,tQEN);
                    command_seq(21)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(22)  :=(pg_prog,none    ,5,10,0,12,valid,0 ns);
                    command_seq(23)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(24)  :=(wt   ,none     ,0,0,0,0,valid,(tBP1+4*tBP2));
                    command_seq(25)  :=(read_SR1 ,rd_wip_0 ,1,0,0,0,valid,0 ns);
                    -- Exit QPI mode
                    command_seq(26)  :=(w_qpiex,none ,0,0,0,0,valid,0 ns);
                    command_seq(27)  :=(wt   ,none     ,0,0,0,0,valid,tQEX);
                    command_seq(28)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(29)  :=(done   ,none    ,0,0,0,0,valid,0 ns);

                    WHEN 2  =>
                    REPORT "Program suspend, positive test";
                    -- Page Program command
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(2)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(3)  :=(pg_prog,none    ,5,16#10#,13,0,valid,0 ns);
                    command_seq(4)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    -- program suspend
                    command_seq(5)  :=(prg_susp ,none ,1,0,0,0,valid,0 ns);
                    command_seq(6)  :=(wt   ,none     ,0,0,0,0,valid,tEPS);
                    -- read status and configuration registers in program suspend
                    command_seq(7)  :=(read_SR2 ,rd_ps_1 ,1,0,0,0,valid,0 ns);
                    command_seq(8)  :=(read_CR1,none ,2,0,0,0,valid,0 ns);
                    -- try write enable/disable in program suspend mode
                    command_seq(9) :=(w_enable,none ,0,0,0,0,valid,0 ns);
                    command_seq(10) :=(rdar,rd_wel_1,1,0,16#800#,0,valid,0 ns);
                    command_seq(11) :=(idle   ,none  ,0,0,0,0,valid,0 ns);
                    command_seq(12) :=(w_disable,none,0,0,0,0,valid,0 ns);
                    command_seq(13) :=(rdar,rd_wel_0,1,0,16#800#,0,valid,0 ns);
                    command_seq(14) :=(idle   ,none  ,0,0,0,0,valid,0 ns);
                    -- read identification commands in prgram suspend mode
                    command_seq(15)  :=(read_JID,rd_JID ,3,0,0,0,valid,0 ns);
                    command_seq(16)  :=(read_SFDP,rd_SFDP ,3,0,0,0,valid,0 ns);
                    -- read memory array in program suspend mode
                    command_seq(17)  :=(rd     ,read    ,2,0,16#FFF#,16#FFA#,valid,0 ns);
                    command_seq(18)  :=(fast_rd     ,read_fast    ,5,0,1,0,valid,0 ns);
                    command_seq(19)  :=(dual_output_rd  ,read_dual_O    ,5,0,2,0,valid,0 ns);
                    command_seq(20)  :=(dual_IO_rd     ,read_dual_IO    ,5,0,3,0,valid,0 ns);
                    command_seq(21)  :=(quad_output_rd     ,read_quad_O    ,5,0,7,0,valid,0 ns);
                    command_seq(22)  :=(quad_IO_rd     ,read_quad_IO    ,5,0,3,0,valid,0 ns);
                    command_seq(23)  :=(ddr_quad_IO_rd ,read_ddr_quad_IO    ,5,0,5,0,valid,0 ns);
                    -- read in program suspended page
                    command_seq(24)  :=(rd     ,rd_U    ,2,0,13,0,valid,0 ns);
                    -- read DLP register in program suspend mode
                    command_seq(25)  :=(rd_dlp,read_dlp ,1,0,0,0,valid,0 ns);
                    -- set burst length
                    command_seq(26)  :=(set_bl,none ,0,16#00#,0,0,valid,0 ns);
                    command_seq(27)  :=(read_CR3,rd_CR3 ,1,0,0,0,valid,0 ns);
                    command_seq(28)  :=(set_bl,none ,0,16#10#,0,0,valid,0 ns);

                    -- Security Regions read
                    command_seq(29)  :=(secr_read,read_secr ,0,16#00#,0,0,valid,0 ns);
                    -- program resume
                    command_seq(30)  :=(prg_resume ,none ,1,0,0,0,valid,0 ns);
                    command_seq(31)  :=(wt   ,none     ,0,0,0,0,valid,(tBP1+4*tBP2));
                    command_seq(32)  :=(read_SR1 ,rd_wip_0 ,1,0,0,0,valid,0 ns);

                    command_seq(33)  :=(done   ,none    ,0,0,0,0,valid,0 ns);

                    WHEN OTHERS => NULL;
                END CASE;

            WHEN 9  => -- Erase Flash Array commands
                CASE Testcase IS
                    WHEN 1  =>
                    REPORT "Sector Erase, positive test";
                    -- Erase sector 3Fh
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(2)  :=(fast_rd     ,read_fast    ,3,0,16#3F#,0, valid,0 ns);
                    command_seq(3)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(4)  :=(sector_erase,none    ,0,0,16#3F#,0,valid,0 ns);
                    command_seq(5)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(6)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(7)  :=(wt   ,none     ,0,0,0,0,valid,tSE);
                    command_seq(8)  :=(read_SR1 ,rd_wip_0 ,1,0,0,0,valid,0 ns);
                    command_seq(9)  :=(fast_rd     ,read_fast    ,3,0,16#3F#,0, valid,0 ns);
                    command_seq(10)  :=(done   ,none    ,0,0,0,0,valid,0 ns);

                    WHEN 2  =>
                    REPORT "Half Block Erase, positive test";
                    -- Erase half block 80h
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(2)  :=(fast_rd     ,read_fast    ,3,0,16#40#,0, valid,0 ns);
                    command_seq(3)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(4)  :=(halfblock_erase,none    ,0,0,16#40#,0,valid,0 ns);
                    command_seq(5)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(6)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(7)  :=(wt   ,none     ,0,0,0,0,valid,tHBE);
                    command_seq(8)  :=(read_SR1 ,rd_wip_0 ,1,0,0,0,valid,0 ns);
                    command_seq(9)  :=(fast_rd     ,read_fast    ,3,0,16#40#,0, valid,0 ns);
                    command_seq(10) :=(done   ,none    ,0,0,0,0,valid,0 ns);

                    WHEN 3  =>
                    REPORT "Block Erase, positive test";
                    -- Erase block 80h
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(2)  :=(fast_rd     ,read_fast    ,3,0,16#80#,0, valid,0 ns);
                    command_seq(3)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(4)  :=(block_erase,none    ,0,0,16#80#,0,valid,0 ns);
                    command_seq(5)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(6)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(7)  :=(wt   ,none     ,0,0,0,0,valid,tBE);
                    command_seq(8)  :=(read_SR1 ,rd_wip_0 ,1,0,0,0,valid,0 ns);
                    command_seq(9)  :=(fast_rd     ,read_fast    ,3,0,16#80#,0, valid,0 ns);
                    -- Block Erase in QPI mode
                    -- Enter QPI mode
                    command_seq(10)  :=(w_qpien,none ,0,0,0,0,valid,0 ns);
                    command_seq(11)  :=(wt   ,none     ,0,0,0,0,valid,tQEN);
                    command_seq(12)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(13)  :=(block_erase,none    ,0,0,16#C0#,0,valid,0 ns);
                    command_seq(14)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(15)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(16)  :=(wt   ,none     ,0,0,0,0,valid,tBE);
                    command_seq(17)  :=(read_SR1 ,rd_wip_0 ,1,0,0,0,valid,0 ns);
                    -- Exit QPI mode
                    command_seq(18)  :=(w_qpiex,none ,0,0,0,0,valid,0 ns);
                    command_seq(19)  :=(wt   ,none     ,0,0,0,0,valid,tQEX);
                    command_seq(20)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(21)  :=(fast_rd     ,read_fast    ,3,0,16#C0#,0, valid,0 ns);
                    command_seq(22) :=(done   ,none    ,0,0,0,0,valid,0 ns);

                    WHEN 4  =>
                    REPORT "Sector Erase suspend, positive test";
                    -- Erase sector 4
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(2)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(3)  :=(sector_erase,none    ,0,0,16#4#,0,valid,0 ns);
                    command_seq(4)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(5)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                     -- erase suspend
                    command_seq(6)  :=(ers_susp ,none ,1,0,0,0,valid,0 ns);
                    command_seq(7)  :=(wt   ,none     ,0,0,0,0,valid,tEPS);
                    -- read status and configuration registers in program suspend
                    command_seq(8)  :=(read_SR2 ,rd_es_1 ,1,0,0,0,valid,0 ns);
                    command_seq(9)  :=(read_CR1,none ,2,0,0,0,valid,0 ns);
                    -- try write enable/disable in erase suspend mode
                    command_seq(10) :=(w_enable,none ,0,0,0,0,valid,0 ns);
                    command_seq(11) :=(rdar,rd_wel_1,1,0,16#800#,0,valid,0 ns);
                    command_seq(12) :=(idle   ,none  ,0,0,0,0,valid,0 ns);
                    command_seq(13) :=(w_disable,none,0,0,0,0,valid,0 ns);
                    command_seq(14) :=(rdar,rd_wel_0,1,0,16#800#,0,valid,0 ns);
                    command_seq(15) :=(idle   ,none  ,0,0,0,0,valid,0 ns);
                    -- read identification commands in erase suspend mode
                    command_seq(16)  :=(read_JID,rd_JID ,3,0,0,0,valid,0 ns);
                    command_seq(17)  :=(read_SFDP,rd_SFDP ,3,0,0,0,valid,0 ns);
                    -- read memory array in erase suspend mode
                    command_seq(18)  :=(rd     ,read    ,2,0,16#FFF#,16#FFA#,valid,0 ns);
                    command_seq(19)  :=(fast_rd     ,read_fast    ,5,0,1,0,valid,0 ns);
                    command_seq(20)  :=(dual_output_rd  ,read_dual_O    ,5,0,2,0,valid,0 ns);
                    command_seq(21)  :=(dual_IO_rd     ,read_dual_IO    ,5,0,3,0,valid,0 ns);
                    command_seq(22)  :=(quad_output_rd     ,read_quad_O    ,5,0,7,0,valid,0 ns);
                    command_seq(23)  :=(quad_IO_rd     ,read_quad_IO    ,5,0,3,0,valid,0 ns);
                    command_seq(24)  :=(ddr_quad_IO_rd ,read_ddr_quad_IO    ,5,0,5,0,valid,0 ns);
                    -- read in erase suspended sector
                    command_seq(25)  :=(rd     ,rd_U    ,2,0,4,0,valid,0 ns);
                    -- read DLP register in erase suspend mode
                    command_seq(26)  :=(rd_dlp,read_dlp ,1,0,0,0,valid,0 ns);
                    -- set burst length
                    command_seq(27)  :=(set_bl,none ,0,16#00#,0,0,valid,0 ns);
                    command_seq(28)  :=(read_CR3,rd_CR3 ,1,0,0,0,valid,0 ns);
                    command_seq(29)  :=(set_bl,none ,0,16#10#,0,0,valid,0 ns);

                    --page program in erase suspend mode
                    command_seq(30)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(31)  :=(pg_prog,none    ,5,16#20#,0,16#20#,valid,0 ns);
                    command_seq(32)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(33)  :=(wt   ,none     ,0,0,0,0,valid,(tBP1+4*tBP2));
                    command_seq(34)  :=(read_SR1 ,rd_wip_0 ,1,0,0,0,valid,0 ns);
                    command_seq(35)  :=(fast_rd     ,read_fast    ,5,0,0,16#20#,valid,0 ns);

                    --Quad Page Program in erase suspend mode
                    command_seq(36)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(37)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(38)  :=(qpg_prog,none    ,5,0,15,0,valid,0 ns);
                    command_seq(39)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(40)  :=(wt   ,none     ,0,0,0,0,valid,(tBP1+4*tBP2));
                    command_seq(41)  :=(read_SR1 ,rd_wip_0 ,1,0,0,0,valid,0 ns);
                    command_seq(42)  :=(fast_rd     ,read_fast    ,5,0,15,0,valid,0 ns);

                    --Security Regions program in erase suspend
                    command_seq(43)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(44)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(45)  :=(secr_prog,none    ,5,8,0,8,valid,0 ns);
                    command_seq(46)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(47)  :=(wt   ,none     ,0,0,0,0,valid,(tBP1+4*tBP2));
                    command_seq(48)  :=(read_SR1 ,rd_wip_0 ,1,0,0,0,valid,0 ns);
                    command_seq(49)  :=(secr_read     ,read_secr    ,5,0,0,8,valid,0 ns);
                    -- Sector erase resume
                    command_seq(50)  :=(prg_resume ,none ,1,0,0,0,valid,0 ns);
                    command_seq(51)  :=(wt   ,none     ,0,0,0,0,valid,tSE);
                    command_seq(52)  :=(read_SR1 ,rd_wip_0 ,1,0,0,0,valid,0 ns);
                    command_seq(53)  :=(fast_rd     ,read_fast    ,3,0,16#4#,0, valid,0 ns);
                    command_seq(54)  :=(done   ,none    ,0,0,0,0,valid,0 ns);

                    WHEN 5  =>
                    REPORT "Half Block Erase suspend, positive test";
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(2)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(3)  :=(halfblock_erase,none    ,0,0,7,0,valid,0 ns);
                    command_seq(4)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(5)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                     -- erase suspend
                    command_seq(6)  :=(ers_susp ,none ,1,0,0,0,valid,0 ns);
                    command_seq(7)  :=(wt   ,none     ,0,0,0,0,valid,tEPS);
                    -- read status and configuration registers in erase suspend
                    command_seq(8)  :=(read_SR2 ,rd_es_1 ,1,0,0,0,valid,0 ns);
                    command_seq(9)  :=(read_CR1,none ,2,0,0,0,valid,0 ns);
                    command_seq(10) :=(prg_resume ,none ,1,0,0,0,valid,0 ns);
                    command_seq(11)  :=(read_SR2 ,rd_es_0 ,1,0,0,0,valid,0 ns);
                    command_seq(12) :=(wt   ,none     ,0,0,0,0,valid,tHBE);
                    command_seq(13) :=(read_SR1 ,rd_wip_0 ,1,0,0,0,valid,0 ns);
                    command_seq(14) :=(done   ,none    ,0,0,0,0,valid,0 ns);

                    WHEN 6  =>
                    REPORT "Block Erase suspend, positive test";
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(2)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(3)  :=(block_erase,none    ,0,0,8,0,valid,0 ns);
                    command_seq(4)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(5)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                     -- erase suspend
                    command_seq(6)  :=(ers_susp ,none ,1,0,0,0,valid,0 ns);
                    command_seq(7)  :=(wt   ,none     ,0,0,0,0,valid,tEPS);
                    -- read status and configuration registers in erase suspend
                    command_seq(8)  :=(read_SR2 ,rd_es_1 ,1,0,0,0,valid,0 ns);
                    command_seq(9)  :=(read_CR1,none ,2,0,0,0,valid,0 ns);
                    command_seq(10) :=(prg_resume ,none ,1,0,0,0,valid,0 ns);
                    command_seq(11)  :=(read_SR2 ,rd_es_0 ,1,0,0,0,valid,0 ns);
                    command_seq(12) :=(wt   ,none     ,0,0,0,0,valid,tBE);
                    command_seq(13) :=(read_SR1 ,rd_wip_0 ,1,0,0,0,valid,0 ns);
                    command_seq(14) :=(done   ,none    ,0,0,0,0,valid,0 ns);

                    WHEN 7  =>
                    REPORT "Chip Erase, positive test";
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(2)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(3)  :=(chip_erase,none    ,0,0,8,0,valid,0 ns);
                    command_seq(4)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(5)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(6)  :=(wt   ,none     ,0,0,0,0,valid,tCE);
                    command_seq(7)  :=(read_SR1 ,rd_wip_0 ,1,0,0,0,valid,0 ns);
                    command_seq(8)  :=(fast_rd     ,read_fast    ,3,0,0,0, valid,0 ns);
                    command_seq(9)  :=(done   ,none    ,0,0,0,0,valid,0 ns);

                    WHEN OTHERS => NULL;
                END CASE;

            WHEN 10  => -- Security Regions Array commands
                CASE Testcase IS
                    WHEN 1  =>
                    REPORT "Security Regions read, program and erase, positive test";
                    -- Security Regions read
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(2)  :=(secr_read     ,read_secr    ,5,0,0,0,valid,0 ns);
                    command_seq(3)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    --Security Regions program
                    command_seq(4)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(5)  :=(secr_prog,none    ,5,5,0,16#50#,valid,0 ns);
                    command_seq(6)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(7)  :=(rdar ,rd_wip_1 ,1,0,16#800#,0,valid,0 ns);
                    command_seq(8)  :=(wt   ,none     ,0,0,0,0,valid,(tBP1+4*tBP2));
                    command_seq(9)  :=(read_SR1 ,rd_wip_0 ,1,0,0,0,valid,0 ns);
                    command_seq(10)  :=(secr_read     ,read_secr    ,5,0,0,16#50#,valid,0 ns);
                    command_seq(11)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    --QPI mode enter
                    command_seq(12)  :=(w_qpien,none ,0,0,0,0,valid,0 ns);
                    command_seq(13)  :=(wt   ,none     ,0,0,0,0,valid,tQEN);
                    command_seq(14)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(15)  :=(secr_prog,none    ,5,10,0,16#55#,valid,0 ns);
                    command_seq(16)  :=(wt   ,none     ,0,0,0,0,valid,(tBP1+4*tBP2));
                    command_seq(17)  :=(secr_read     ,read_secr    ,5,0,0,16#55#,valid,0 ns);
                    command_seq(18)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- QPI mode exit
                    command_seq(19)  :=(w_qpiex,none ,0,0,0,0,valid,0 ns);
                    command_seq(20)  :=(wt   ,none     ,0,0,0,0,valid,tQEX);
                    --Security Regions erase
                    command_seq(21)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(22)  :=(secr_erase,none    ,0,0,0,16#100#,valid,0 ns);
                    command_seq(23)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(24)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(25)  :=(rdar ,rd_wip_1 ,1,0,16#800#,0,valid,0 ns);
                    command_seq(26)  :=(wt   ,none     ,0,0,0,0,valid,tSE);
                    command_seq(27)  :=(read_SR1 ,rd_wip_0 ,1,0,0,0,valid,0 ns);
                    command_seq(28)  :=(secr_read     ,read_secr    ,3,0,0,16#100#, valid,0 ns);
                    --QPI mode enter
                    command_seq(29)  :=(w_qpien,none ,0,0,0,0,valid,0 ns);
                    command_seq(30)  :=(wt   ,none     ,0,0,0,0,valid,tQEN);
                    command_seq(31)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(32)  :=(secr_erase,none    ,0,0,0,16#100#,valid,0 ns);
                    command_seq(33)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(34)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(35)  :=(wt   ,none     ,0,0,0,0,valid,tSE);
                    command_seq(36)  :=(secr_read     ,read_secr    ,3,0,0,16#100#, valid,0 ns);
                    -- QPI mode exit
                    command_seq(37)  :=(w_qpiex,none ,0,0,0,0,valid,0 ns);
                    command_seq(38)  :=(wt   ,none     ,0,0,0,0,valid,tQEX);
                    command_seq(39)  :=(done   ,none    ,0,0,0,0,valid,0 ns);

                    WHEN 2  =>
                    REPORT "Security Region permanent write protect, lock by BP bits, positive test";
                    --Set BP0=1 to permanent lock security region 0
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(2)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(3)  :=(wrar,none,1,16#04#,16#000#,2,valid,0 ns);
                    command_seq(4)  :=(idle   ,none     ,0,0,0,0,valid,0 ns);
                    command_seq(5)  :=(wt   ,none     ,0,0,0,0,valid,tW);
                    command_seq(6)  :=(read_CR1 ,rd_CR1 ,1,0,0,0,valid,0 ns);
                    -- Try programming in the locked sequrity region
                    command_seq(7)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(8)  :=(secr_prog,err    ,5,7,0,16#70#,valid,0 ns);
                    command_seq(9)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(10)  :=(read_SR2 ,pgm_nosucc ,1,0,0,0,valid,0 ns);
                    command_seq(11)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(12)  :=(clr_sr ,none ,1,0,0,0,valid,0 ns);
                    command_seq(13)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(14)  :=(secr_read     ,read_secr    ,5,0,0,16#70#,valid,0 ns);
                    command_seq(15)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- Try erase of the locked sequrity region
                    command_seq(16)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(17)  :=(secr_erase,err    ,5,0,0,0,valid,0 ns);
                    command_seq(18)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(19)  :=(read_SR2 ,erase_nosucc ,1,0,0,0,valid,0 ns);
                    command_seq(20)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(21)  :=(clr_sr ,none ,1,0,0,0,valid,0 ns);
                    command_seq(22)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(23)  :=(secr_read     ,read_secr    ,5,0,0,16#00#,valid,0 ns);
                    command_seq(24)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(25)  :=(done   ,none    ,0,0,0,0,valid,0 ns);

                    WHEN OTHERS => NULL;
                END CASE;

            WHEN 11  => -- Individual Block Lock commands
                CASE Testcase IS
                    WHEN 1  =>
                    REPORT "IBL read, positive test";
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(2)  :=(ibl_rd     ,read_ibl_0    ,1,0,0,0,valid,0 ns);
                    command_seq(3)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    --QPI mode
                    command_seq(4)  :=(w_qpien,none ,0,0,0,0,valid,0 ns);
                    command_seq(5)  :=(wt   ,none     ,0,0,0,0,valid,tQEN);
                    command_seq(6)  :=(ibl_rd     ,read_ibl_0    ,1,0,5,0,valid,0 ns);
                    command_seq(7)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(8)  :=(w_qpiex,none ,0,0,0,0,valid,0 ns);
                    command_seq(9)  :=(wt   ,none     ,0,0,0,0,valid,tQEX);
                    command_seq(10)  :=(done   ,none    ,0,0,0,0,valid,0 ns);

                    WHEN 2  =>
                    REPORT "IBL Lock/Unlock, Global IBL Lock/Unlock, positive test";
                    -- IBL Unlock
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- select Individual Block Lock, WPS=1
                    command_seq(2)  :=(w_enable   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(3)  :=(wrar   ,none    ,0,16#64#,16#800#,3,valid,0 ns);
                    command_seq(4)  :=(wt   ,none     ,0,0,0,0,valid,50 ns);

                    command_seq(5)  :=(w_ibul     ,none    ,1,0,0,0,valid,0 ns);
                    command_seq(6)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(7)  :=(ibl_rd     ,read_ibl_1    ,1,0,0,0,valid,0 ns);
                    -- IBL Lock
                    command_seq(8)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(9)  :=(w_ibl     ,none    ,1,0,0,0,valid,0 ns);
                    command_seq(10)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(11)  :=(ibl_rd     ,read_ibl_0    ,1,0,0,0,valid,0 ns);
                    -- Global IBL Unlock
                    command_seq(12)   :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(13)  :=(w_gbul     ,none    ,1,0,0,0,valid,0 ns);
                    command_seq(14)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(15)  :=(ibl_rd     ,read_ibl_1    ,1,0,0,0,valid,0 ns);
                    -- Global IBL Lock
                    command_seq(16)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(17)  :=(w_gbl     ,none    ,1,0,0,0,valid,0 ns);
                    command_seq(18)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(19)  :=(ibl_rd     ,read_ibl_0    ,1,0,0,0,valid,0 ns);
                    command_seq(20)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);

                    --QPI mode
                    command_seq(21)  :=(w_qpien,none ,0,0,0,0,valid,0 ns);
                    command_seq(22)  :=(wt   ,none     ,0,0,0,0,valid,tQEN);
                    -- IBL Unlock
                    command_seq(23)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(24)  :=(w_ibul     ,none    ,1,0,3,0,valid,0 ns);
                    command_seq(25)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(26)  :=(ibl_rd     ,read_ibl_1    ,1,0,3,0,valid,0 ns);
                    -- IBL Lock
                    command_seq(27)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(28)  :=(w_ibl     ,none    ,1,0,3,0,valid,0 ns);
                    command_seq(29)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(30)  :=(ibl_rd     ,read_ibl_0    ,1,0,0,0,valid,0 ns);
                    -- Global IBL Unlock
                    command_seq(31)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(32)  :=(w_gbul     ,none    ,1,0,0,0,valid,0 ns);
                    command_seq(33)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(34)  :=(ibl_rd     ,read_ibl_1    ,1,0,0,0,valid,0 ns);
                    -- Global IBL Lock
                    command_seq(35)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(36)  :=(w_gbl     ,none    ,1,0,0,0,valid,0 ns);
                    command_seq(37)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(38)  :=(ibl_rd     ,read_ibl_0    ,1,0,0,0,valid,0 ns);
                    command_seq(39)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);

                    command_seq(40)  :=(w_qpiex,none ,0,0,0,0,valid,0 ns);
                    command_seq(41)  :=(wt   ,none     ,0,0,0,0,valid,tQEX);
                    command_seq(42)  :=(done   ,none    ,0,0,0,0,valid,0 ns);

                    WHEN OTHERS => NULL;
                END CASE;

            WHEN 12  => -- Pointer Region Protect
                CASE Testcase IS
                    WHEN 1  =>
                    REPORT "Set Pointer Region Protect command, positive test";
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(2)  :=(w_enable   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(3)  :=(w_sprp     ,none    ,0,0,0,16#000000#,valid,0 ns);
                    command_seq(4)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(5)  :=(read_SR1   ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(6)  :=(rdar       ,rd_wip_1 ,1,0,16#800#,0,valid,0 ns);
                    command_seq(7)  :=(wt         ,none     ,0,0,0,0,valid,tW);
                    command_seq(8)  :=(read_SR1   ,rd_wip_0 ,1,0,0,0,valid,0 ns);
                    -- Read Any Register from addresses 39h, 3Ah and 3Bh gives PRPR[15:8], PRPR[23:16], PRPR[31:24]
                    command_seq(9)  :=(rdar       ,read_rdar ,1,0,0,16#39#,valid,0 ns);
                    command_seq(10) :=(rdar       ,read_rdar ,1,0,0,16#3A#,valid,0 ns);
                    command_seq(11) :=(rdar       ,read_rdar ,1,0,0,16#3B#,valid,0 ns);
                    -- Write Any Register command to addresses 39h, 3Ah and 3Bh sets PRPR[15:8], PRPR[23:16], PRPR[31:24]
                    command_seq(12)  :=(w_enable   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(13)  :=(wrar       ,none ,1,16#02#,0,16#39#,valid,0 ns);
                    command_seq(14)  :=(wt         ,none     ,0,0,0,0,valid,tW);
                    command_seq(15)  :=(rdar       ,read_rdar ,1,0,0,16#39#,valid,0 ns);
                    command_seq(16)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(17) :=(done   ,none    ,0,0,0,0,valid,0 ns);

                    WHEN OTHERS => NULL;
                END CASE;

            WHEN 13  => -- Password Register read and program commands
                CASE Testcase IS
                    WHEN 1  =>
                    REPORT "Password program and password read, positive test";
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(2)  :=(w_enable   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(3)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(4)  :=(w_password   ,none    ,0,16#B3A3#,0,0,valid,0 ns);
                    command_seq(5)  :=(w_password   ,none    ,0,16#D3C3#,0,0,valid,1 ns);
                    command_seq(6)  :=(w_password   ,none    ,0,16#F3E3#,0,0,valid,2 ns);
                    command_seq(7)  :=(w_password   ,none    ,0,16#1303#,0,0,valid,3 ns);
                    command_seq(8)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(9)  :=(wt   ,none     ,0,0,0,0,valid, (tBP1 + 7*tBP2));
                    command_seq(10)  :=(read_SR1 ,rd_wip_0 ,1,0,0,0,valid,0 ns);
                    command_seq(11)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(12)  :=(pass_reg_rd ,read_pass_reg ,1,0,0,0,valid,0 ns);

                    -- Write Any REgister to Password register
                    command_seq(13)  :=(w_enable   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(14)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(15)  :=(wrar ,none   ,0,16#A1#,0,16#20#,valid,0 ns);
                    command_seq(16)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(17)  :=(wt   ,none   ,0,0,0,0,valid,tW);
                    command_seq(18)  :=(rdar ,read_rdar   ,1,0,0,16#20#,valid,0 ns);
                    command_seq(19)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);

                    command_seq(20)  :=(w_enable   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(21)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(22)  :=(wrar ,none   ,0,16#B1#,0,16#21#,valid,0 ns);
                    command_seq(23)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(24)  :=(wt   ,none   ,0,0,0,0,valid,tW);
                    command_seq(25)  :=(rdar ,read_rdar   ,1,0,0,16#21#,valid,0 ns);
                    command_seq(26)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);

                    command_seq(27)  :=(w_enable   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(28)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(29)  :=(wrar ,none   ,0,16#C1#,0,16#22#,valid,0 ns);
                    command_seq(30)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(31)  :=(wt   ,none   ,0,0,0,0,valid,tW);
                    command_seq(32)  :=(rdar ,read_rdar   ,1,0,0,16#22#,valid,0 ns);
                    command_seq(33)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);

                    command_seq(34)  :=(w_enable   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(35)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(36)  :=(wrar ,none   ,0,16#D1#,0,16#23#,valid,0 ns);
                    command_seq(37)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(38)  :=(wt   ,none   ,0,0,0,0,valid,tW);
                    command_seq(39)  :=(rdar ,read_rdar   ,1,0,0,16#23#,valid,0 ns);
                    command_seq(40)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);

                    command_seq(41)  :=(w_enable   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(42)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(43)  :=(wrar ,none   ,0,16#E1#,0,16#24#,valid,0 ns);
                    command_seq(44)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(45)  :=(wt   ,none   ,0,0,0,0,valid,tW);
                    command_seq(46)  :=(rdar ,read_rdar   ,1,0,0,16#24#,valid,0 ns);
                    command_seq(47)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);

                    command_seq(48)  :=(w_enable   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(49)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(50)  :=(wrar ,none   ,0,16#F1#,0,16#25#,valid,0 ns);
                    command_seq(51)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(52)  :=(wt   ,none   ,0,0,0,0,valid,tW);
                    command_seq(53)  :=(rdar ,read_rdar   ,1,0,0,16#25#,valid,0 ns);
                    command_seq(54)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);

                    command_seq(55)  :=(w_enable   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(56)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(57)  :=(wrar ,none   ,0,16#01#,0,16#26#,valid,0 ns);
                    command_seq(58)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(59)  :=(wt   ,none   ,0,0,0,0,valid,tW);
                    command_seq(60)  :=(rdar ,read_rdar   ,1,0,0,16#26#,valid,0 ns);
                    command_seq(61)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);

                    command_seq(62)  :=(w_enable   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(63)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(64)  :=(wrar ,none   ,0,16#11#,0,16#27#,valid,0 ns);
                    command_seq(65)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(66)  :=(wt   ,none   ,0,0,0,0,valid,tW);
                    command_seq(67)  :=(rdar ,read_rdar   ,1,0,0,16#27#,valid,0 ns);
                    command_seq(68)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    --QPI mode enter
                    command_seq(69)  :=(w_qpien,none ,0,0,0,0,valid,0 ns);
                    command_seq(70)  :=(wt   ,none     ,0,0,0,0,valid,tQEN);
                    command_seq(71)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(72)  :=(w_enable   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(73)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(74)  :=(w_password   ,none    ,0,16#B0A0#,0,0,valid,0 ns);
                    command_seq(75)  :=(w_password   ,none    ,0,16#D0C0#,0,0,valid,1 ns);
                    command_seq(76)  :=(w_password   ,none    ,0,16#F0E0#,0,0,valid,2 ns);
                    command_seq(77)  :=(w_password   ,none    ,0,16#1000#,0,0,valid,3 ns);
                    command_seq(78)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(79)  :=(wt   ,none     ,0,0,0,0,valid, (tBP1 + 7*tBP2));
                    command_seq(80)  :=(read_SR1 ,rd_wip_0 ,1,0,0,0,valid,0 ns);
                    command_seq(81)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(82)  :=(pass_reg_rd ,none ,8,0,0,0,valid,0 ns);
                    command_seq(83)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    --QPI mode exit
                    command_seq(84)  :=(w_qpiex,none ,0,0,0,0,valid,0 ns);
                    command_seq(85)  :=(wt   ,none     ,0,0,0,0,valid,tQEX);
                    command_seq(86)  :=(read_SR1 ,rd_wip_0 ,1,0,0,0,valid,0 ns);
                    command_seq(87)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(88)  :=(done   ,none    ,0,0,0,0,valid,0 ns);

                    WHEN OTHERS => NULL;
                END CASE;

            WHEN 14  => -- Individual and Region Protection commands
                CASE Testcase IS
                    WHEN 1  =>
                    REPORT "Individual and Region Protection register read and program commands, positive test";
                    -- IRP read
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(2)  :=(irp_reg_rd   ,read_irp    ,1,0,0,0,valid,0 ns);
                    command_seq(3)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- IRP program
                    -- try to program IBLLBB bit , IRP[4]=0    (IRP[2:0] = "101")
                    command_seq(4)  :=(w_enable   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(5)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(6)  :=(w_irpp   ,err    ,2,16#ED#,0,0,valid,0 ns);
                    command_seq(7)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(8)  :=(read_SR1   ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(9)  :=(rdar       ,rd_wip_1 ,1,0,16#800#,0,valid,0 ns);
                    command_seq(10)  :=(read_SR2   ,pgm_nosucc ,1,0,0,0,valid,0 ns);
                    command_seq(11)  :=(clr_sr         ,none     ,0,0,0,0,valid,0 ns);
                    command_seq(12)  :=(read_SR1   ,rd_wip_0 ,1,0,0,0,valid,0 ns);
                    command_seq(13)  :=(irp_reg_rd   ,read_irp    ,1,0,0,0,valid,0 ns);
                    command_seq(14)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    --QPI mode
                    command_seq(15)  :=(w_qpien,none ,0,0,0,0,valid,0 ns);
                    command_seq(16)  :=(wt   ,none     ,0,0,0,0,valid,tQEN);
                    command_seq(17)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(18)  :=(irp_reg_rd   ,read_irp    ,1,0,0,0,valid,0 ns);
                    command_seq(19)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- IRP program
                    -- try to program IBLLBB bit, IRP[4]=0    (IRP[2:0] = "101"]
                    command_seq(20)  :=(w_enable   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(21)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(22)  :=(w_irpp   ,err    ,2,16#ED#,0,0,valid,0 ns);
                    command_seq(23)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(24)  :=(read_SR1   ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(25)  :=(rdar       ,rd_wip_1 ,1,0,16#800#,0,valid,0 ns);
                    command_seq(26)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(27)  :=(clr_sr         ,none     ,0,0,0,0,valid,0 ns);
                    command_seq(28)  :=(read_SR1   ,rd_wip_0 ,1,0,0,0,valid,0 ns);
                    command_seq(29)  :=(irp_reg_rd   ,read_irp    ,1,0,0,0,valid,0 ns);
                    command_seq(30)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    --QPI exit
                    command_seq(31)  :=(w_qpiex,none ,0,0,0,0,valid,0 ns);
                    command_seq(32)  :=(wt   ,none     ,0,0,0,0,valid,tQEX);
                    command_seq(33)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- WRAR, Addr 16#39#
                    command_seq(34)  :=(w_enable   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(35)  :=(wrar   ,none    ,0,16#ED#,0,16#30#,valid,0 ns);
                    command_seq(36)  :=(wt   ,none     ,0,0,0,0,valid,100 ns);
                    command_seq(37)  :=(clr_sr         ,none     ,0,0,0,0,valid,0 ns);
                    command_seq(38)  :=(rdar   ,none    ,1,0,0,16#30#,valid,0 ns);

                    command_seq(39)  :=(done   ,none    ,0,0,0,0,valid,0 ns);
                    WHEN OTHERS => NULL;
                END CASE;

            WHEN 15  => -- Protection Register read and lock commands
                CASE Testcase IS
                    WHEN 1  =>
                    REPORT "Protection Register read and lock commands, positive test";
                    -- PR read
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(2)  :=(pr_rd   ,read_pr    ,1,0,0,0,valid,0 ns);
                    command_seq(3)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- PR lock
                    command_seq(4)  :=(w_enable   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(5)  :=(w_pr   ,none    ,1,0,0,0,valid,0 ns);
                    command_seq(6)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- PR read
                    command_seq(7)  :=(pr_rd   ,read_pr    ,1,0,0,0,valid,0 ns);
                    command_seq(8)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- Enable IO3_RESETNeg to use as RESET# input
                    command_seq(9)  :=(wrar       ,none ,1,16#E4#,16#800#,3,valid,0 ns);
                    command_seq(10)  :=(wt   ,none     ,0,0,0,0,valid,100 ns);
                    -- reset NVLOCK
                    -- in standard protection mode (IRP(1)='0') HW reset resets PR(0)='1'
                    command_seq(11)  :=(h_reset_io3,none ,0,0,0,0,valid,201 ns);
                    command_seq(12)  :=(wt   ,none     ,0,0,0,0,valid,tRPH+100 ns);
                    command_seq(13)  :=(pr_rd   ,read_pr    ,1,0,0,0,valid,0 ns);
                    -- set read latency to 9
                    command_seq(14)  :=(w_enable   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(15)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(16)  :=(wrar ,none   ,0,16#79#,16#800#,4,valid,0 ns);
                    command_seq(17)  :=(wt   ,none   ,0,0,0,0,valid,100 ns);

                    --QPI mode
                    command_seq(18)  :=(w_qpien,none ,0,0,0,0,valid,0 ns);
                    command_seq(19)  :=(wt   ,none     ,0,0,0,0,valid,tQEN);
                    -- PR lock
                    command_seq(20)  :=(w_enable   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(21)  :=(w_pr   ,none    ,1,0,0,0,valid,0 ns);
                    command_seq(22)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(23)  :=(pr_rd   ,read_pr    ,1,0,0,0,valid,0 ns);
                    command_seq(24)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    --QPI exit
                    command_seq(25)  :=(w_qpiex,none ,0,0,0,0,valid,0 ns);
                    command_seq(26)  :=(wt   ,none     ,0,0,0,0,valid,tQEX);
                    command_seq(27)  :=(rdar   ,none     ,1,0,16#800#,16#40#,valid,tQEX);
                    command_seq(28)  :=(done   ,none    ,0,0,0,0,valid,0 ns);

                    WHEN 2  =>
                    REPORT "Security Region temporar write protect, lock by NVLOCK (PR(0)=0), positive test";
                    --PR(0)=0, security regions 2 and 3 are temporary locked
                    -- Try programming in temporary locked sequrity region 3
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(2)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(3)  :=(secr_prog,err    ,5,7,0,16#305#,valid,0 ns);
                    command_seq(4)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(5)  :=(read_SR2 ,pgm_nosucc ,1,0,0,0,valid,0 ns);
                    command_seq(6)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(7)  :=(clr_sr ,none ,1,0,0,0,valid,0 ns);
                    command_seq(8)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(9)  :=(secr_read     ,read_secr    ,5,0,0,16#305#,valid,0 ns);
                    command_seq(10)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- Try erase of temporary locked sequrity region 3
                    command_seq(11)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(12)  :=(secr_erase,err    ,5,0,0,16#305#,valid,0 ns);
                    command_seq(13)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(14)  :=(read_SR2 ,erase_nosucc ,1,0,0,0,valid,0 ns);
                    command_seq(15)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(16)  :=(clr_sr ,none ,1,0,0,0,valid,0 ns);
                    command_seq(17)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(18)  :=(secr_read     ,read_secr    ,5,0,0,16#305#,valid,0 ns);
                    command_seq(19)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(20)  :=(done   ,none    ,0,0,0,0,valid,0 ns);

                    WHEN 3  =>
                    REPORT "SPR protect by NVLOCK (PR(0)=0), positive test";
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(2)  :=(w_enable   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(3)  :=(w_sprp     ,err    ,0,0,0,16#FF0000#,valid,0 ns);
                    command_seq(4)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(5)  :=(read_SR1   ,rd_wip_0 ,1,0,0,0,valid,0 ns);
                    command_seq(6)  :=(rdar       ,rd_wip_0 ,1,0,16#800#,0,valid,0 ns);
                    -- Read Any Register from addresses 39h, gives PRPR[15:8]
                    command_seq(7)  :=(rdar       ,none ,1,0,0,16#39#,valid,0 ns);
                    command_seq(8)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);

                    command_seq(9)  :=(h_reset,none ,0,0,0,0,valid,201 ns);
                    command_seq(10)  :=(wt   ,none     ,0,0,0,0,valid,tRPH+100 ns);
                    -- set read latency to 9
                    command_seq(11)  :=(w_enable   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(12)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(13)  :=(wrar ,none   ,0,16#79#,16#800#,4,valid,0 ns);
                    command_seq(14)  :=(wt   ,none   ,0,0,0,0,valid,100 ns);
                    command_seq(15)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(16) :=(done   ,none    ,0,0,0,0,valid,0 ns);

                    WHEN OTHERS => NULL;
                END CASE;

            WHEN 16  => -- Array write protection
                CASE Testcase IS
                    WHEN 1  =>
                    REPORT "Array protection, positive test";
                    REPORT "Legacy Block protection or Pointer Region Protection, positive test";
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- WPS=0 : Legacy Block Protection is selected (LBP)
                    -- PRPR[10]=0 : Pointer Region Protection is enabled (PRP)
                    -- Array protection = LBP or PRP
                    command_seq(2)  :=(w_enable,none ,0,0,0,0,valid,0 ns);
                    command_seq(3)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- SR1_NV
                    -- write BP_NV0=1, TBPROT=1 : protect bottom (1/64)*SecNum = 64 sec
                    command_seq(4)  :=(w_wrr,none ,1,16#4C#,0,0,valid,0 ns);
                    command_seq(5)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(6)  :=(wt   ,none     ,0,0,0,0,valid,50 ns);
                    command_seq(7)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(8)  :=(wt   ,none     ,0,0,0,0,valid,tW);
                    command_seq(9)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(10)  :=(read_SR1,rd_wip_0 ,1,0,0,0,valid,0 ns);
                    -- try programming in protected area
                    command_seq(11)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(12)  :=(pg_prog,err    ,3,0,0,0,valid,0 ns);
                    command_seq(13)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(14)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(15)  :=(read_SR1 ,pgm_nosucc ,1,0,0,0,valid,0 ns);
                    command_seq(16)  :=(clr_sr ,none ,1,0,0,0,valid,0 ns);
                    command_seq(17)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(18)  :=(fast_rd     ,read_fast    ,3,0,0,0,valid,0 ns);
                    -- SPRP
                    -- PRPR[23:12]=128 : selected sector
                    -- PRPR[9]=1 : top downto selected sectors are unprotected
                    -- [127:0] protected,   [SecNum:128] unprotected
                    command_seq(19)  :=(w_enable   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(20)  :=(w_sprp     ,none    ,0,0,0,16#080200#,valid,0 ns);
                    command_seq(21)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(22)  :=(read_SR1   ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(23)  :=(wt         ,none     ,0,0,0,0,valid,tW);
                    command_seq(24)  :=(read_SR1   ,rd_wip_0 ,1,0,0,0,valid,0 ns);
                    -- try programming in protected area, programming fail
                    command_seq(25)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(26)  :=(pg_prog,err    ,3,0,127,0,valid,0 ns);
                    command_seq(27)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(28)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(29)  :=(read_SR2 ,pgm_nosucc ,1,0,0,0,valid,0 ns);
                    command_seq(30)  :=(clr_sr ,none ,1,0,0,0,valid,0 ns);
                    command_seq(31)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- try sector erase in protected area, erasing fail
                    command_seq(32)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(33)  :=(sector_erase,err    ,0,0,127,0,valid,0 ns);
                    command_seq(34)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(35)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(36)  :=(read_SR2 ,erase_nosucc ,1,0,0,0,valid,0 ns);
                    command_seq(37)  :=(clr_sr ,none ,1,0,0,0,valid,0 ns);
                    command_seq(38)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- SPRP
                    -- PRPR[23:12]=128 : selected sector
                    -- PRPR[9]=0 : bottom up to selected sectors are unprotected
                    -- [128:0] unprotected,   [SecNum:129] protected
                    command_seq(39)  :=(w_enable   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(40)  :=(w_sprp     ,none    ,0,0,0,16#080000#,valid,0 ns);
                    command_seq(41)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(42)  :=(read_SR1   ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(43)  :=(wt         ,none     ,0,0,0,0,valid,tW);
                    command_seq(44)  :=(read_SR1   ,rd_wip_0 ,1,0,0,0,valid,0 ns);
                    -- try programming in protected area, programming fail
                    command_seq(45)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(46)  :=(pg_prog,err    ,3,0,129,0,valid,0 ns);
                    command_seq(47)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(48)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(49)  :=(read_SR2 ,pgm_nosucc ,1,0,0,0,valid,0 ns);
                    command_seq(50)  :=(clr_sr ,none ,1,0,0,0,valid,0 ns);
                    command_seq(51)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- try block erase in protected area, erasing fail
                    command_seq(52)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(53)  :=(sector_erase,err    ,0,0,129,0,valid,0 ns);
                    command_seq(54)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(55)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(56)  :=(read_SR2 ,erase_nosucc ,1,0,0,0,valid,0 ns);
                    command_seq(57)  :=(clr_sr ,none ,1,0,0,0,valid,0 ns);
                    command_seq(58)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);

                    command_seq(59)  :=(done   ,none    ,0,0,0,0,valid,0 ns);

                    WHEN 2  =>
                    REPORT "Array protection, positive test";
                    REPORT "Individual Block Lock or Pointer Region Protection, positive test";
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- WPS=1 : Select Individual Block Lock (IBL)
                    -- PRPR[10]=0 : Enable Pointer Region Protection (PRP)
                    -- Array protection = IBL or PRP
                    command_seq(2)  :=(w_enable,none ,0,0,0,0,valid,0 ns);
                    command_seq(3)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(4)  :=(wrar ,none   ,0,16#64#,16#800#,3,valid,0 ns);
                    command_seq(5)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(6)  :=(wt   ,none   ,0,0,0,0,valid,tW);
                    -- IBL read for sector 0, sector is locked
                    command_seq(7)  :=(ibl_rd     ,read_ibl_0    ,1,0,0,0,valid,0 ns);
                    command_seq(8)  :=(wt   ,none   ,0,0,0,0,valid,50 ns);
                    -- try programming in IBL loced sector, programming fail
                    command_seq(9)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(10)  :=(pg_prog,err    ,3,0,0,0,valid,0 ns);
                    command_seq(11)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(12)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(13)  :=(read_SR2 ,pgm_nosucc ,1,0,0,0,valid,0 ns);
                    command_seq(14)  :=(clr_sr ,none ,1,0,0,0,valid,0 ns);
                    command_seq(15)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);

                    -- IBL read for sector 130, sector is locked
                    command_seq(16)  :=(ibl_rd     ,read_ibl_0    ,1,0,130,0,valid,0 ns);
                    command_seq(17)  :=(wt   ,none   ,0,0,0,0,valid,50 ns);
                    -- try programming in IBL loced sector, programming fail
                    command_seq(18)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(19)  :=(pg_prog,err    ,3,0,130,0,valid,0 ns);
                    command_seq(20)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(21)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(22)  :=(read_SR2 ,pgm_nosucc ,1,0,0,0,valid,0 ns);
                    command_seq(23)  :=(clr_sr ,none ,1,0,0,0,valid,0 ns);
                    command_seq(24)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);

                    -- sector 130 unlock
                    command_seq(25)  :=(w_ibul     ,none    ,1,0,130,0,valid,0 ns);
                    command_seq(26)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(27)  :=(ibl_rd     ,read_ibl_1    ,1,0,130,0,valid,0 ns);
                    command_seq(28)  :=(wt   ,none   ,0,0,0,0,valid,50 ns);
                    -- sector 130 is Pointer Region Protected
                    -- try halfblock erase in protected area, erasing fail
                    command_seq(29)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(30)  :=(halfblock_erase,err    ,0,0,130,0,valid,0 ns);
                    command_seq(31)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(32)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(33)  :=(read_SR2 ,erase_nosucc ,1,0,0,0,valid,0 ns);
                    command_seq(34)  :=(clr_sr ,none ,1,0,0,0,valid,0 ns);
                    -- Global IBL Unlock
                    command_seq(35)   :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(36)  :=(w_gbul     ,none    ,1,0,0,0,valid,0 ns);
                    command_seq(37)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(38)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(39)  :=(done   ,none    ,0,0,0,0,valid,0 ns);

                    WHEN OTHERS => NULL;
                END CASE;

            WHEN 17  => -- Deep Power Down
                CASE Testcase IS
                    WHEN 1  =>
                    REPORT "Deep Power Down mode, positive test";
                    -- Enter DPD mode
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(2)  :=(w_dpd   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(3)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- Exit DPD mode
                    command_seq(4)  :=(w_res   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(5)  :=(wt   ,none    ,0,0,0,0,valid,tRES);
                    -- Enter DPD mode
                    command_seq(6)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(7)  :=(w_dpd   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(8)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- Exit DPD mode with DeviceID read
                    command_seq(9)  :=(res_rd   ,rd_res    ,2,0,0,0,valid,0 ns);
                    command_seq(10)  :=(wt   ,none    ,0,0,0,0,valid,tRES);
                    -- Enter DPD mode
                    command_seq(11)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(12)  :=(w_dpd   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(13)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(14)  :=(wt   ,none    ,0,0,0,0,valid,50 ns);
                    -- Enter hardware reset to exit DPD mode
                    command_seq(15)  :=(h_reset,none ,0,0,0,0,valid,201 ns);
                    command_seq(16)  :=(wt   ,none     ,0,0,0,0,valid,tRPH+100 ns);
                    -- set read latency to 9
                    command_seq(17)  :=(w_enable   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(18)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(19)  :=(wrar ,none   ,0,16#79#,16#800#,4,valid,0 ns);
                    command_seq(20)  :=(wt   ,none   ,0,0,0,0,valid,100 ns);
                    command_seq(21)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(22)  :=(done   ,none    ,0,0,0,0,valid,0 ns);
                    WHEN OTHERS => NULL;
                END CASE;

            WHEN 18  => -- Reset commands
                CASE Testcase IS
                    WHEN 1  =>
                    REPORT "Software controlled reset commands, positive test";
                    -- set SRP1=1
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(2)  :=(w_enable,none ,0,0,0,0,valid,0 ns);
                    command_seq(3)  :=(wrar,none ,1,16#05#,16#800#,2,valid,0 ns);
                    command_seq(4)  :=(wt   ,none     ,0,0,0,0,valid,50 ns);
                    command_seq(5)  :=(read_CR1,rd_CR1 ,1,0,0,0,valid,0 ns);
                    command_seq(6)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- enter software reset command
                    command_seq(7)  :=(reset_en,none ,0,0,0,0,valid,0 ns);
                    command_seq(8)  :=(idle,none ,0,0,0,0,valid,0 ns);
                    command_seq(9)  :=(rst,none ,0,0,0,0,valid,0 ns);
                    command_seq(10)  :=(wt   ,none     ,0,0,0,0,valid,tRPH+100 ns);
                    -- check that the SRP0 is not changed by the SW reset
                    command_seq(11)  :=(read_CR1,rd_CR1 ,1,0,0,0,valid,0 ns);
                    -- initiate page program and during busy state enter SW reset command
                    command_seq(12)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(13)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(14)  :=(pg_prog,err    ,3,10,65,0,valid,0 ns);
                    command_seq(15)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(16)  :=(reset_en,none ,0,0,0,0,valid,0 ns);
                    command_seq(17)  :=(idle,none ,0,0,0,0,valid,0 ns);
                    command_seq(18)  :=(rst,none ,0,0,0,0,valid,0 ns);
                    command_seq(19)  :=(wt   ,none     ,0,0,0,0,valid,tRPH+100 ns);
                    command_seq(20)  :=(fast_rd     ,rd_U    ,3,0,65,0,valid,0 ns);
                    -- re-initiate  page program
                    command_seq(21)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(22)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(23)  :=(pg_prog,none    ,5,10,65,0,valid,0 ns);
                    command_seq(24)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(25)  :=(wt   ,none     ,0,0,0,0,valid,(tBP1+4*tBP2));
                    command_seq(26)  :=(fast_rd     ,read_fast    ,5,0,65,0,valid,0 ns);
                    command_seq(27)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- initiate sector erase and during busy state enter SW reset command
                    command_seq(28)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(29)  :=(sector_erase,none    ,0,0,70,0,valid,0 ns);
                    command_seq(30)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(31)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(32)  :=(reset_en,none ,0,0,0,0,valid,0 ns);
                    command_seq(33)  :=(idle,none ,0,0,0,0,valid,0 ns);
                    command_seq(34)  :=(rst,none ,0,0,0,0,valid,0 ns);
                    command_seq(35)  :=(wt   ,none     ,0,0,0,0,valid,tRPH+100 ns);
                    command_seq(36)  :=(fast_rd     ,rd_U    ,3,0,70,0,valid,0 ns);
                    -- re-initiate sector erase
                    command_seq(37)  :=(w_enable,none   ,0,0,0,0,valid,0 ns);
                    command_seq(38)  :=(sector_erase,none    ,0,0,70,0,valid,0 ns);
                    command_seq(39)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(40)  :=(read_SR1 ,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(41)  :=(wt   ,none     ,0,0,0,0,valid,tSE);
                    command_seq(42)  :=(read_SR1 ,rd_wip_0 ,1,0,0,0,valid,0 ns);
                    command_seq(43)  :=(fast_rd     ,read_fast    ,3,0,70,0, valid,0 ns);
                    command_seq(44)  :=(reset_en,none ,0,0,0,0,valid,0 ns);
                    command_seq(45)  :=(idle,none ,0,0,0,0,valid,0 ns);
                    command_seq(46)  :=(reset_en,none ,0,0,0,0,valid,0 ns);
                    command_seq(47)  :=(rst,none ,0,0,0,0,valid,0 ns);
                    command_seq(48)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(49)  :=(done   ,none    ,0,0,0,0,valid,0 ns);
                    WHEN OTHERS => NULL;
                END CASE;

            WHEN 19  => -- Reset commands
                CASE Testcase IS

                    WHEN 1  =>
                    REPORT "First Read";
                    REPORT "Single, Dual Output, Dual I/O Read commands for the main flash array, positive test";
                    -- Read
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(2)  :=(rd     ,read    ,5,0,0,0,valid,0 ns);
                    command_seq(3)  :=(rd     ,read    ,10,0,16#FFF#,16#FFA#,valid,0 ns);
                    command_seq(4)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- Fast Read
                    command_seq(5)  :=(fast_rd     ,read_fast    ,5,0,1,0,valid,0 ns);
                    command_seq(6)  :=(fast_rd     ,read_fast    ,10,0,16#FFF#,16#FFA#,valid,0 ns);
                    command_seq(7)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- Dual Output Read
                    command_seq(8)  :=(dual_output_rd     ,read_dual_O    ,5,0,2,0,valid,0 ns);
                    command_seq(9)  :=(dual_output_rd     ,read_dual_O    ,10,0,16#FFF#,16#FFA#,valid,0 ns);
                    command_seq(10)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- Dual IO Read
                    command_seq(11)  :=(dual_IO_rd     ,read_dual_IO    ,5,0,3,0,valid,0 ns);
                    command_seq(12)  :=(dual_IO_rd     ,read_dual_IO    ,10,0,16#FFF#,16#FFA#,valid,0 ns);
                    command_seq(13)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- Dual IO Continuous Read
                    command_seq(14)  :=(dual_IO_rd     ,read_dual_IO    ,3,16#A0#,4,0,valid,0 ns);
                    command_seq(15)  :=(dual_IO_rd     ,rd_cont    ,3,0,5,0,valid,0 ns);
                    command_seq(16)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- Dual IO Continuous Read exit with mode reset command
                    command_seq(17)  :=(dual_IO_rd     ,read_dual_IO    ,3,16#A0#,5,0,valid,0 ns);
                    command_seq(18)  :=(mbr     ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(19)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(20)  :=(done   ,none    ,0,0,0,0,valid,0 ns);

                    WHEN 2  =>
                    REPORT "Quad Output Read and Quad I/O Read commands for the main flash array, positive test";
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- enter QUAD mode
                    command_seq(2)  :=(w_enablev,none ,0,0,0,0,valid,0 ns);
                    command_seq(3)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(4)  :=(w_wrr,none ,2,16#0200#,0,0,valid,0 ns);
                    command_seq(5)  :=(wt   ,none     ,0,0,0,0,valid,tQEN);
                    -- set RL=13
                    command_seq(6)  :=(w_enablev,none ,0,0,0,0,valid,0 ns);
                    command_seq(7)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(8)  :=(w_wrr,none ,4,16#7D600200#,0,0,valid,0 ns);
                    command_seq(9)  :=(wt   ,none     ,0,0,0,0,valid,50 ns);
                    -- Quad Output Read
                    command_seq(10)  :=(quad_output_rd     ,read_quad_O    ,5,0,7,0,valid,0 ns);
                    command_seq(11)  :=(quad_output_rd     ,read_quad_O    ,10,0,16#FFF#,16#FFA#,valid,0 ns);
                    command_seq(12)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- Quad IO Read
                    command_seq(13)  :=(quad_IO_rd     ,read_quad_IO    ,5,0,3,0,valid,0 ns);
                    command_seq(14)  :=(quad_IO_rd     ,read_quad_IO    ,10,0,16#FFF#,16#FFA#,valid,0 ns);
                    command_seq(15)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- Dual IO Continuous Read
                    command_seq(16)  :=(quad_IO_rd     ,read_quad_IO    ,3,16#A0#,4,0,valid,0 ns);
                    command_seq(17)  :=(quad_IO_rd     ,rd_cont    ,3,0,5,0,valid,0 ns);
                    command_seq(18)  :=(idle   ,none   ,0,0,0,0,valid,0 ns);
                    -- Dual IO Continuous Read exit with mode reset command
                    command_seq(19)  :=(quad_IO_rd     ,read_quad_IO    ,3,16#A0#,5,0,valid,0 ns);
                    command_seq(20)  :=(mbr     ,none   ,0,0,0,0,valid,0 ns);
                    command_seq(21)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- QPI mode
                    command_seq(22)  :=(w_qpien,none ,0,0,0,0,valid,0 ns);
                    command_seq(23)  :=(wt   ,none     ,0,0,0,0,valid,tQEN);
                    command_seq(24)  :=(quad_IO_rd     ,read_quad_IO    ,5,0,0,0,valid,0 ns);
                    command_seq(25)  :=(w_qpiex,none ,0,0,0,0,valid,0 ns);
                    command_seq(26)  :=(wt   ,none     ,0,0,0,0,valid,tQEX);

                    -- set 8-bit burst wrap mode
                    command_seq(27)  :=(w_enablev,none ,0,0,0,0,valid,0 ns);
                    command_seq(28)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(29)  :=(w_wrr,none ,4,16#0d600200#,0,0,valid,0 ns);
                    command_seq(30)  :=(wt   ,none     ,0,0,0,0,valid,50 ns);
                    command_seq(31)  :=(read_CR3,rd_CR3 ,1,0,0,0,valid,0 ns);
                    command_seq(32)  :=(quad_IO_rd     ,read_quad_IO    ,10,0,0,3,valid,0 ns);

                    -- set 16-bit burst wrap mode
                    command_seq(33)  :=(w_enable,none ,0,0,0,0,valid,0 ns);
                    command_seq(34)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(35)  :=(wrar,none ,4,16#2d#,16#800#,4,valid,0 ns);
                    command_seq(36)  :=(wt   ,none     ,0,0,0,0,valid,50 ns);
                    command_seq(37)  :=(read_CR3,rd_CR3 ,1,0,0,0,valid,0 ns);
                    command_seq(38)  :=(quad_IO_rd     ,read_quad_IO    ,20,0,3,3,valid,0 ns);
                    -- set 32-bit burst wrap mode
                    command_seq(39)  :=(set_bl,none ,0,16#40#,0,0,valid,0 ns);
                    command_seq(40)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(41)  :=(read_CR3,rd_CR3 ,1,0,0,0,valid,0 ns);
                    command_seq(42)  :=(quad_IO_rd     ,read_quad_IO    ,40,0,4,4,valid,0 ns);
                    -- disable burst wrap mode
                    command_seq(43)  :=(set_bl,none ,0,16#10#,0,0,valid,0 ns);
                    command_seq(44)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(45)  :=(done   ,none    ,0,0,0,0,valid,0 ns);

                    WHEN 3  =>
                    REPORT " DDR Quad I/O read commands for the main flash array, positive test";
                    command_seq(1)  :=(idle   ,none   ,0,0,0,0,valid,0 ns);
                    command_seq(2)  :=(ddr_quad_IO_rd ,read_ddr_quad_IO    ,5,0,5,0,valid,0 ns);
                    command_seq(3)  :=(ddr_quad_IO_rd ,read_ddr_quad_IO    ,10,0,16#FFF#,16#FFA#,valid,0 ns);
                    command_seq(4)  :=(idle   ,none   ,0,0,0,0,valid,0 ns);
                    -- DDR QUAD IO Continuous Read
                    command_seq(5)  :=(ddr_quad_IO_rd ,read_ddr_quad_IO    ,3,16#A5#,4,0,valid,0 ns);
                    command_seq(6)  :=(ddr_quad_IO_rd ,rd_cont    ,3,0,5,0,valid,0 ns);
                    command_seq(7)  :=(idle   ,none   ,0,0,0,0,valid,0 ns);
                    --DDR QUAD IO Continuous Read exit with mode reset command
                    command_seq(8)  :=(ddr_quad_IO_rd ,read_ddr_quad_IO    ,3,16#5A#,1,0,valid,0 ns);
                    command_seq(9)  :=(mbr     ,none   ,0,0,0,0,valid,0 ns);
                    command_seq(10)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- program non-volatile data learning register
                    command_seq(11)  :=(w_enable,none ,0,0,0,0,valid,0 ns);
                    command_seq(12)  :=(w_nvdlr,none ,1,16#34#,0,0,valid,0 ns);
                    command_seq(13)  :=(read_SR1,rd_wip_1 ,1,0,0,0,valid,0 ns);
                    command_seq(14)  :=(wt   ,none     ,0,0,0,0,valid,tPP);
                    command_seq(15)  :=(rdar,rd_wip_0 ,1,0,16#800#,0,valid,0 ns);
                    command_seq(16)  :=(rd_dlp,read_dlp ,1,0,0,0,DontAssertCSNeg,0 ns);
                    command_seq(17)  :=(idle   ,none   ,0,0,0,0,valid,0 ns);
                    -- DDR Quad I/O read with Data Learning Pattern read out
                    command_seq(18)  :=(ddr_quad_IO_rd ,read_ddr_quad_IO    ,5,0,1,0,valid,0 ns);
                    -- set read latency to 5
                    command_seq(19)  :=(w_enable,none ,0,0,0,0,valid,0 ns);
                    command_seq(20)  :=(wrar,none ,4,16#15#,16#800#,4,valid,0 ns);
                    command_seq(21)  :=(wt   ,none     ,0,0,0,0,valid,50 ns);
                    -- enter QPI mode
                    command_seq(22)  :=(w_qpien,none ,0,0,0,0,valid,0 ns);
                    command_seq(23)  :=(wt   ,none     ,0,0,0,0,valid,tQEN);
                    command_seq(24)  :=(ddr_quad_IO_rd ,read_ddr_quad_IO    ,5,0,7,1,valid,0 ns);
                    -- set 8-bit burst wrap mode
                    command_seq(25)  :=(set_bl,none ,0,16#00#,0,0,valid,0 ns);
                    command_seq(26)  :=(ddr_quad_IO_rd ,read_ddr_quad_IO    ,5,0,5,5,valid,0 ns);
                    -- disable burst wrap mode
                    command_seq(27)  :=(set_bl,none ,0,16#10#,0,0,valid,0 ns);
                    command_seq(28)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- exit QPI mode
                    command_seq(29)  :=(w_qpiex,none ,0,0,0,0,valid,0 ns);
                    command_seq(30)  :=(wt   ,none     ,0,0,0,0,valid,tQEX);
                    -- set read latency to 13
                    command_seq(31)  :=(w_enable,none ,0,0,0,0,valid,0 ns);
                    command_seq(32)  :=(wrar,none ,4,16#1d#,16#800#,4,valid,0 ns);
                    command_seq(33)  :=(wt   ,none     ,0,0,0,0,valid,50 ns);
                    command_seq(34)  :=(read_CR3,rd_CR3 ,2,0,0,0,valid,0 ns);
                    command_seq(35)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(36)  :=(done   ,none    ,0,0,0,0,valid,0 ns);




                    WHEN 4  =>
                    REPORT "Second Read - Do not assert CSNeg";
                    REPORT "Single, Dual Output, Dual I/O Read commands for the main flash array, positive test";
                    -- Read
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,DontAssertCSNeg,0 ns);
                    command_seq(2)  :=(rd     ,read    ,5,0,0,0,DontAssertCSNeg,0 ns);
                    command_seq(3)  :=(rd     ,read    ,10,0,16#FFF#,16#FFA#,DontAssertCSNeg,0 ns);
                    command_seq(4)  :=(idle   ,none    ,0,0,0,0,DontAssertCSNeg,0 ns);
                    -- Fast Read
                    command_seq(5)  :=(fast_rd     ,read_fast    ,5,0,1,0,DontAssertCSNeg,0 ns);
                    command_seq(6)  :=(fast_rd     ,read_fast    ,10,0,16#FFF#,16#FFA#,DontAssertCSNeg,0 ns);
                    command_seq(7)  :=(idle   ,none    ,0,0,0,0,DontAssertCSNeg,0 ns);
                    -- Dual Output Read
                    command_seq(8)  :=(dual_output_rd     ,read_dual_O    ,5,0,2,0,DontAssertCSNeg,0 ns);
                    command_seq(9)  :=(dual_output_rd     ,read_dual_O    ,10,0,16#FFF#,16#FFA#,DontAssertCSNeg,0 ns);
                    command_seq(10)  :=(idle   ,none    ,0,0,0,0,DontAssertCSNeg,0 ns);
                    -- Dual IO Read
                    command_seq(11)  :=(dual_IO_rd     ,read_dual_IO    ,5,0,3,0,DontAssertCSNeg,0 ns);
                    command_seq(12)  :=(dual_IO_rd     ,read_dual_IO    ,10,0,16#FFF#,16#FFA#,DontAssertCSNeg,0 ns);
                    command_seq(13)  :=(idle   ,none    ,0,0,0,0,DontAssertCSNeg,0 ns);
                    -- Dual IO Continuous Read
                    command_seq(14)  :=(dual_IO_rd     ,read_dual_IO    ,3,16#A0#,4,0,DontAssertCSNeg,0 ns);
                    command_seq(15)  :=(dual_IO_rd     ,rd_cont    ,3,0,5,0,DontAssertCSNeg,0 ns);
                    command_seq(16)  :=(idle   ,none    ,0,0,0,0,DontAssertCSNeg,0 ns);
                    -- Dual IO Continuous Read exit with mode reset command
                    command_seq(17)  :=(dual_IO_rd     ,read_dual_IO    ,3,16#A0#,5,0,DontAssertCSNeg,0 ns);
                    command_seq(18)  :=(mbr     ,none    ,0,0,0,0,DontAssertCSNeg,0 ns);
                    command_seq(19)  :=(idle   ,none    ,0,0,0,0,DontAssertCSNeg,0 ns);
                    command_seq(20)  :=(done   ,none    ,0,0,0,0,DontAssertCSNeg,0 ns);

                    WHEN 5  =>
                    REPORT "Quad Output Read and Quad I/O Read commands for the main flash array, positive test";
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,DontAssertCSNeg,0 ns);
                    -- enter QUAD mode
                    command_seq(2)  :=(w_enablev,none ,0,0,0,0,DontAssertCSNeg,0 ns);
                    command_seq(3)  :=(idle   ,none    ,0,0,0,0,DontAssertCSNeg,0 ns);
                    command_seq(4)  :=(w_wrr,none ,2,16#0200#,0,0,DontAssertCSNeg,0 ns);
                    command_seq(5)  :=(wt   ,none     ,0,0,0,0,DontAssertCSNeg,tQEN);
                    -- set RL=13
                    command_seq(6)  :=(w_enablev,none ,0,0,0,0,DontAssertCSNeg,0 ns);
                    command_seq(7)  :=(idle   ,none    ,0,0,0,0,DontAssertCSNeg,0 ns);
                    command_seq(8)  :=(w_wrr,none ,4,16#7D600200#,0,0,DontAssertCSNeg,0 ns);
                    command_seq(9)  :=(wt   ,none     ,0,0,0,0,DontAssertCSNeg,50 ns);
                    -- Quad Output Read
                    command_seq(10)  :=(quad_output_rd     ,read_quad_O    ,5,0,7,0,DontAssertCSNeg,0 ns);
                    command_seq(11)  :=(quad_output_rd     ,read_quad_O    ,10,0,16#FFF#,16#FFA#,DontAssertCSNeg,0 ns);
                    command_seq(12)  :=(idle   ,none    ,0,0,0,0,DontAssertCSNeg,0 ns);
                    -- Quad IO Read
                    command_seq(13)  :=(quad_IO_rd     ,read_quad_IO    ,5,0,3,0,DontAssertCSNeg,0 ns);
                    command_seq(14)  :=(quad_IO_rd     ,read_quad_IO    ,10,0,16#FFF#,16#FFA#,DontAssertCSNeg,0 ns);
                    command_seq(15)  :=(idle   ,none    ,0,0,0,0,DontAssertCSNeg,0 ns);
                    -- Dual IO Continuous Read
                    command_seq(16)  :=(quad_IO_rd     ,read_quad_IO    ,3,16#A0#,4,0,DontAssertCSNeg,0 ns);
                    command_seq(17)  :=(quad_IO_rd     ,rd_cont    ,3,0,5,0,DontAssertCSNeg,0 ns);
                    command_seq(18)  :=(idle   ,none   ,0,0,0,0,DontAssertCSNeg,0 ns);
                    -- Dual IO Continuous Read exit with mode reset command
                    command_seq(19)  :=(quad_IO_rd     ,read_quad_IO    ,3,16#A0#,5,0,DontAssertCSNeg,0 ns);
                    command_seq(20)  :=(mbr     ,none   ,0,0,0,0,DontAssertCSNeg,0 ns);
                    command_seq(21)  :=(idle   ,none    ,0,0,0,0,DontAssertCSNeg,0 ns);
                    -- QPI mode
                    command_seq(22)  :=(w_qpien,none ,0,0,0,0,DontAssertCSNeg,0 ns);
                    command_seq(23)  :=(wt   ,none     ,0,0,0,0,DontAssertCSNeg,tQEN);
                    command_seq(24)  :=(quad_IO_rd     ,read_quad_IO    ,5,0,0,0,DontAssertCSNeg,0 ns);
                    command_seq(25)  :=(w_qpiex,none ,0,0,0,0,DontAssertCSNeg,0 ns);
                    command_seq(26)  :=(wt   ,none     ,0,0,0,0,DontAssertCSNeg,tQEX);

                    -- set 8-bit burst wrap mode
                    command_seq(27)  :=(w_enablev,none ,0,0,0,0,DontAssertCSNeg,0 ns);
                    command_seq(28)  :=(idle   ,none    ,0,0,0,0,DontAssertCSNeg,0 ns);
                    command_seq(29)  :=(w_wrr,none ,4,16#0d600200#,0,0,DontAssertCSNeg,0 ns);
                    command_seq(30)  :=(wt   ,none     ,0,0,0,0,DontAssertCSNeg,50 ns);
                    command_seq(31)  :=(read_CR3,rd_CR3 ,1,0,0,0,DontAssertCSNeg,0 ns);
                    command_seq(32)  :=(quad_IO_rd     ,read_quad_IO    ,10,0,0,3,DontAssertCSNeg,0 ns);

                    -- set 16-bit burst wrap mode
                    command_seq(33)  :=(w_enable,none ,0,0,0,0,DontAssertCSNeg,0 ns);
                    command_seq(34)  :=(idle   ,none    ,0,0,0,0,DontAssertCSNeg,0 ns);
                    command_seq(35)  :=(wrar,none ,4,16#2d#,16#800#,4,DontAssertCSNeg,0 ns);
                    command_seq(36)  :=(wt   ,none     ,0,0,0,0,DontAssertCSNeg,50 ns);
                    command_seq(37)  :=(read_CR3,rd_CR3 ,1,0,0,0,DontAssertCSNeg,0 ns);
                    command_seq(38)  :=(quad_IO_rd     ,read_quad_IO    ,20,0,3,3,DontAssertCSNeg,0 ns);
                    -- set 32-bit burst wrap mode
                    command_seq(39)  :=(set_bl,none ,0,16#40#,0,0,DontAssertCSNeg,0 ns);
                    command_seq(40)  :=(idle   ,none    ,0,0,0,0,DontAssertCSNeg,0 ns);
                    command_seq(41)  :=(read_CR3,rd_CR3 ,1,0,0,0,DontAssertCSNeg,0 ns);
                    command_seq(42)  :=(quad_IO_rd     ,read_quad_IO    ,40,0,4,4,DontAssertCSNeg,0 ns);
                    -- disable burst wrap mode
                    command_seq(43)  :=(set_bl,none ,0,16#10#,0,0,DontAssertCSNeg,0 ns);
                    command_seq(44)  :=(idle   ,none    ,0,0,0,0,DontAssertCSNeg,0 ns);
                    command_seq(45)  :=(done   ,none    ,0,0,0,0,DontAssertCSNeg,0 ns);

                    WHEN 6  =>
                    REPORT " DDR Quad I/O read commands for the main flash array, positive test";
                    command_seq(1)  :=(idle   ,none   ,0,0,0,0,DontAssertCSNeg,0 ns);
                    command_seq(2)  :=(ddr_quad_IO_rd ,read_ddr_quad_IO    ,5,0,5,0,DontAssertCSNeg,0 ns);
                    command_seq(3)  :=(ddr_quad_IO_rd ,read_ddr_quad_IO    ,10,0,16#FFF#,16#FFA#,DontAssertCSNeg,0 ns);
                    command_seq(4)  :=(idle   ,none   ,0,0,0,0,DontAssertCSNeg,0 ns);
                    -- DDR QUAD IO Continuous Read
                    command_seq(5)  :=(ddr_quad_IO_rd ,read_ddr_quad_IO    ,3,16#A5#,4,0,DontAssertCSNeg,0 ns);
                    command_seq(6)  :=(ddr_quad_IO_rd ,rd_cont    ,3,0,5,0,DontAssertCSNeg,0 ns);
                    command_seq(7)  :=(idle   ,none   ,0,0,0,0,DontAssertCSNeg,0 ns);
                    --DDR QUAD IO Continuous Read exit with mode reset command
                    command_seq(8)  :=(ddr_quad_IO_rd ,read_ddr_quad_IO    ,3,16#5A#,1,0,DontAssertCSNeg,0 ns);
                    command_seq(9)  :=(mbr     ,none   ,0,0,0,0,DontAssertCSNeg,0 ns);
                    command_seq(10)  :=(idle   ,none    ,0,0,0,0,DontAssertCSNeg,0 ns);
                    -- program non-volatile data learning register
                    command_seq(11)  :=(w_enable,none ,0,0,0,0,DontAssertCSNeg,0 ns);
                    command_seq(12)  :=(w_nvdlr,none ,1,16#34#,0,0,DontAssertCSNeg,0 ns);
                    command_seq(13)  :=(read_SR1,rd_wip_1 ,1,0,0,0,DontAssertCSNeg,0 ns);
                    command_seq(14)  :=(wt   ,none     ,0,0,0,0,DontAssertCSNeg,tPP);
                    command_seq(15)  :=(rdar,rd_wip_0 ,1,0,16#800#,0,DontAssertCSNeg,0 ns);
                    command_seq(16)  :=(rd_dlp,read_dlp ,1,0,0,0,DontAssertCSNeg,0 ns);
                    command_seq(17)  :=(idle   ,none   ,0,0,0,0,DontAssertCSNeg,0 ns);
                    -- DDR Quad I/O read with Data Learning Pattern read out
                    command_seq(18)  :=(ddr_quad_IO_rd ,read_ddr_quad_IO    ,5,0,1,0,DontAssertCSNeg,0 ns);
                    -- set read latency to 5
                    command_seq(19)  :=(w_enable,none ,0,0,0,0,DontAssertCSNeg,0 ns);
                    command_seq(20)  :=(wrar,none ,4,16#15#,16#800#,4,DontAssertCSNeg,0 ns);
                    command_seq(21)  :=(wt   ,none     ,0,0,0,0,DontAssertCSNeg,50 ns);
                    -- enter QPI mode
                    command_seq(22)  :=(w_qpien,none ,0,0,0,0,DontAssertCSNeg,0 ns);
                    command_seq(23)  :=(wt   ,none     ,0,0,0,0,DontAssertCSNeg,tQEN);
                    command_seq(24)  :=(ddr_quad_IO_rd ,read_ddr_quad_IO    ,5,0,7,1,DontAssertCSNeg,0 ns);
                    -- set 8-bit burst wrap mode
                    command_seq(25)  :=(set_bl,none ,0,16#00#,0,0,DontAssertCSNeg,0 ns);
                    command_seq(26)  :=(ddr_quad_IO_rd ,read_ddr_quad_IO    ,5,0,5,5,DontAssertCSNeg,0 ns);
                    -- disable burst wrap mode
                    command_seq(27)  :=(set_bl,none ,0,16#10#,0,0,DontAssertCSNeg,0 ns);
                    command_seq(28)  :=(idle   ,none    ,0,0,0,0,DontAssertCSNeg,0 ns);
                    -- exit QPI mode
                    command_seq(29)  :=(w_qpiex,none ,0,0,0,0,DontAssertCSNeg,0 ns);
                    command_seq(30)  :=(wt   ,none     ,0,0,0,0,DontAssertCSNeg,tQEX);
                    -- set read latency to 13
                    command_seq(31)  :=(w_enable,none ,0,0,0,0,DontAssertCSNeg,0 ns);
                    command_seq(32)  :=(wrar,none ,4,16#1d#,16#800#,4,DontAssertCSNeg,0 ns);
                    command_seq(33)  :=(wt   ,none     ,0,0,0,0,DontAssertCSNeg,50 ns);
                    command_seq(34)  :=(read_CR3,rd_CR3 ,2,0,0,0,DontAssertCSNeg,0 ns);
                    command_seq(35)  :=(idle   ,none    ,0,0,0,0,DontAssertCSNeg,0 ns);
                    command_seq(36)  :=(done   ,none    ,0,0,0,0,DontAssertCSNeg,0 ns);










                    WHEN 7  =>
                    REPORT "Third Read";
                    REPORT "Single, Dual Output, Dual I/O Read commands for the main flash array, positive test";
                    -- Read
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(2)  :=(rd     ,read    ,5,0,0,0,valid,0 ns);
                    command_seq(3)  :=(rd     ,read    ,10,0,16#FFF#,16#FFA#,valid,0 ns);
                    command_seq(4)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- Fast Read
                    command_seq(5)  :=(fast_rd     ,read_fast    ,5,0,1,0,valid,0 ns);
                    command_seq(6)  :=(fast_rd     ,read_fast    ,10,0,16#FFF#,16#FFA#,valid,0 ns);
                    command_seq(7)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- Dual Output Read
                    command_seq(8)  :=(dual_output_rd     ,read_dual_O    ,5,0,2,0,valid,0 ns);
                    command_seq(9)  :=(dual_output_rd     ,read_dual_O    ,10,0,16#FFF#,16#FFA#,valid,0 ns);
                    command_seq(10)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- Dual IO Read
                    command_seq(11)  :=(dual_IO_rd     ,read_dual_IO    ,5,0,3,0,valid,0 ns);
                    command_seq(12)  :=(dual_IO_rd     ,read_dual_IO    ,10,0,16#FFF#,16#FFA#,valid,0 ns);
                    command_seq(13)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- Dual IO Continuous Read
                    command_seq(14)  :=(dual_IO_rd     ,read_dual_IO    ,3,16#A0#,4,0,valid,0 ns);
                    command_seq(15)  :=(dual_IO_rd     ,rd_cont    ,3,0,5,0,valid,0 ns);
                    command_seq(16)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- Dual IO Continuous Read exit with mode reset command
                    command_seq(17)  :=(dual_IO_rd     ,read_dual_IO    ,3,16#A0#,5,0,valid,0 ns);
                    command_seq(18)  :=(mbr     ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(19)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(20)  :=(done   ,none    ,0,0,0,0,valid,0 ns);

                    WHEN 8  =>
                    REPORT "Quad Output Read and Quad I/O Read commands for the main flash array, positive test";
                    command_seq(1)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- enter QUAD mode
                    command_seq(2)  :=(w_enablev,none ,0,0,0,0,valid,0 ns);
                    command_seq(3)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(4)  :=(w_wrr,none ,2,16#0200#,0,0,valid,0 ns);
                    command_seq(5)  :=(wt   ,none     ,0,0,0,0,valid,tQEN);
                    -- set RL=13
                    command_seq(6)  :=(w_enablev,none ,0,0,0,0,valid,0 ns);
                    command_seq(7)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(8)  :=(w_wrr,none ,4,16#7D600200#,0,0,valid,0 ns);
                    command_seq(9)  :=(wt   ,none     ,0,0,0,0,valid,50 ns);
                    -- Quad Output Read
                    command_seq(10)  :=(quad_output_rd     ,read_quad_O    ,5,0,7,0,valid,0 ns);
                    command_seq(11)  :=(quad_output_rd     ,read_quad_O    ,10,0,16#FFF#,16#FFA#,valid,0 ns);
                    command_seq(12)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- Quad IO Read
                    command_seq(13)  :=(quad_IO_rd     ,read_quad_IO    ,5,0,3,0,valid,0 ns);
                    command_seq(14)  :=(quad_IO_rd     ,read_quad_IO    ,10,0,16#FFF#,16#FFA#,valid,0 ns);
                    command_seq(15)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- Dual IO Continuous Read
                    command_seq(16)  :=(quad_IO_rd     ,read_quad_IO    ,3,16#A0#,4,0,valid,0 ns);
                    command_seq(17)  :=(quad_IO_rd     ,rd_cont    ,3,0,5,0,valid,0 ns);
                    command_seq(18)  :=(idle   ,none   ,0,0,0,0,valid,0 ns);
                    -- Dual IO Continuous Read exit with mode reset command
                    command_seq(19)  :=(quad_IO_rd     ,read_quad_IO    ,3,16#A0#,5,0,valid,0 ns);
                    command_seq(20)  :=(mbr     ,none   ,0,0,0,0,valid,0 ns);
                    command_seq(21)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- QPI mode
                    command_seq(22)  :=(w_qpien,none ,0,0,0,0,valid,0 ns);
                    command_seq(23)  :=(wt   ,none     ,0,0,0,0,valid,tQEN);
                    command_seq(24)  :=(quad_IO_rd     ,read_quad_IO    ,5,0,0,0,valid,0 ns);
                    command_seq(25)  :=(w_qpiex,none ,0,0,0,0,valid,0 ns);
                    command_seq(26)  :=(wt   ,none     ,0,0,0,0,valid,tQEX);

                    -- set 8-bit burst wrap mode
                    command_seq(27)  :=(w_enablev,none ,0,0,0,0,valid,0 ns);
                    command_seq(28)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(29)  :=(w_wrr,none ,4,16#0d600200#,0,0,valid,0 ns);
                    command_seq(30)  :=(wt   ,none     ,0,0,0,0,valid,50 ns);
                    command_seq(31)  :=(read_CR3,rd_CR3 ,1,0,0,0,valid,0 ns);
                    command_seq(32)  :=(quad_IO_rd     ,read_quad_IO    ,10,0,0,3,valid,0 ns);

                    -- set 16-bit burst wrap mode
                    command_seq(33)  :=(w_enable,none ,0,0,0,0,valid,0 ns);
                    command_seq(34)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(35)  :=(wrar,none ,4,16#2d#,16#800#,4,valid,0 ns);
                    command_seq(36)  :=(wt   ,none     ,0,0,0,0,valid,50 ns);
                    command_seq(37)  :=(read_CR3,rd_CR3 ,1,0,0,0,valid,0 ns);
                    command_seq(38)  :=(quad_IO_rd     ,read_quad_IO    ,20,0,3,3,valid,0 ns);
                    -- set 32-bit burst wrap mode
                    command_seq(39)  :=(set_bl,none ,0,16#40#,0,0,valid,0 ns);
                    command_seq(40)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(41)  :=(read_CR3,rd_CR3 ,1,0,0,0,valid,0 ns);
                    command_seq(42)  :=(quad_IO_rd     ,read_quad_IO    ,40,0,4,4,valid,0 ns);
                    -- disable burst wrap mode
                    command_seq(43)  :=(set_bl,none ,0,16#10#,0,0,valid,0 ns);
                    command_seq(44)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(45)  :=(done   ,none    ,0,0,0,0,valid,0 ns);

                    WHEN 9  =>
                    REPORT " DDR Quad I/O read commands for the main flash array, positive test";
                    command_seq(1)  :=(idle   ,none   ,0,0,0,0,valid,0 ns);
                    command_seq(2)  :=(ddr_quad_IO_rd ,read_ddr_quad_IO    ,5,0,5,0,valid,0 ns);
                    command_seq(3)  :=(ddr_quad_IO_rd ,read_ddr_quad_IO    ,10,0,16#FFF#,16#FFA#,valid,0 ns);
                    command_seq(4)  :=(idle   ,none   ,0,0,0,0,valid,0 ns);
                    -- DDR QUAD IO Continuous Read
                    command_seq(5)  :=(ddr_quad_IO_rd ,read_ddr_quad_IO    ,3,16#A5#,4,0,valid,0 ns);
                    command_seq(6)  :=(ddr_quad_IO_rd ,rd_cont    ,3,0,5,0,valid,0 ns);
                    command_seq(7)  :=(idle   ,none   ,0,0,0,0,valid,0 ns);
                    --DDR QUAD IO Continuous Read exit with mode reset command
                    command_seq(8)  :=(ddr_quad_IO_rd ,read_ddr_quad_IO    ,3,16#5A#,1,0,valid,0 ns);
                    command_seq(9)  :=(mbr     ,none   ,0,0,0,0,valid,0 ns);
                    command_seq(10)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- program non-volatile data learning register
                    command_seq(11)  :=(w_enable,none ,0,0,0,0,valid,0 ns);
                    command_seq(12)  :=(w_nvdlr,err ,1,16#34#,0,0,valid,0 ns);
                    command_seq(13)  :=(read_SR1,rd_wip_0 ,1,0,0,0,valid,0 ns);
                    command_seq(14)  :=(wt   ,none     ,0,0,0,0,valid,tPP);
                    command_seq(15)  :=(rdar,rd_wip_0 ,1,0,16#800#,0,valid,0 ns);
                    command_seq(16)  :=(rd_dlp,read_dlp ,1,0,0,0,valid,0 ns);
                    command_seq(17)  :=(idle   ,none   ,0,0,0,0,valid,0 ns);
                    -- DDR Quad I/O read with Data Learning Pattern read out
                    command_seq(18)  :=(ddr_quad_IO_rd ,read_ddr_quad_IO    ,5,0,1,0,valid,0 ns);
                    -- set read latency to 5
                    command_seq(19)  :=(w_enable,none ,0,0,0,0,valid,0 ns);
                    command_seq(20)  :=(wrar,none ,4,16#15#,16#800#,4,valid,0 ns);
                    command_seq(21)  :=(wt   ,none     ,0,0,0,0,valid,50 ns);
                    -- enter QPI mode
                    command_seq(22)  :=(w_qpien,none ,0,0,0,0,valid,0 ns);
                    command_seq(23)  :=(wt   ,none     ,0,0,0,0,valid,tQEN);
                    command_seq(24)  :=(ddr_quad_IO_rd ,read_ddr_quad_IO    ,5,0,7,1,valid,0 ns);
                    -- set 8-bit burst wrap mode
                    command_seq(25)  :=(set_bl,none ,0,16#00#,0,0,valid,0 ns);
                    command_seq(26)  :=(ddr_quad_IO_rd ,read_ddr_quad_IO    ,5,0,5,5,valid,0 ns);
                    -- disable burst wrap mode
                    command_seq(27)  :=(set_bl,none ,0,16#10#,0,0,valid,0 ns);
                    command_seq(28)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    -- exit QPI mode
                    command_seq(29)  :=(w_qpiex,none ,0,0,0,0,valid,0 ns);
                    command_seq(30)  :=(wt   ,none     ,0,0,0,0,valid,tQEX);
                    -- set read latency to 13
                    command_seq(31)  :=(w_enable,none ,0,0,0,0,valid,0 ns);
                    command_seq(32)  :=(wrar,none ,4,16#1d#,16#800#,4,valid,0 ns);
                    command_seq(33)  :=(wt   ,none     ,0,0,0,0,valid,50 ns);
                    command_seq(34)  :=(read_CR3,rd_CR3 ,2,0,0,0,valid,0 ns);
                    command_seq(35)  :=(idle   ,none    ,0,0,0,0,valid,0 ns);
                    command_seq(36)  :=(done   ,none    ,0,0,0,0,valid,0 ns);


















                    WHEN OTHERS => NULL;
                END CASE;

            WHEN OTHERS =>
        END CASE;

        REPORT "------------------------------------------------------";
    END PROCEDURE Generate_TC;

    ---------------------------------------------------------------------------
    --PUBLIC
    -- CHECKER PROCEDURES
    ---------------------------------------------------------------------------
----Check read from memory
    PROCEDURE   Check_read (
        DQ       :  IN std_logic_vector(7 downto 0);
        DQ_reg0  :  IN std_logic_vector(7 downto 0);
        D_mem    :  IN NATURAL;
        DLP_reg  :  IN NATURAL;
        DLP_EN   :  IN std_logic;
        SIGNAL check_err:  OUT std_logic) IS
    BEGIN
        IF DLP_EN = '1' THEN
            ASSERT to_nat(DQ_reg0) = DLP_reg
                REPORT "Read DLP Register: expected data = " &
                to_int_str(DLP_reg) & " got " & to_int_str(DQ_reg0)
                SEVERITY error;
            ASSERT to_nat(DQ_reg0) /= DLP_reg
                REPORT "Read DLP Register: OK - "& to_int_str(DQ_reg0)
                SEVERITY note;
        END IF;

        ASSERT to_nat(DQ) = D_mem
            REPORT "READ: expected data  =" &
            to_hex_str(D_mem)&" got " &
            to_hex_str(DQ)
            SEVERITY error;

        ASSERT to_nat(DQ)/=D_mem
            REPORT "READ: OK - "&
            to_hex_str(DQ)
            SEVERITY note;

        IF to_nat(DQ)/=D_mem THEN
            check_err <= '1';
        ELSE
            check_err <= '0';
        END IF;
        IF (DLP_EN = '1') THEN
            IF (to_nat(DQ_reg0)/=DLP_reg) THEN
                check_err <= '1';
            END IF;
        ELSE
            check_err <= '0';
        END IF;
    END PROCEDURE Check_read;

----Check tristated output
    PROCEDURE   Check_Z (
        DQ   :  IN std_logic;
        SIGNAL check_err:  OUT std_logic) IS
    BEGIN
        ASSERT DQ = 'Z'
            REPORT "output should be HiZ"
            SEVERITY error;

        IF DQ /= 'Z' THEN
            check_err <= '1';
        ELSE
            check_err <= '0';
        END IF;

        ASSERT DQ /= 'Z'
            REPORT "Read OK - output HiZ"
            SEVERITY note;
    END PROCEDURE Check_Z;

----Check unknown
    PROCEDURE   Check_X (
        DQ   :  IN std_logic;
        SIGNAL check_err:  OUT std_logic) IS
    BEGIN
        ASSERT DQ = 'X'
            REPORT "output should be X"
            SEVERITY error;

        IF DQ /= 'X' THEN
            check_err <= '1';
        ELSE
            check_err <= '0';
        END IF;

        ASSERT DQ /= 'X'
            REPORT "Read OK - output X"
            SEVERITY note;
    END PROCEDURE Check_X;

    PROCEDURE   Check_U (
        DQ   :  IN std_logic;
        SIGNAL check_err:  OUT std_logic) IS
    BEGIN
        ASSERT DQ = 'U'
            REPORT "output should be U"
            SEVERITY error;

        IF DQ /= 'U' THEN
            check_err <= '1';
        ELSE
            check_err <= '0';
        END IF;

        ASSERT DQ /= 'U'
            REPORT "Read OK - output U"
            SEVERITY note;
    END PROCEDURE Check_U;

----Check read from Security Region memory
    PROCEDURE   Check_secr_read (
        DQ     :  IN std_logic_vector(7 downto 0);
        otp_mem:  IN NATURAL;
        SIGNAL check_err:  OUT std_logic) IS
    BEGIN
        ASSERT to_nat(DQ) = otp_mem
            REPORT "READ: expected data  =" &
            to_int_str(otp_mem)&" got " &
            to_int_str(DQ)
            SEVERITY error;

        ASSERT to_nat(DQ)/=otp_mem
            REPORT "READ: OK - "&
            to_hex_str(DQ)
            SEVERITY note;

        IF to_nat(DQ)/=otp_mem THEN
            check_err <= '1';
        ELSE
            check_err <= '0';
        END IF;
    END PROCEDURE Check_secr_read;

----Check JEDEC manuf. and device ID
    PROCEDURE   Check_read_JID (
        DQ               :  IN std_logic_vector(7 downto 0);
        VDATA            :  IN NATURAL;
        SIGNAL check_err :  OUT std_logic) IS
    BEGIN

        ASSERT to_nat(DQ(7 downto 0)) = VDATA
            REPORT "READ ID: expected data =" &
            to_hex_str(VDATA)&" got " &
            to_hex_str(DQ(7 downto 0))
            SEVERITY error;

        ASSERT to_nat(DQ(7 downto 0))/=VDATA
            REPORT "READ ID: OK - "&
            to_hex_str(DQ(7 downto 0))
            SEVERITY note;

        IF to_nat(DQ(7 downto 0))/=VDATA THEN
            check_err <= '1';
        ELSE
            check_err <= '0';
        END IF;
    END PROCEDURE Check_read_JID;

----Check device ID
    PROCEDURE   Check_read_DevID (
        DQ               :  IN std_logic_vector(7 downto 0);
        VDATA            :  IN NATURAL;
        SIGNAL check_err :  OUT std_logic) IS
    BEGIN

        ASSERT to_nat(DQ(7 downto 0)) = VDATA
            REPORT "READ DeviceID: expected data =" &
            to_hex_str(VDATA)&" got " &
            to_hex_str(DQ(7 downto 0))
            SEVERITY error;

        ASSERT to_nat(DQ(7 downto 0))/=VDATA
            REPORT "READ DeviceID: OK - "&
            to_hex_str(DQ(7 downto 0))
            SEVERITY note;

        IF to_nat(DQ(7 downto 0))/=VDATA THEN
            check_err <= '1';
        ELSE
            check_err <= '0';
        END IF;
    END PROCEDURE Check_read_DevID;

----Check read from SFDP table
    PROCEDURE   Check_read_SFDP (
        DQ     :  IN std_logic_vector(7 downto 0);
        VDATA            :  IN NATURAL;
        SIGNAL check_err:  OUT std_logic) IS
    BEGIN
        ASSERT to_nat(DQ) = VDATA
            REPORT "READ SFDP: expected data  =" &
            to_hex_str(VDATA)&" got " &
            to_hex_str(DQ)
            SEVERITY error;

        ASSERT to_nat(DQ)/=VDATA
            REPORT "READ SFDP: OK - "&
            to_hex_str(DQ)
            SEVERITY note;

        IF to_nat(DQ)/=VDATA THEN
            check_err <= '1';
        ELSE
            check_err <= '0';
        END IF;
    END PROCEDURE Check_read_SFDP;

----Check read from Unique ID
    PROCEDURE   Check_read_UID (
        DQ     :  IN std_logic_vector(7 downto 0);
        VDATA            :  IN NATURAL;
        SIGNAL check_err:  OUT std_logic) IS
    BEGIN
        ASSERT to_nat(DQ) = VDATA
            REPORT "READ UID: expected data  =" &
            to_hex_str(VDATA)&" got " &
            to_hex_str(DQ)
            SEVERITY error;

        ASSERT to_nat(DQ)/=VDATA
            REPORT "READ UID: OK - "&
            to_hex_str(DQ)
            SEVERITY note;

        IF to_nat(DQ)/=VDATA THEN
            check_err <= '1';
        ELSE
            check_err <= '0';
        END IF;
    END PROCEDURE Check_read_UID;

----Check read from Status and Configuration registers
    PROCEDURE   Check_read_reg (
        DQ     :  IN std_logic_vector(7 downto 0);
        VDATA            :  IN NATURAL;
        sts              :  IN NATURAL;
        SIGNAL check_err:  OUT std_logic) IS
    BEGIN
        IF to_nat(DQ) /= VDATA THEN
            IF sts=0 THEN
                REPORT "READ SR1 : expected data  =" &
                to_hex_str(VDATA)&" got " &
                to_hex_str(DQ)
                SEVERITY error;
            ELSIF sts=1 THEN
                REPORT "READ SR2 : expected data  =" &
                to_hex_str(VDATA)&" got " &
                to_hex_str(DQ)
                SEVERITY error;
            ELSIF sts=2 THEN
                REPORT "READ CR1 : expected data  =" &
                to_hex_str(VDATA)&" got " &
                to_hex_str(DQ)
                SEVERITY error;
            ELSIF sts=3 THEN
                REPORT "READ CR2 : expected data  =" &
                to_hex_str(VDATA)&" got " &
                to_hex_str(DQ)
                SEVERITY error;
            ELSIF sts=4 THEN
                REPORT "READ CR3 : expected data  =" &
                to_hex_str(VDATA)&" got " &
                to_hex_str(DQ)
                SEVERITY error;
            END IF;
        END IF;

        IF to_nat(DQ) = VDATA THEN
            IF sts=0 THEN
                REPORT "READ SR1 : OK - "&
                to_hex_str(DQ)
                SEVERITY note;
            ELSIF sts=1 THEN
                REPORT "READ SR2 : OK - "&
                to_hex_str(DQ)
                SEVERITY note;
            ELSIF sts=2 THEN
                REPORT "READ CR1 : OK - "&
                to_hex_str(DQ)
                SEVERITY note;
            ELSIF sts=3 THEN
                REPORT "READ CR2 : OK - "&
                to_hex_str(DQ)
                SEVERITY note;
            ELSIF sts=4 THEN
                REPORT "READ CR3 : OK - "&
                to_hex_str(DQ)
                SEVERITY note;
            END IF;
        END IF;

        IF to_nat(DQ)/=VDATA THEN
            check_err <= '1';
        ELSE
            check_err <= '0';
        END IF;
    END PROCEDURE Check_read_reg;

----Check read all registers
    PROCEDURE   Check_rdar (
        DQ   :  IN std_logic_vector(7 downto 0);
        D_mem:  IN NATURAL;
        SIGNAL check_err:  OUT std_logic) IS
    BEGIN
        ASSERT to_nat(DQ) = D_mem
            REPORT "Read All Register: expected data = " &
            to_hex_str(D_mem) & " got " & to_hex_str(DQ)
            SEVERITY error;

        ASSERT to_nat(DQ) /= D_mem
            REPORT "Read All Register: OK - "& to_hex_str(DQ)
            SEVERITY note;
        IF to_nat(DQ)/=D_mem THEN
            check_err <= '1';
        ELSE
            check_err <= '0';
        END IF;
    END PROCEDURE Check_rdar;

----Check read IRP register
    PROCEDURE   Check_read_irp (
        DQ   :  IN std_logic_vector(15 downto 0);
        D_mem:  IN NATURAL;
        SIGNAL check_err:  OUT std_logic) IS
    BEGIN
        ASSERT to_nat(DQ) = D_mem
            REPORT "Read IRP Register: expected data = " &
            to_int_str(D_mem) & " got " & to_int_str(DQ)
            SEVERITY error;

        ASSERT to_nat(DQ) /= D_mem
            REPORT "Read IRP Register: OK - "& to_int_str(DQ)
            SEVERITY note;
        IF to_nat(DQ)/=D_mem THEN
            check_err <= '1';
        ELSE
            check_err <= '0';
        END IF;
    END PROCEDURE Check_read_irp;

----Check read Password Register
    PROCEDURE   Check_read_pass_reg (
        DQ   :  IN std_logic_vector(63 downto 0);
        D_mem:  IN NATURAL;
        SIGNAL check_err:  OUT std_logic) IS
    BEGIN
        ASSERT to_nat(DQ) = D_mem
            REPORT "Read Password Register: expected data = " &
            to_hex_str(D_mem) & " got " & to_hex_str(DQ)
            SEVERITY error;

        ASSERT to_nat(DQ) /= D_mem
            REPORT "Read Password Register: OK - "& to_hex_str(DQ)
            SEVERITY note;
        IF to_nat(DQ)/=D_mem THEN
            check_err <= '1';
        ELSE
            check_err <= '0';
        END IF;
    END PROCEDURE Check_read_pass_reg;

-- ----Check PR register
    PROCEDURE   Check_read_pr (
        DQ   :  IN std_logic_vector(7 downto 0);
        D_mem:  IN NATURAL;
        SIGNAL check_err:  OUT std_logic) IS
    BEGIN
        ASSERT to_nat(DQ) = D_mem
            REPORT "Read PR Register: expected data = " &
            to_int_str(D_mem) & " got " & to_int_str(DQ)
            SEVERITY error;

        ASSERT to_nat(DQ) /= D_mem
            REPORT "Read PR Register: OK - "& to_int_str(DQ)
            SEVERITY note;
        IF to_nat(DQ)/=D_mem THEN
            check_err <= '1';
        ELSE
            check_err <= '0';
        END IF;
    END PROCEDURE Check_read_pr;

----Check WIP bit
    PROCEDURE   Check_WIP_bit (
        DQ   :  IN std_logic;
        sts  :  IN  status_type;
        SIGNAL check_err:  OUT std_logic) IS
    BEGIN
        IF DQ = '1' THEN
            ASSERT sts = rd_wip_1
                REPORT "Write in progress "&
                       "ERROR: command should be ignored"
                SEVERITY error;

            IF sts /= rd_wip_1 THEN
                check_err <= '1';
            ELSE
                check_err <= '0';
            END IF;

            ASSERT sts /= rd_wip_1
                REPORT "Write In progress"
                SEVERITY note;
        ELSE
            ASSERT sts = rd_wip_0
                REPORT "Write is NOT in progress "&
                       "   command NOT accepted"
                SEVERITY error;

            IF sts /= rd_wip_0 THEN
                check_err <= '1';
            ELSE
                check_err <= '0';
            END IF;

            ASSERT sts /= rd_wip_0
                REPORT "Write is NOT in progress "
                SEVERITY note;
        END IF;
    END PROCEDURE Check_WIP_bit;

----Check WEL bit
    PROCEDURE   Check_WEL_bit (
        DQ   :  IN std_logic;
        sts  :  IN  status_type;
        SIGNAL check_err:  OUT std_logic) IS
    BEGIN
        IF DQ = '1' THEN
            ASSERT sts = rd_wel_1
                REPORT " WEL=0 "&
                       "ERROR: command should be ignored"
                SEVERITY error;

            IF sts /= rd_wel_1 THEN
                check_err <= '1';
            ELSE
                check_err <= '0';
            END IF;

            ASSERT sts /= rd_wel_1
                REPORT "WEL = 1; Operation in progress"
                SEVERITY note;
        ELSE
            ASSERT sts = rd_wel_0
                REPORT "WEL = 1 "&
                       "ERROR: command NOT accepted"
                SEVERITY error;

            IF sts /= rd_wel_0 THEN
                check_err <= '1';
            ELSE
                check_err <= '0';
            END IF;

            ASSERT sts /= rd_wel_0
                REPORT " WEL=0; Operation completed "
                SEVERITY note;
        END IF;
    END PROCEDURE Check_WEL_bit;

----Check Erase operation bit
    PROCEDURE   Check_eers_bit (
        DQ   :  IN std_logic;
        sts  :  IN  status_type;
        SIGNAL check_err:  OUT std_logic) IS
    BEGIN
        IF DQ = '1' THEN
            ASSERT sts = erase_nosucc
                REPORT "Erase Operation ERROR"
                SEVERITY error;

            IF sts /= erase_nosucc THEN
                check_err <= '1';
            ELSE
                check_err <= '0';
            END IF;

            ASSERT sts /= erase_nosucc
                REPORT "Erase Operation failed"
                SEVERITY note;
        ELSE
            ASSERT sts = erase_succ
                REPORT "Erase Operation successful "
                SEVERITY error;

            IF sts /=  erase_succ THEN
                check_err <= '1';
            ELSE
                check_err <= '0';
            END IF;

            ASSERT sts /= erase_succ
                REPORT "Erase Operation OK "
                SEVERITY note;
        END IF;
    END PROCEDURE Check_eers_bit;

----Check Program operation bit
    PROCEDURE   Check_epgm_bit (
        DQ   :  IN std_logic;
        sts  :  IN  status_type;
        SIGNAL check_err:  OUT std_logic) IS
    BEGIN
        IF DQ = '1' THEN
            ASSERT sts = pgm_nosucc
                REPORT "Program Operation ERROR"
                SEVERITY error;

            IF sts /= pgm_nosucc THEN
                check_err <= '1';
            ELSE
                check_err <= '0';
            END IF;

            ASSERT sts /= pgm_nosucc
                REPORT "Program Operation failed"
                SEVERITY note;
        ELSE
            ASSERT sts = pgm_succ
                REPORT "Program Operation successful "
                SEVERITY error;

            IF sts /=  pgm_succ THEN
                check_err <= '1';
            ELSE
                check_err <= '0';
            END IF;

            ASSERT sts /= pgm_succ
                REPORT "Program Operation OK "

                SEVERITY note;
        END IF;
    END PROCEDURE Check_epgm_bit;

----Check Program Suspend bit
    PROCEDURE Check_PS_bit (
        DQ   :  IN std_logic;
        sts  :  IN  status_type;
        SIGNAL check_err:  OUT std_logic) IS
    BEGIN
        IF DQ = '1' THEN
            ASSERT sts = rd_ps_1
                REPORT "Program Suspend ERROR"
                SEVERITY error;

            IF sts /= rd_ps_1 THEN
                check_err <= '1';
            ELSE
                check_err <= '0';
            END IF;

            ASSERT sts /= rd_ps_1
                REPORT "Program Suspend mode: active"
                SEVERITY note;
        ELSE
            ASSERT sts = rd_ps_0
                REPORT "Program Suspend successful "
                SEVERITY error;

            IF sts /=  rd_ps_0 THEN
                check_err <= '1';
            ELSE
                check_err <= '0';
            END IF;

            ASSERT sts /= rd_ps_0
                REPORT "Program not in Suspend "

                SEVERITY note;
        END IF;
    END PROCEDURE Check_PS_bit;

----Check Erase Suspend bit
    PROCEDURE Check_ES_bit (
        DQ   :  IN std_logic;
        sts  :  IN  status_type;
        SIGNAL check_err:  OUT std_logic) IS
    BEGIN
        IF DQ = '1' THEN
            ASSERT sts = rd_es_1
                REPORT "Erase Suspend ERROR"
                SEVERITY error;

            IF sts /= rd_es_1 THEN
                check_err <= '1';
            ELSE
                check_err <= '0';
            END IF;

            ASSERT sts /= rd_es_1
                REPORT "Erase Suspend mode: active"
                SEVERITY note;
        ELSE
            ASSERT sts = rd_es_0
                REPORT "Erase Suspend successful "
                SEVERITY error;

            IF sts /=  rd_es_0 THEN
                check_err <= '1';
            ELSE
                check_err <= '0';
            END IF;

            ASSERT sts /= rd_es_0
                REPORT "Erase not in Suspend "

                SEVERITY note;
        END IF;
    END PROCEDURE Check_ES_bit;

----Check read DLP Register
    PROCEDURE   Check_read_dlp (
        DQ     :  IN std_logic_vector(7 downto 0);
        DLP_reg:  IN NATURAL;
        SIGNAL check_err:  OUT std_logic) IS
    BEGIN
        ASSERT to_nat(DQ) = DLP_reg
            REPORT "Read DLP Register: expected data = " &
            to_int_str(DLP_reg) & " got " & to_int_str(DQ)
            SEVERITY error;
        ASSERT to_nat(DQ) /= DLP_reg
            REPORT "Read DLP Register: OK - "& to_int_str(DQ)
            SEVERITY note;

        IF to_nat(DQ)/=DLP_reg THEN
            check_err <= '1';
        ELSE
            check_err <= '0';
        END IF;

    END PROCEDURE Check_read_dlp;

----Check IBL access register
    PROCEDURE   Check_IBL_reg (
        DQ   :  IN std_logic_vector(7 downto 0);
        sts  :  IN  status_type;
        SIGNAL check_err:  OUT std_logic) IS
    BEGIN
        IF DQ = "11111111" THEN
            ASSERT sts = read_ibl_1
                REPORT "IBL register read ERROR"
                SEVERITY error;

            IF sts /= read_ibl_1 THEN
                check_err <= '1';
            ELSE
                check_err <= '0';
            END IF;

            ASSERT sts /= read_ibl_1
                REPORT "IBL register read CORRECT"
                SEVERITY note;
        ELSIF DQ = "00000000" THEN
            ASSERT sts = read_ibl_0
                REPORT "IBL register read ERROR "
                SEVERITY error;

            IF sts /= read_ibl_0 THEN
                check_err <= '1';
            ELSE
                check_err <= '0';
            END IF;

            ASSERT sts /= read_ibl_0
                REPORT "IBL register read CORRECT "
                SEVERITY note;
        END IF;
    END PROCEDURE Check_IBL_reg;

END PACKAGE BODY spansion_tc_pkg;
