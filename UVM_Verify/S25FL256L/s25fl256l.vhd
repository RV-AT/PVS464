-------------------------------------------------------------------------------
--  File Name: s25fl256l.vhd
-------------------------------------------------------------------------------
--  Copyright (C) 2015 Spansion, LLC.
--
--  MODIFICATION HISTORY:
--
--  version: |  author:    | mod date: |  changes made:
--    V1.0    M.Stojanovic   16 Feb 19    Initial version
--    V1.1    M.Stojanovic   17 Mar 16    Bug 3439 fixed -
--                                        four byte address commands
--                                        depend on CR2_V(0)
--
-------------------------------------------------------------------------------
--  PART DESCRIPTION:
--
--  Library:    FLASH
--  Technology: FLASH MEMORY
--  Part:       S25FL256L
--
--   Description: 256 Megabit Serial Flash Memory
--
-------------------------------------------------------------------------------
--  Comments :
--      For correct simulation, simulator resolution should be set to 1 ps
--      A device ordering (trim) option determines whether a feature is enabled
--      or not, or provide relevant parameters:
--        -15th character in TimingModel determines if enhanced high
--         performance option is available
--            (0,1,3,4,5) General Market
--            (Y,Z)       Secure
--
--------------------------------------------------------------------------------
--  Known Bugs:
--
--------------------------------------------------------------------------------
LIBRARY IEEE;   USE IEEE.std_logic_1164.ALL;
                USE STD.textio.ALL;
                USE IEEE.VITAL_timing.ALL;
                USE IEEE.VITAL_primitives.ALL;

LIBRARY FMF;    USE FMF.gen_utils.ALL;
                USE FMF.conversions.ALL;
-------------------------------------------------------------------------------
-- ENTITY DECLARATION
-------------------------------------------------------------------------------
ENTITY s25fl256l IS
    GENERIC (
    ---------------------------------------------------------------------------
    -- TIMING GENERICS:
    ---------------------------------------------------------------------------
        -- tipd delays: interconnect path delays (delay between components)
        --    There should be one for each IN or INOUT pin in the port list
        --    They are given default values of zero delay.
        tipd_SCK                : VitalDelayType01  := VitalZeroDelay01;
        tipd_SI                 : VitalDelayType01  := VitalZeroDelay01;
        tipd_SO                 : VitalDelayType01  := VitalZeroDelay01;
        tipd_CSNeg              : VitalDelayType01  := VitalZeroDelay01;
        tipd_RESETNeg           : VitalDelayType01  := VitalZeroDelay01;
        tipd_WPNeg              : VitalDelayType01  := VitalZeroDelay01;
        tipd_IO3RESETNeg        : VitalDelayType01  := VitalZeroDelay01;

        -- tpd delays: propagation delays (pin-to-pin delay within a component)
        tpd_SCK_SO              : VitalDelayType01Z := UnitDelay01Z; -- tV
        tpd_CSNeg_SO_RST_QUAD_EQ_1 : VitalDelayType01Z := UnitDelay01Z; -- tDIS
        tpd_CSNeg_SO_RST_QUAD_EQ_0 : VitalDelayType01Z := UnitDelay01Z; -- tDIS

        -- tsetup values: setup times
        --   setup time is minimum time before the referent signal edge the
        --   input should be stable
        tsetup_CSNeg_SCK       : VitalDelayType := UnitDelay; -- tCSS /
        tsetup_SI_SCK          : VitalDelayType := UnitDelay; -- tSU:DAT /
        tsetup_WPNeg_CSNeg     : VitalDelayType := UnitDelay; -- tWPS \

        -- thold values: hold times
        --   hold time is minimum time the input should be present stable
        --   after the referent signal edge
        thold_CSNeg_SCK        : VitalDelayType := UnitDelay; -- tCSH /
        thold_SI_SCK           : VitalDelayType := UnitDelay; -- tHD:DAT /
        thold_WPNeg_CSNeg      : VitalDelayType := UnitDelay; -- tWPH /
        thold_CSNeg_RESETNeg   : VitalDelayType := UnitDelay; -- tRH
        thold_CSNeg_IO3RESETNeg: VitalDelayType := UnitDelay; -- tRH

        --tpw values: pulse width
        tpw_SCK_normal_rd      : VitalDelayType := UnitDelay;
        tpw_SCK_fast_rd        : VitalDelayType := UnitDelay;
        tpw_SCK_ddr_rd         : VitalDelayType := UnitDelay;
        tpw_SCK_reg_rd         : VitalDelayType := UnitDelay;
        tpw_CSNeg              : VitalDelayType := UnitDelay; -- tCS
        tpw_RESETNeg           : VitalDelayType := UnitDelay; -- tRP
        tpw_IO3RESETNeg        : VitalDelayType := UnitDelay; -- tRP

        -- tperiod min (calculated as 1/max freq)
        tperiod_SCK_normal_rd  : VitalDelayType := UnitDelay; --fSCK=50MHz
        tperiod_SCK_fast_rd    : VitalDelayType := UnitDelay; --fSCK=133MHz
        tperiod_SCK_ddr_rd     : VitalDelayType := UnitDelay; --fSCK=80MHz
        tperiod_SCK_reg_rd     : VitalDelayType := UnitDelay; --fSCK=108MHz

        -- tdevice values: values for internal delays
        --timing values that are internal to the model and not associated
        --with any port.
        -- WRR Cycle Time
        tdevice_WRR             : VitalDelayType := 750 ms;  --tW
        -- Page Program Operation
        tdevice_PP              : VitalDelayType := 900 us;  --tPP

        -- Byte Programming
        tdevice_BP1             : VitalDelayType := 25 us;  --tBP1
        -- Byte Programming
        tdevice_BP2             : VitalDelayType := 20 us;  --tBP2

        -- 4 KB Sector Erase Operation
        tdevice_SE              : VitalDelayType := 200 ms; --tSE
        -- 32 KB Half Block Erase Operation
        tdevice_HBE             : VitalDelayType := 363 ms; --tHBE
        -- 64 KB Block Erase Operation
        tdevice_BE              : VitalDelayType := 725 ms; --tBE

        -- Chip Erase Operation
        tdevice_CE              : VitalDelayType := 360 sec; --tCE
        -- Suspend latency
        tdevice_SUSP            : VitalDelayType := 40 us;   --tSL
        -- Resume to next Suspend Time
        tdevice_RNS             : VitalDelayType := 100 us;   --tRS
        -- RESET# Low to CS# Low
        tdevice_RPH             : VitalDelayType := 100 us;   --tRPH
        -- CS# High before HW Reset (Quad mode and Reset Feature are enabled)
        -- Volatile registers write time
        tdevice_CS              : VitalDelayType := 50 ns;   --tRPH
        -- VDD (min) to CS# Low
        tdevice_PU              : VitalDelayType := 300 us;  --tPU
        -- Password Unlock to Password Unlock Time
        tdevice_PASSACC         : VitalDelayType := 100 us;  --
        -- CS# High to Power Down Mode
        -- DPD enter
        tdevice_DPD             : VitalDelayType := 3 us;   -- tDPD
        -- CS# High to StandBy mode without Electronic Signature read
        -- Release DPD
        tdevice_RES             : VitalDelayType := 3 us;  --tRES
        -- QIO, QPI mode enter to the next command
        tdevice_QEN             : VitalDelayType := 1.5 us;  --
        -- QIO, QPI mode exit to the next command
        tdevice_QEXN            : VitalDelayType := 1 us;  --

    ---------------------------------------------------------------------------
    -- CONTROL GENERICS:
    ---------------------------------------------------------------------------
        -- generic control parameters
        InstancePath      : STRING    := DefaultInstancePath;
        TimingChecksOn    : BOOLEAN   := DefaultTimingChecks;
        MsgOn             : BOOLEAN   := DefaultMsgOn;
        XOn               : BOOLEAN   := DefaultXon;
        -- memory file to be loaded
        mem_file_name     : STRING    := "s25fl256l.mem";
        secr_file_name    : STRING    := "s25fl256lSECR.mem";

        UserPreload       : BOOLEAN   := FALSE;
        LongTimming       : BOOLEAN   := TRUE;

        BootConfig        : BOOLEAN   := TRUE;

        -- For FMF SDF technology file usage
        TimingModel       : STRING
    );
    PORT (
        -- Data Inputs/Outputs
        SI                : INOUT std_ulogic := 'U'; -- serial data input/IO0
        SO                : INOUT std_ulogic := 'U'; -- serial data output/IO1
        -- Controls
        SCK               : IN    std_ulogic := 'U'; -- serial clock input
        CSNeg             : IN    std_ulogic := 'U'; -- chip select input
        WPNeg             : INOUT std_ulogic := 'U'; -- write protect input/IO2
        RESETNeg          : INOUT std_ulogic := 'U'; -- hold input/IO3
        IO3RESETNeg       : INOUT std_ulogic := 'U'  -- hold input/IO3
    );

    ATTRIBUTE VITAL_LEVEL0 of s25fl256l : ENTITY IS TRUE;
END s25fl256l;

-------------------------------------------------------------------------------
-- ARCHITECTURE DECLARATION
-------------------------------------------------------------------------------

ARCHITECTURE vhdl_behavioral_static_memory_allocation of s25fl256l IS
    ATTRIBUTE VITAL_LEVEL0 OF
    vhdl_behavioral_static_memory_allocation : ARCHITECTURE IS TRUE;

    ---------------------------------------------------------------------------
    -- CONSTANT AND SIGNAL DECLARATION
    ---------------------------------------------------------------------------
    --Declaration of constants - memory characteristics
        -- The constant declared here are used to enable the creation of models
        -- of memories within a family with a minimum amount of editing

    CONSTANT PartID        : STRING  := "s25fl256l";
    CONSTANT MaxData       : NATURAL := 16#FF#; --255;
    CONSTANT MemSize       : NATURAL := 16#1FFFFFF#;
    CONSTANT PageSize      : NATURAL := 16#FF#;
    CONSTANT SecRegSize    : NATURAL := 16#FF#;
    CONSTANT SecSize       : NATURAL := 16#FFF#;
    CONSTANT AddrRANGE     : NATURAL := 16#1FFFFFF#;
    CONSTANT HalfBlockSize : NATURAL := 16#7FFF#;
    CONSTANT BlockSize     : NATURAL := 16#FFFF#;
    CONSTANT SecNum        : NATURAL := 16#1FFF#;
    CONSTANT BlockNum      : NATURAL := 16#1FF#;
    CONSTANT HalfBlockNum  : NATURAL := 16#3FF#;
    CONSTANT SecRegNum     : NATURAL := 3;
    CONSTANT PageNum       : NATURAL := 16#1FFFF#;
    CONSTANT SECRLoAddr    : NATURAL := 16#000#;
    CONSTANT SECRHiAddr    : NATURAL := 16#3FF#;
    CONSTANT SFDPLoAddr    : NATURAL := 16#0000#;
    CONSTANT SFDPHiAddr    : NATURAL := 16#5FF#;
    CONSTANT SFDPLength    : NATURAL := 16#5FF#;
    CONSTANT IDCFILength   : NATURAL := 16#115#;

    -- Declaration of signals that will hold the delayed values of ports
    SIGNAL SI_ipd          : std_ulogic := 'U';
    SIGNAL SO_ipd          : std_ulogic := 'U';
    SIGNAL SCK_ipd         : std_ulogic := 'U';
    SIGNAL CSNeg_ipd       : std_ulogic := 'U';
    SIGNAL RESETNeg_ipd    : std_ulogic := 'U';
    SIGNAL WPNeg_ipd       : std_ulogic := 'U';
    SIGNAL IO3RESETNeg_ipd : std_ulogic := 'U';

    SIGNAL IO3RESETNeg_pullup : std_ulogic := 'U';
    SIGNAL RESETNeg_pullup : std_ulogic := 'U';
    SIGNAL WPNeg_pullup    : std_ulogic := 'U';

    SIGNAL ManufIDDeviceID :std_logic_vector(23 DOWNTO 0) := x"196001";
    SIGNAL DeviceID        :std_logic_vector(15 DOWNTO 0) := x"6019";
    SIGNAL UID             :std_logic_vector(63 DOWNTO 0) := (OTHERS => '0');

    -- internal delays
    SIGNAL WRR_in          : std_ulogic := '0';
    SIGNAL WRR_out         : std_ulogic := '0';
    SIGNAL PP_in           : std_ulogic := '0';
    SIGNAL PP_out          : std_ulogic := '0';
    SIGNAL BP1_in          : std_ulogic := '0';
    SIGNAL BP1_out         : std_ulogic := '0';
    SIGNAL BP2_in          : std_ulogic := '0';
    SIGNAL BP2_out         : std_ulogic := '0';
    SIGNAL SE_in           : std_ulogic := '0';
    SIGNAL SE_out          : std_ulogic := '0';
    SIGNAL HBE_in          : std_ulogic := '0';
    SIGNAL HBE_out         : std_ulogic := '0';
    SIGNAL BE_in           : std_ulogic := '0';
    SIGNAL BE_out          : std_ulogic := '0';
    SIGNAL CE_in           : std_ulogic := '0';
    SIGNAL CE_out          : std_ulogic := '0';
    SIGNAL ERSSUSP_in      : std_ulogic := '0';
    SIGNAL ERSSUSP_out     : std_ulogic := '0';
    SIGNAL PRGSUSP_in      : std_ulogic := '0';
    SIGNAL PRGSUSP_out     : std_ulogic := '0';
    SIGNAL ERSSUSP_tmp_in  : std_ulogic := '0';
    SIGNAL ERSSUSP_tmp_out : std_ulogic := '0';
    SIGNAL PRGSUSP_tmp_in  : std_ulogic := '0';
    SIGNAL PRGSUSP_tmp_out : std_ulogic := '0';
    SIGNAL RNS_in          : std_ulogic := '0';
    SIGNAL RNS_out         : std_ulogic := '0';
    SIGNAL RPH_in          : std_ulogic := '0';
    SIGNAL RPH_out         : std_ulogic := '0';
    SIGNAL CS_in           : std_ulogic := '0';
    SIGNAL CS_out          : std_ulogic := '1';
    SIGNAL PU_in           : std_ulogic := '0';
    SIGNAL PU_out          : std_ulogic := '0';
    SIGNAL PASSULCK_in     : std_ulogic := '0';
    SIGNAL PASSULCK_out    : std_ulogic := '0';
    SIGNAL SFT_RST_in      : std_ulogic := '0';
    SIGNAL SFT_RST_out     : std_ulogic := '1';
    SIGNAL HW_RST_in       : std_ulogic := '0';
    SIGNAL HW_RST_out      : std_ulogic := '1';
    SIGNAL DPD_in          : std_ulogic := '0';
    SIGNAL DPD_out         : std_ulogic := '0';
    SIGNAL RES_in          : std_ulogic := '0';
    SIGNAL RES_out         : std_ulogic := '0';
    SIGNAL QEN_in          : std_ulogic := '0';
    SIGNAL QEN_out         : std_ulogic := '0';
    SIGNAL QEXN_in         : std_ulogic := '0';
    SIGNAL QEXN_out        : std_ulogic := '0';

    SIGNAL SECURE_OPN      : std_logic := '0';
    SIGNAL QIO_ONLY_OPN    : std_logic := '0';
    SIGNAL QPI_ONLY_OPN    : std_logic := '0';

BEGIN
    ---------------------------------------------------------------------------
    -- Internal Delays
    ---------------------------------------------------------------------------
    -- Artificial VITAL primitives to incorporate internal delays
    -- Because a tdevice generics is used, there must be a VITAL_primitives
    -- assotiated with them
    WRR    : VitalBuf(WRR_out,     WRR_in,    (tdevice_WRR     ,UnitDelay));
    PP     : VitalBuf(PP_out,      PP_in,     (tdevice_PP      ,UnitDelay));
    BP1    : VitalBuf(BP1_out,     BP1_in,    (tdevice_BP1     ,UnitDelay));
    BP2    : VitalBuf(BP2_out,     BP2_in,    (tdevice_BP2     ,UnitDelay));
    SE     : VitalBuf(SE_out,      SE_in,     (tdevice_SE      ,UnitDelay));
    HBE    : VitalBuf(HBE_out,     HBE_in,    (tdevice_HBE     ,UnitDelay));
    BE     : VitalBuf(BE_out,      BE_in,     (tdevice_BE      ,UnitDelay));
    CE     : VitalBuf(CE_out,      CE_in,     (tdevice_CE      ,UnitDelay));
    ESUSP  : VitalBuf(ERSSUSP_tmp_out, ERSSUSP_tmp_in, (tdevice_SUSP
                                                             ,UnitDelay));
    PSUSP  : VitalBuf(PRGSUSP_tmp_out, PRGSUSP_tmp_in, (tdevice_SUSP
                                                             ,UnitDelay));
    RNS    : VitalBuf(RNS_out,     RNS_in,    (tdevice_RNS     ,UnitDelay));
    RPH    : VitalBuf(RPH_out,     RPH_in,    (tdevice_RPH     ,UnitDelay));
    CS     : VitalBuf(CS_out,      CS_in,     (tdevice_CS      ,UnitDelay));
    PU     : VitalBuf(PU_out,      PU_in,     (tdevice_PU      ,UnitDelay));
    DPD    : VitalBuf(DPD_out,     DPD_in,    (tdevice_DPD     ,UnitDelay));
    QEN    : VitalBuf(QEN_out,     QEN_in,    (tdevice_QEN     ,UnitDelay));
    QEXN   : VitalBuf(QEXN_out,    QEXN_in,   (tdevice_QEXN    ,UnitDelay));

    ---------------------------------------------------------------------------
    -- Wire Delays
    ---------------------------------------------------------------------------
    WireDelay : BLOCK
    BEGIN

        w_1 : VitalWireDelay (SI_ipd,      SI,      tipd_SI);
        w_2 : VitalWireDelay (SO_ipd,      SO,      tipd_SO);
        w_3 : VitalWireDelay (SCK_ipd,     SCK,     tipd_SCK);
        w_4 : VitalWireDelay (CSNeg_ipd,   CSNeg,   tipd_CSNeg);
        w_5 : VitalWireDelay (RESETNeg_ipd,RESETNeg,tipd_RESETNeg);
        w_6 : VitalWireDelay (WPNeg_ipd,   WPNeg,   tipd_WPNeg);
        w_7 : VitalWireDelay (IO3RESETNeg_ipd,IO3RESETNeg,tipd_IO3RESETNeg);

    END BLOCK;

    ---------------------------------------------------------------------------
    -- Main Behavior Block
    ---------------------------------------------------------------------------
    Behavior: BLOCK

        PORT (
            SIIn           : IN    std_ulogic := 'U';
            SIOut          : OUT   std_ulogic := 'U';
            SOIn           : IN    std_logic  := 'U';
            SOut           : OUT   std_logic  := 'U';
            SCK            : IN    std_ulogic := 'U';
            CSNeg          : IN    std_ulogic := 'U';
            RESETNegIn     : IN    std_ulogic := 'U';
            RESETNegOut    : OUT   std_ulogic := 'U';
            WPNegIn        : IN    std_ulogic := 'U';
            WPNegOut       : OUT   std_ulogic := 'U';
            IO3RESETNegIn  : IN    std_ulogic := 'U';
            IO3RESETNegOut : OUT   std_ulogic := 'U'
        );

        PORT MAP (
             SIIn       => SI_ipd,
             SIOut      => SI,
             SOIn       => SO_ipd,
             SOut       => SO,
             SCK        => SCK_ipd,
             CSNeg      => CSNeg_ipd,

             RESETNegIn  => RESETNeg_ipd,
             RESETNegOut => RESETNeg,
             WPNegIn    => WPNeg_ipd,
             WPNegOut   => WPNeg,
             IO3RESETNegIn  => IO3RESETNeg_ipd,
             IO3RESETNegOut => IO3RESETNeg
        );

        -- State Machine : State_Type
        TYPE state_type IS (STANDBY,
                            RESET_STATE,
                            RD_ADDR,
                            FAST_RD_ADDR,
                            DUALO_RD_ADDR,
                            DUALIO_RD_ADDR,
                            QUADO_RD_ADDR,
                            QUADIO_RD_ADDR,
                            DDRQUADIO_RD_ADDR,
                            DLPRD_DUMMY,
                            IRPRD_DUMMY,
                            IBLRD_ADDR,
                            SFT_RST_EN,
                            SECRR_ADDR,
                            PASSRD_DUMMY,
                            PRRD_DUMMY,
                            RDID_DATA_OUTPUT,
                            RDQID_DATA_OUTPUT,
                            RUID_DUMMY,
                            RSFDP_ADDR,
                            SET_BURST_DATA_INPUT,
                            RDSR1_DATA_OUTPUT,
                            RDSR2_DATA_OUTPUT,
                            RDCR1_DATA_OUTPUT,
                            RDCR2_DATA_OUTPUT,
                            RDCR3_DATA_OUTPUT,
                            RDAR_ADDR,
                            DPD,
                            RDP_DUMMY,
                            PGM_ADDR,
                            SECT_ERS_ADDR,
                            HALF_BLOCK_ERS_ADDR,
                            BLOCK_ERS_ADDR,
                            CHIP_ERS,
                            IBL_LOCK,
                            IRP_PGM_DATA_INPUT,
                            WRR_DATA_INPUT,
                            WRAR_ADDR,
                            PASSP_DATA_INPUT,
                            SEC_REG_PGM_ADDR,
                            SEC_REG_ERS_ADDR,
                            PASSU_DATA_INPUT,
                            IBL_UNLOCK,
                            SET_PNTR_PROT_ADDR,
                            PGM_NV_DLR_DATA,
                            DLRV_WRITE_DATA,
                            RD_DATA,
                            FAST_RD_DUMMY,
                            FAST_RD_DATA,
                            DUALO_RD_DUMMY,
                            DUALO_RD_DATA,
                            QUADO_RD_DUMMY,
                            QUADO_RD_DATA,
                            DUALIO_RD_DUMMY,
                            DUALIO_RD_MODE,
                            DUALIO_RD_DATA,
                            QUADIO_RD_DUMMY,
                            QUADIO_RD_MODE,
                            QUADIO_RD_DATA,
                            DDRQUADIO_RD_DUMMY,
                            DDRQUADIO_RD_MODE,
                            DDRQUADIO_RD_DATA,
                            RDAR_DUMMY,
                            RDAR_DATA_OUTPUT,
                            PGM_DATAIN,
                            PGM,
                            PGMSUS,
                            SECT_ERS,
                            HALF_BLOCK_ERS,
                            BLOCK_ERS,
                            ERSSUS,
                            SEC_REG_PGM_DATAIN,
                            PGM_SEC_REG,
                            SECT_ERS_SEC_REG,
                            DLPRD_DATA_OUTPUT,
                            IRPRD_DATA_OUTPUT,
                            IBLRD_DATA_OUTPUT,
                            SECRR_DUMMY,
                            SECRR_DATA_OUTPUT,
                            PASSRD_DATA_OUTPUT,
                            PRRD_DATA_OUTPUT,
                            RUID_DATA_OUTPUT,
                            RSFDP_DUMMY,
                            RSFDP_DATA_OUTPUT,
                            RDP_DATA_OUTPUT,
                            IRP_PGM,
                            WRR_NV,
                            WRR_V,
                            WRAR_DATA_INPUT,
                            WRAR_NV,
                            WRAR_V,
                            PGM_NV_DLR,
                            SET_PNTR_PROT,
                            PASS_PGM,
                            PASS_ULCK
                            );

        -- Instruction Type
        TYPE instruction_type IS ( NONE,
                                   READ,
                                   READ4,
                                   FAST_READ,
                                   FAST_READ4,
                                   DOR,
                                   DOR4,
                                   DIOR,
                                   DIOR4,
                                   QOR,
                                   QOR4,
                                   QIOR,
                                   QIOR4,
                                   DDRQIOR,
                                   DDRQIOR4,
                                   DLPRD,
                                   IRPRD,
                                   IBLRD,
                                   IBLRD4,
                                   RSTEN,
                                   SECRR,
                                   PASSRD,
                                   PRRD,
                                   RDID,
                                   RDQID,
                                   RUID,
                                   RSFDP,
                                   SET_BURST,
                                   BEN4,
                                   BEX4,
                                   QPIEN,
                                   QPIEX,
                                   RDSR1,
                                   RDSR2,
                                   RDCR1,
                                   RDCR2,
                                   RDCR3,
                                   RDAR,
                                   DEEP_PD,
                                   RES,
                                   WREN,
                                   WRENV,
                                   WRDI,
                                   CLSR,
                                   PP,
                                   PP4,
                                   QPP,
                                   QPP4,
                                   SE,
                                   SE4,
                                   HBE,
                                   HBE4,
                                   BE,
                                   BE4,
                                   CE,
                                   IBL,
                                   IBL4,
                                   IRPP,
                                   WRR,
                                   WRAR,
                                   PASSP,
                                   SECRP,
                                   SECRE,
                                   PASSU,
                                   PRL,
                                   IBUL,
                                   IBUL4,
                                   GBL,
                                   GBUL,
                                   SPRP,
                                   SPRP4,
                                   PDLRNV,
                                   WDLRV,
                                   EPS,
                                   EPR,
                                   RSTCMD
                                );

        TYPE SecType  IS ARRAY (0 TO 7) OF std_logic;
        TYPE DataArray IS ARRAY (0 TO PageSize) OF std_logic_vector(7 DOWNTO 0);
        TYPE WByteType IS ARRAY (0 TO 511) OF INTEGER RANGE -1 TO MaxData;
        -- Flash Memory Array
        TYPE MemArray IS ARRAY (0 TO AddrRANGE) OF INTEGER RANGE -1 TO MaxData;
        -- Security Region Array
        TYPE SECRMemArray IS ARRAY (SECRLoAddr TO SECRHiAddr) OF INTEGER
                                                    RANGE -1 TO MaxData;
        --CFI Array (Common Flash Interface Query codes)
        TYPE SFDPtype  IS ARRAY (0 TO SFDPLength) OF
                                              INTEGER RANGE -1 TO 16#FF#;
        -----------------------------------------------------------------------
        --  memory declaration
        -----------------------------------------------------------------------
        -- Main Memory
        SHARED VARIABLE Mem          : MemArray     := (OTHERS => MaxData);
        -- SECRMem Sector
        SHARED VARIABLE SECRMem      : SECRMemArray := (OTHERS => MaxData);
        --CFI Array
        --SFDP Array
        SHARED VARIABLE SFDP_array    : SFDPtype   := (OTHERS => 0);

        SHARED VARIABLE CFI_tmp1 : NATURAL RANGE 0 TO  MaxData;
        SHARED VARIABLE CFI_tmp : std_logic_vector(7 DOWNTO 0);

        SHARED VARIABLE SFDP_array_tmp :
                                std_logic_vector(8*(SFDPLength+1)-1 DOWNTO 0);
        SHARED VARIABLE SFDP_tmp : std_logic_vector(7 DOWNTO 0);

        SHARED VARIABLE Data_in  : DataArray := (OTHERS => (OTHERS => '1'));
        SHARED VARIABLE Byte_slv        : std_logic_vector(7 DOWNTO 0) := (OTHERS => '1');


        -- Programming Buffer
        SIGNAL WByte                 : WByteType := (OTHERS => MaxData);

        -- states
        SIGNAL current_state         : state_type;
        SIGNAL next_state            : state_type;

        SIGNAL Instruct              : instruction_type;
        SHARED VARIABLE Instruct_tmp : std_logic_vector(7 DOWNTO 0);
        SHARED VARIABLE mode_byte    : std_logic_vector(7 DOWNTO 0) := (OTHERS => '0');
        --zero delay signal
        SIGNAL SOut_zd               : std_logic := 'Z';
        SIGNAL SIOut_zd              : std_logic := 'Z';
        SIGNAL RESETNegOut_zd        : std_logic := 'Z';
        SIGNAL WPNegOut_zd           : std_logic := 'Z';
        SIGNAL IO3RESETNegOut_zd     : std_logic := 'Z';

        -- powerup
        SIGNAL PoweredUp             : std_logic := '0';

        -----------------------------------------------------------------------
        -- Registers
        -----------------------------------------------------------------------
        --     ***  Status Register 1  ***

        SIGNAL SR1_in : std_logic_vector(7 DOWNTO 0) := (OTHERS => '0');
        -- Nonvolatile Status Register 1
        SIGNAL SR1_NV : std_logic_vector(7 DOWNTO 0) := (OTHERS => '0');

        ALIAS SRWD_NV :std_logic IS SR1_NV(6);
        ALIAS BP2_NV  :std_logic IS SR1_NV(4);
        ALIAS BP1_NV  :std_logic IS SR1_NV(3);
        ALIAS BP0_NV  :std_logic IS SR1_NV(2);

        -- Volatile Status Register 1
        SIGNAL SR1_V  : std_logic_vector(7 DOWNTO 0) := (OTHERS => '0');

        -- Status Register Protect 0 Bit
        ALIAS SRP0    :std_logic IS SR1_V(7);
        -- Top or Bottom Relative Protection Bit
        ALIAS TBPROT  :std_logic IS SR1_V(6);
        -- Status Register Block Protection Bits
        ALIAS BP3     :std_logic IS SR1_V(5);
        ALIAS BP2     :std_logic IS SR1_V(4);
        ALIAS BP1     :std_logic IS SR1_V(3);
        ALIAS BP0     :std_logic IS SR1_V(2);
        -- Status Register Write Enable Latch Bit
        ALIAS WEL     :std_logic IS SR1_V(1);
        -- Status Register Write In Progress Bit
        ALIAS WIP     :std_logic IS SR1_V(0);

        -- Volatile Status Register 2
        SIGNAL SR2_V  : std_logic_vector(7 DOWNTO 0) := (OTHERS => '0');
        -- Erase Error Occurred
        ALIAS E_ERR   :std_logic IS SR2_V(6);
        -- Programming Error Occurred
        ALIAS P_ERR   :std_logic IS SR2_V(5);
        -- Erase suspend
        ALIAS ES      :std_logic IS SR2_V(1);
        -- Program suspend
        ALIAS PS      :std_logic IS SR2_V(0);

        -- Nonvolatile Configuration Register 1
        SIGNAL CR1_in : std_logic_vector(7 DOWNTO 0) := (OTHERS => '0');
        SIGNAL CR1_NV : std_logic_vector(7 DOWNTO 0) := (OTHERS => '0');
        --Volatile Configuration Register 1
        SIGNAL CR1_V  : std_logic_vector(7 DOWNTO 0) := (OTHERS => '0');
        -- Complement Protection bit
        ALIAS CMP     :std_logic IS CR1_V(6);
        -- Security Region Lock bit
        ALIAS LB3     :std_logic IS CR1_V(5);
        -- Security Region Lock bit
        ALIAS LB2     :std_logic IS CR1_V(4);
        -- Security Region Lock bit
        ALIAS LB1     :std_logic IS CR1_V(3);
        -- Security Region Lock bit
        ALIAS LB0     :std_logic IS CR1_V(2);
        -- Configuration Register QUAD bit
        ALIAS QUAD    :std_logic IS CR1_V(1);
        -- Status Register Protect 1 bit
        ALIAS SRP1    :std_logic IS CR1_V(0);

        SIGNAL CR2_in : std_logic_vector(7 DOWNTO 0) := (OTHERS => '0');
        -- Nonvolatile Configuration Register 2
        SIGNAL CR2_NV : std_logic_vector(7 DOWNTO 0) := "01100000";
        -- Volatile Configuration Register 2
        SIGNAL CR2_V  : std_logic_vector(7 DOWNTO 0) := "01100000";
        -- IO3_Reset
        ALIAS  IO3R   :std_logic IS CR2_V(7);
        -- QPI
        ALIAS  QPI    :std_logic IS CR2_V(3);
        -- Write Protect Selection bit
        ALIAS  WPS    :std_logic IS CR2_V(2);
        -- Address Length Status bit
        ALIAS  ADS    :std_logic IS CR2_V(0);

        SIGNAL CR3_in : std_logic_vector(7 DOWNTO 0) := (OTHERS => '0');
        -- Nonvolatile Configuration Register 3
        SIGNAL CR3_NV : std_logic_vector(7 DOWNTO 0) := "01111000";
        -- Volatile Configuration Register 3
        SIGNAL CR3_V  : std_logic_vector(7 DOWNTO 0) := "01111000";
        --  DLRV Register
        SHARED VARIABLE DLRV : std_logic_vector(7 DOWNTO 0) := (OTHERS => '0');
        SIGNAL DLRV_in       : std_logic_vector(7 DOWNTO 0) := (OTHERS => '0');

        -- DLRNV Register
        SHARED VARIABLE DLRNV : std_logic_vector(7 DOWNTO 0) := (OTHERS => '0');
        SIGNAL DLRNV_in       : std_logic_vector(7 DOWNTO 0) := (OTHERS => '0');
        --      ***  Password Register  ***
        SHARED VARIABLE Password_reg : std_logic_vector(63 DOWNTO 0) := (OTHERS => '1');
        SIGNAL Password_reg_in       : std_logic_vector(63 DOWNTO 0) := (OTHERS => '1');
        SIGNAL Password_regU_in      : std_logic_vector(63 DOWNTO 0) := (OTHERS => '0');
        --      ***  Individual and Region Protection Register  ***
        SHARED VARIABLE IRP          : std_logic_vector(15 DOWNTO 0) := "1111111111111101";
        SIGNAL IRP_in                : std_logic_vector(15 DOWNTO 0) := "1111111111111101";
        -- Password Protection Mode Lock Bit
        ALIAS PWDMLB  :std_logic IS IRP(2);

        SHARED VARIABLE WRR_reg_in   : std_logic_vector(31 DOWNTO 0) := (OTHERS => '0');
        --      ***  Protection Register  ***
        SHARED VARIABLE PR           : std_logic_vector(7 DOWNTO 0) := "01000001";
        SIGNAL PR_in                 : std_logic_vector(7 DOWNTO 0) := "01000001";
        --Security Regions Read Password bit
        ALIAS SECRRP  :std_logic IS PR(6);
        --Protect NV Configuration bit
        ALIAS NVLOCK  :std_logic IS PR(0);
        --      ***  Pointer Region Protect Register  ***
        SIGNAL PRPR           : std_logic_vector(31 DOWNTO 0) := (OTHERS => '1');
        SIGNAL PRPR_in        : std_logic_vector(31 DOWNTO 0) := (OTHERS => '1');
        --      ***  Individual Block Lock Access Register  ***
        SHARED VARIABLE IBLAR : std_logic_vector(7 DOWNTO 0) := (OTHERS => '0');
        --      ***  PPB Lock Register  ***
        SHARED VARIABLE PPBL  : std_logic_vector(7 DOWNTO 0) := "00000001";
        SIGNAL PPBL_in        : std_logic_vector(7 DOWNTO 0) := "00000001";
        --Persistent Protection Mode Lock Bit
        ALIAS PPB_LOCK        : std_logic IS PPBL(0);

        SHARED VARIABLE WRAR_in  : std_logic_vector(7 DOWNTO 0) := (OTHERS => '0');
        SHARED VARIABLE RDAR_reg : std_logic_vector(7 DOWNTO 0) := (OTHERS => '0');

        SIGNAL normal_rd          : boolean  := false;
        SIGNAL fast_rd            : boolean  := true;
        SIGNAL ddr_rd             : boolean  := false;
        SIGNAL reg_rd             : boolean  := false;
        SIGNAL frst_addr_nibb     : boolean  := false;
        SIGNAL any_read           : boolean  := false;

        -- Memory Array Configuration
        SIGNAL BottomBoot         : boolean  := BootConfig;
        SIGNAL TopBoot            : boolean  := NOT BootConfig;
        SIGNAL UniformSec         : boolean  := false;

        --FSM control signals
        SIGNAL PDONE              : std_logic := '1'; --Page Prog. Done
        SIGNAL PSTART             : std_logic := '0'; --Start Page Programming
        SIGNAL PGSUSP             : std_logic := '0'; --Suspend Program
        SIGNAL PGRES              : std_logic := '0'; --Resume Program

        SIGNAL WDONE              : std_logic := '1'; --Write operation Done
        SIGNAL WSTART_NV          : std_logic := '0'; --Start Write operation
        SIGNAL WSTART_V           : std_logic := '0'; --Start Write operation

        SIGNAL CSDONE             : std_logic := '1'; --Write volatile bits
        SIGNAL CSSTART            : std_logic := '0'; --Start Write volatile bits

        SIGNAL EESDONE            : std_logic := '1'; --Evaluate Erase Status Done
        SIGNAL EESSTART           : std_logic := '0'; --Start Evaluate Erase Status operation

        SIGNAL ESTART             : std_logic := '0'; --Start Erase operation
        SIGNAL EDONE              : std_logic := '1'; --Erase operation Done
        SIGNAL ESUSP              : std_logic := '0'; --Suspend Erase
        SIGNAL ERES               : std_logic := '0'; --Resume Erase

        SIGNAL WL6                : std_logic := '0';
        SIGNAL WL5                : std_logic := '0';
        SIGNAL WL4                : std_logic := '0';

        SIGNAL WREN_V             : std_logic := '0';

        --reset timing
        SIGNAL RST                 : std_logic := '1';
        SIGNAL reseted             : std_logic := '0'; --Reset Timing Control
        SIGNAL RESET_EN            : std_logic := '0';
        SIGNAL io3_rst             : boolean;
        SIGNAL ddr                 : boolean;
        SIGNAL RST_QUAD            : boolean;
        SIGNAL datain              : boolean;
        SIGNAL datain_ddr          : boolean;
        SIGNAL WrProt              : boolean;

        SIGNAL DPD_ACT             : std_logic;
        SIGNAL PGM_ACT             : std_logic := '0';
        SIGNAL PGM_SEC_REG_ACT     : std_logic := '0';
        SIGNAL SECT_ERS_ACT        : std_logic := '0';
        SIGNAL HALF_BLOCK_ERS_ACT  : std_logic := '0';
        SIGNAL BLOCK_ERS_ACT       : std_logic := '0';
        SIGNAL CHIP_ERS_ACT        : std_logic := '0';
        SIGNAL SECT_ERS_SEC_REG_ACT: std_logic := '0';
        SIGNAL WRR_NV_ACT          : std_logic := '0';
        SIGNAL WRAR_NV_ACT         : std_logic := '0';
        SIGNAL IRP_ACT             : std_logic := '0';
        SIGNAL DLRNV_ACT           : std_logic := '0';
        SIGNAL SET_PNTR_PROT_ACT   : std_logic := '0';
        SIGNAL PASS_PGM_ACT        : std_logic := '0';

        SIGNAL DLRNV_programmed    : std_logic := '0';
        SHARED VARIABLE pgm_page   : NATURAL;

        SHARED VARIABLE read_cnt   : NATURAL := 0;
        SHARED VARIABLE byte_cnt   : NATURAL := 1;
        SHARED VARIABLE read_addr  : NATURAL;
        SHARED VARIABLE wr_cnt     : NATURAL RANGE 0 TO 511;
        SHARED VARIABLE cnt        : NATURAL RANGE 0 TO 512 := 0;

        SHARED VARIABLE sect       : NATURAL;
        SHARED VARIABLE blk        : NATURAL;

        SIGNAL change_addr         : std_logic := '0';
        SHARED VARIABLE Address    : NATURAL RANGE 0 TO AddrRANGE := 0;
        SHARED VARIABLE Address_in : std_logic_vector(31 DOWNTO 0) := (OTHERS => '0');
        SHARED VARIABLE mode_in    : std_logic_vector(7 DOWNTO 0);
        SHARED VARIABLE addr_bytes : std_logic_vector(31 DOWNTO 0);
        SHARED VARIABLE Address_wrar    : NATURAL := 0;
        SHARED VARIABLE Address_wrar_in : std_logic_vector(31 DOWNTO 0) := (OTHERS => '0');
        -- Sector is protect if Sec_Prot(SecNum) = '1'
        SHARED VARIABLE Sec_Prot  : std_logic_vector(SecNum DOWNTO 0) := (OTHERS => '0');
        SHARED VARIABLE HalfBlock_Prot: std_logic_vector(HalfBlockNum DOWNTO 0) := (OTHERS => '0');
        SHARED VARIABLE Block_Prot: std_logic_vector(BlockNum DOWNTO 0) := (OTHERS => '0');
        SIGNAL Legacy_Sec_Prot : std_logic_vector(SecNum DOWNTO 0) := (OTHERS => '0');
        SIGNAL IBL_Sec_Prot    : std_logic_vector(SecNum DOWNTO 0) := (OTHERS => '0');
        SIGNAL PRP_Sec_Prot    : std_logic_vector(SecNum DOWNTO 0) := (OTHERS => '0');

        SIGNAL change_BP        : std_logic := '0';
        SHARED VARIABLE BP_bits : std_logic_vector(2 DOWNTO 0) := "000";

        SHARED VARIABLE sec_region         : NATURAL;
        SHARED VARIABLE Latency_code       : NATURAL;
        SHARED VARIABLE WrapLength         : NATURAL RANGE 0 TO 64;
        SHARED VARIABLE opcode             : std_logic_vector(7 DOWNTO 0);
        SHARED VARIABLE opcode_cnt         : NATURAL := 0;
        SHARED VARIABLE addr_cnt           : NATURAL := 0;
        SHARED VARIABLE mode_cnt           : NATURAL := 0;
        SHARED VARIABLE dummy_cnt          : NATURAL := 0;
        SHARED VARIABLE data_cnt           : NATURAL := 0;
        SHARED VARIABLE bit_cnt            : NATURAL := 0;
        SIGNAL address_cnt                 : NATURAL RANGE 0 TO 64 := 0;

        SIGNAL RES_TO_SUSP_TIME            : std_ulogic := '0';

        -- timing check violation
        SIGNAL Viol               : X01 := '0';

    BEGIN
    ---------------------------------------------------------------------------
    --Power Up time
    ---------------------------------------------------------------------------
    PoweredUp <= '1' AFTER tdevice_PU;
    io3_rst   <= IO3R = '1' AND ((QUAD = '0' AND QPI = '0') OR CSNeg = '1');
    ddr       <= Instruct = DDRQIOR OR Instruct = DDRQIOR4;
    RST_QUAD  <= IO3R = '1' AND (QUAD = '1' OR QPI = '1');
    datain    <= TRUE WHEN SOut_zd = 'Z' ELSE  FALSE;
    datain_ddr<= datain AND ddr;
    WrProt    <= SRP0 = '1' AND QUAD = '0' AND QPI = '0';

    TimingModelSel: PROCESS
    BEGIN
        IF TimingModel(15)='S' OR TimingModel(15)='s' THEN
            SECURE_OPN <= '1';
        ELSIF TimingModel(15)='4' THEN
            QIO_ONLY_OPN <= '1';
        ELSIF TimingModel(15)='P' OR TimingModel(15)='p' THEN
            QPI_ONLY_OPN <= '1';
        END IF;
        WAIT;
    END PROCESS;

    ---------------------------------------------------------------------------
    -- VITAL Timing Checks Procedures
    ---------------------------------------------------------------------------
    VITALTimingCheck: PROCESS(SIIn, SOIn, SCK_ipd, CSNeg_ipd, RESETNeg_ipd,
                              WPNegIn)

        -- Timing Check Variables
        -- Setup/Hold Checks variables
        VARIABLE Tviol_CSNeg_SCK  : X01 := '0';
        VARIABLE TD_CSNeg_SCK     : VitalTimingDataType;

        VARIABLE Tviol_SI_SCK            : X01 := '0';
        VARIABLE TD_SI_SCK               : VitalTimingDataType;

        VARIABLE Tviol_CSNeg_IO3RESETNeg : X01 := '0';
        VARIABLE TD_CSNeg_IO3RESETNeg    : VitalTimingDataType;

        VARIABLE Tviol_SI_SCK_ddr_F      : X01 := '0';
        VARIABLE TD_SI_SCK_ddr_F         : VitalTimingDataType;

        VARIABLE Tviol_SO_SCK            : X01 := '0';
        VARIABLE TD_SO_SCK               : VitalTimingDataType;

        VARIABLE Tviol_SO_SCK_ddr_F      : X01 := '0';
        VARIABLE TD_SO_SCK_ddr_F         : VitalTimingDataType;

        VARIABLE Tviol_WPNeg_SCK         : X01 := '0';
        VARIABLE TD_WPNeg_SCK            : VitalTimingDataType;

        VARIABLE Tviol_WPNeg_SCK_ddr_F   : X01 := '0';
        VARIABLE TD_WPNeg_SCK_ddr_F      : VitalTimingDataType;

        VARIABLE Tviol_WPNeg_CSNeg_F     : X01 := '0';
        VARIABLE TD_WPNeg_CSNeg_F        : VitalTimingDataType;

        VARIABLE Tviol_RESETNeg_SCK      : X01 := '0';
        VARIABLE TD_RESETNeg_SCK         : VitalTimingDataType;

        VARIABLE Tviol_IO3RESETNeg_SCK_ddr_F : X01 := '0';
        VARIABLE TD_IO3RESETNeg_SCK_ddr_F    : VitalTimingDataType;

        VARIABLE Tviol_IO3RESETNeg_SCK   : X01 := '0';
        VARIABLE TD_IO3RESETNeg_SCK      : VitalTimingDataType;

        VARIABLE Tviol_CSNeg_RESETNeg    : X01 := '0';
        VARIABLE TD_CSNeg_RESETNeg       : VitalTimingDataType;

----------------------------DA LI TREBA I STA TREBA ???????----------
        --Pulse Width and Period Check Variables
        VARIABLE Pviol_SCK_rd       : X01 := '0';
        VARIABLE PD_SCK_rd          : VitalPeriodDataType
                                            := VitalPeriodDataInit;

        VARIABLE Pviol_SCK_fast     : X01 := '0';
        VARIABLE PD_SCK_fast        : VitalPeriodDataType
                                            := VitalPeriodDataInit;

        VARIABLE Pviol_SCK_ddr      : X01 := '0';
        VARIABLE PD_SCK_ddr         : VitalPeriodDataType
                                            := VitalPeriodDataInit;

        VARIABLE Pviol_SCK_reg      : X01 := '0';
        VARIABLE PD_SCK_reg         : VitalPeriodDataType
                                            := VitalPeriodDataInit;

        VARIABLE Pviol_CSNeg      : X01 := '0';
        VARIABLE PD_CSNeg         : VitalPeriodDataType
                                            := VitalPeriodDataInit;

        VARIABLE Pviol_RESETNeg     : X01 := '0';
        VARIABLE PD_RESETNeg        : VitalPeriodDataType
                                            := VitalPeriodDataInit;

        VARIABLE Pviol_IO3RESETNeg  : X01 := '0';
        VARIABLE PD_IO3RESETNeg     : VitalPeriodDataType
                                            := VitalPeriodDataInit;

        VARIABLE Violation          : X01 := '0';

    BEGIN
    ---------------------------------------------------------------------------
    -- Timing Check Section
    ---------------------------------------------------------------------------
        IF (TimingChecksOn) THEN

        -- Setup/Hold Check between CS# and SCK
        VitalSetupHoldCheck (
            TestSignal      => CSNeg_ipd,
            TestSignalName  => "CS#",
            RefSignal       => SCK_ipd,
            RefSignalName   => "SCK",
            SetupHigh       => tsetup_CSNeg_SCK,
            SetupLow        => tsetup_CSNeg_SCK,
            HoldHigh        => thold_CSNeg_SCK,
            HoldLow         => thold_CSNeg_SCK,
            CheckEnabled    => true,
            RefTransition   => '/',
            HeaderMsg       => InstancePath & PartID,
            TimingData      => TD_CSNeg_SCK,
            Violation       => Tviol_CSNeg_SCK
        );

        -- Hold Check between CSNeg and RESETNeg
        VitalSetupHoldCheck (
            TestSignal      => CSNeg,
            TestSignalName  => "CSNeg",
            RefSignal       => RESETNeg,
            RefSignalName   => "RESETNeg",
            HoldHigh        => thold_CSNeg_RESETNeg,
            CheckEnabled    => TRUE,
            RefTransition   => '/',
            HeaderMsg       => InstancePath & PartID,
            TimingData      => TD_CSNeg_RESETNeg,
            Violation       => Tviol_CSNeg_RESETNeg
        );

        -- Hold Check between CSNeg and IO3RESETNeg
        VitalSetupHoldCheck (
            TestSignal      => CSNeg,
            TestSignalName  => "CSNeg",
            RefSignal       => IO3RESETNeg,
            RefSignalName   => "IO3RESETNeg",
            HoldHigh        => thold_CSNeg_IO3RESETNeg,
            CheckEnabled    => IO3R = '1',
            RefTransition   => '/',
            HeaderMsg       => InstancePath & PartID,
            TimingData      => TD_CSNeg_IO3RESETNeg,
            Violation       => Tviol_CSNeg_IO3RESETNeg
        );

        -- Setup/Hold Check between SI and SCK, SDR mode
        VitalSetupHoldCheck (
            TestSignal      => SIIn,
            TestSignalName  => "SI",
            RefSignal       => SCK_ipd,
            RefSignalName   => "SCK",
            SetupHigh       => tsetup_SI_SCK,
            SetupLow        => tsetup_SI_SCK,
            HoldHigh        => thold_SI_SCK,
            HoldLow         => thold_SI_SCK,
            CheckEnabled    => datain,
            RefTransition   => '/',
            HeaderMsg       => InstancePath & PartID,
            TimingData      => TD_SI_SCK,
            Violation       => Tviol_SI_SCK
        );

        -- Setup/Hold Check between SI and SCK, DDR mode
        VitalSetupHoldCheck (
            TestSignal      => SIIn,
            TestSignalName  => "SI",
            RefSignal       => SCK_ipd,
            RefSignalName   => "SCK",
            SetupHigh       => tsetup_SI_SCK,
            SetupLow        => tsetup_SI_SCK,
            HoldHigh        => thold_SI_SCK,
            HoldLow         => thold_SI_SCK,
            CheckEnabled    => datain_ddr,
            RefTransition   => '\',
            HeaderMsg       => InstancePath & PartID,
            TimingData      => TD_SI_SCK_ddr_F,
            Violation       => Tviol_SI_SCK_ddr_F
        );

        -- Setup/Hold Check between SO and SCK, SDR mode
        VitalSetupHoldCheck (
            TestSignal      => SOIn,
            TestSignalName  => "SO",
            RefSignal       => SCK_ipd,
            RefSignalName   => "SCK",
            SetupHigh       => tsetup_SI_SCK,
            SetupLow        => tsetup_SI_SCK,
            HoldHigh        => thold_SI_SCK,
            HoldLow         => thold_SI_SCK,
            CheckEnabled    => datain,
            RefTransition   => '/',
            HeaderMsg       => InstancePath & PartID,
            TimingData      => TD_SO_SCK,
            Violation       => Tviol_SO_SCK
        );

        -- Setup/Hold Check between SO and SCK, DDR mode
        VitalSetupHoldCheck (
            TestSignal      => SOIn,
            TestSignalName  => "SO",
            RefSignal       => SCK_ipd,
            RefSignalName   => "SCK",
            SetupHigh       => tsetup_SI_SCK,
            SetupLow        => tsetup_SI_SCK,
            HoldHigh        => thold_SI_SCK,
            HoldLow         => thold_SI_SCK,
            CheckEnabled    => datain_ddr,
            RefTransition   => '\',
            HeaderMsg       => InstancePath & PartID,
            TimingData      => TD_SO_SCK_ddr_F,
            Violation       => Tviol_SO_SCK_ddr_F
        );

        -- Setup/Hold Check between WPNeg and SCK, SDR mode
        VitalSetupHoldCheck (
            TestSignal      => WPNegIn,
            TestSignalName  => "WPNeg",
            RefSignal       => SCK_ipd,
            RefSignalName   => "SCK",
            SetupHigh       => tsetup_SI_SCK,
            SetupLow        => tsetup_SI_SCK,
            HoldHigh        => thold_SI_SCK,
            HoldLow         => thold_SI_SCK,
            CheckEnabled    => datain,
            RefTransition   => '/',
            HeaderMsg       => InstancePath & PartID,
            TimingData      => TD_WPNeg_SCK,
            Violation       => Tviol_WPNeg_SCK
        );

        -- Setup/Hold Check between WPNeg and SCK, DDR mode
        VitalSetupHoldCheck (
            TestSignal      => WPNegIn,
            TestSignalName  => "WPNeg",
            RefSignal       => SCK_ipd,
            RefSignalName   => "SCK",
            SetupHigh       => tsetup_SI_SCK,
            SetupLow        => tsetup_SI_SCK,
            HoldHigh        => thold_SI_SCK,
            HoldLow         => thold_SI_SCK,
            CheckEnabled    => datain_ddr,
            RefTransition   => '\',
            HeaderMsg       => InstancePath & PartID,
            TimingData      => TD_WPNeg_SCK_ddr_F,
            Violation       => Tviol_WPNeg_SCK_ddr_F
        );

        -- Setup/Hold Check between WPNeg and CSNeg, SDR mode
        VitalSetupHoldCheck (
            TestSignal      => WPNegIn,
            TestSignalName  => "WPNeg",
            RefSignal       => CSNeg_ipd,
            RefSignalName   => "CSNeg",
            SetupHigh       => tsetup_WPNeg_CSNeg,
            SetupLow        => tsetup_WPNeg_CSNeg,
            HoldHigh        => thold_WPNeg_CSNeg,
            HoldLow         => thold_WPNeg_CSNeg,
            CheckEnabled    => WrProt,
            RefTransition   => '\',
            HeaderMsg       => InstancePath & PartID,
            TimingData      => TD_WPNeg_CSNeg_F,
            Violation       => Tviol_WPNeg_CSNeg_F
        );

        -- Setup/Hold Check between IO3RESETNeg and SCK, SDR mode
        VitalSetupHoldCheck (
            TestSignal      => IO3RESETNegIn,
            TestSignalName  => "IO3RESETNeg",
            RefSignal       => SCK_ipd,
            RefSignalName   => "SCK",
            SetupHigh       => tsetup_SI_SCK,
            SetupLow        => tsetup_SI_SCK,
            HoldHigh        => thold_SI_SCK,
            HoldLow         => thold_SI_SCK,
            CheckEnabled    => datain,
            RefTransition   => '/',
            HeaderMsg       => InstancePath & PartID,
            TimingData      => TD_IO3RESETNeg_SCK,
            Violation       => Tviol_IO3RESETNeg_SCK
        );

        -- Setup/Hold Check between IO3RESETNeg and SCK, DDR mode
        VitalSetupHoldCheck (
            TestSignal      => IO3RESETNegIn,
            TestSignalName  => "IO3RESETNeg",
            RefSignal       => SCK_ipd,
            RefSignalName   => "SCK",
            SetupHigh       => tsetup_SI_SCK,
            SetupLow        => tsetup_SI_SCK,
            HoldHigh        => thold_SI_SCK,
            HoldLow         => thold_SI_SCK,
            CheckEnabled    => datain_ddr,
            RefTransition   => '\',
            HeaderMsg       => InstancePath & PartID,
            TimingData      => TD_IO3RESETNeg_SCK_ddr_F,
            Violation       => Tviol_IO3RESETNeg_SCK_ddr_F
        );

        --Pulse Width and Period Check Variables
        -- Pulse Width Check SCK for READ, serial mode
        VitalPeriodPulseCheck (
            TestSignal      =>  SCK_ipd,
            TestSignalName  =>  "SCK",
            PulseWidthLow   =>  tpw_SCK_normal_rd,
            PulseWidthHigh  =>  tpw_SCK_normal_rd,
            PeriodData      =>  PD_SCK_rd,
            XOn             =>  XOn,
            MsgOn           =>  MsgOn,
            Violation       =>  Pviol_SCK_rd,
            HeaderMsg       =>  InstancePath & PartID,
            CheckEnabled    =>  normal_rd);

        -- Pulse Width Check SCK for FAST_READ, serial mode
        VitalPeriodPulseCheck (
            TestSignal      =>  SCK_ipd,
            TestSignalName  =>  "SCK",
            PulseWidthLow   =>  tpw_SCK_fast_rd,
            PulseWidthHigh  =>  tpw_SCK_fast_rd,
            PeriodData      =>  PD_SCK_fast,
            XOn             =>  XOn,
            MsgOn           =>  MsgOn,
            Violation       =>  Pviol_SCK_fast,
            HeaderMsg       =>  InstancePath & PartID,
            CheckEnabled    =>  fast_rd);

        -- Pulse Width Check SCK for DDR mode
        VitalPeriodPulseCheck (
            TestSignal      =>  SCK_ipd,
            TestSignalName  =>  "SCK",
            PulseWidthLow   =>  tpw_SCK_ddr_rd,
            PulseWidthHigh  =>  tpw_SCK_ddr_rd,
            PeriodData      =>  PD_SCK_ddr,
            XOn             =>  XOn,
            MsgOn           =>  MsgOn,
            Violation       =>  Pviol_SCK_ddr,
            HeaderMsg       =>  InstancePath & PartID,
            CheckEnabled    =>  ddr_rd);

        -- Pulse Width Check SCK for DDR mode
        VitalPeriodPulseCheck (
            TestSignal      =>  SCK_ipd,
            TestSignalName  =>  "SCK",
            PulseWidthLow   =>  tpw_SCK_reg_rd,
            PulseWidthHigh  =>  tpw_SCK_reg_rd,
            PeriodData      =>  PD_SCK_reg,
            XOn             =>  XOn,
            MsgOn           =>  MsgOn,
            Violation       =>  Pviol_SCK_reg,
            HeaderMsg       =>  InstancePath & PartID,
            CheckEnabled    =>  reg_rd);

        -- Pulse Width Check CS# for READ, serial mode
        VitalPeriodPulseCheck (
            TestSignal      =>  CSNeg_ipd,
            TestSignalName  =>  "CS#",
            PulseWidthHigh  =>  tpw_CSNeg,
            PeriodData      =>  PD_CSNeg,
            XOn             =>  XOn,
            MsgOn           =>  MsgOn,
            Violation       =>  Pviol_CSNeg,
            HeaderMsg       =>  InstancePath & PartID,
            CheckEnabled    =>  TRUE);

        -- Pulse Width Check RESETNeg
        VitalPeriodPulseCheck (
            TestSignal        => RESETNeg_ipd,
            TestSignalName    => "RESETNeg",
            PulseWidthLow     => tpw_RESETNeg,
            CheckEnabled      => TRUE,
            HeaderMsg         => InstancePath & PartID,
            PeriodData        => PD_RESETNeg,
            Violation         => Pviol_RESETNeg);

        -- Pulse Width Check IO3RESETNeg
        VitalPeriodPulseCheck (
            TestSignal        => IO3RESETNeg_ipd,
            TestSignalName    => "IO3RESETNeg",
            PulseWidthLow     => tpw_IO3RESETNeg,
            CheckEnabled      => io3_rst,
            HeaderMsg         => InstancePath & PartID,
            PeriodData        => PD_IO3RESETNeg,
            Violation         => Pviol_IO3RESETNeg);

        -- Period Check SCK for READ, serial mode
        VitalPeriodPulseCheck (
            TestSignal      =>  SCK_ipd,
            TestSignalName  =>  "SCK",
            Period          =>  tperiod_SCK_normal_rd,
            PeriodData      =>  PD_SCK_rd,
            XOn             =>  XOn,
            MsgOn           =>  MsgOn,
            Violation       =>  Pviol_SCK_rd,
            HeaderMsg       =>  InstancePath & PartID,
            CheckEnabled    =>  normal_rd);

        -- Period Check SCK for FAST READ, serial mode
        VitalPeriodPulseCheck (
            TestSignal      =>  SCK_ipd,
            TestSignalName  =>  "SCK",
            Period          =>  tperiod_SCK_fast_rd,
            PeriodData      =>  PD_SCK_fast,
            XOn             =>  XOn,
            MsgOn           =>  MsgOn,
            Violation       =>  Pviol_SCK_fast,
            HeaderMsg       =>  InstancePath & PartID,
            CheckEnabled    =>  fast_rd);

        -- Period Check SCK for DUAL READ, serial mode
        VitalPeriodPulseCheck (
            TestSignal      =>  SCK_ipd,
            TestSignalName  =>  "SCK",
            Period          =>  tperiod_SCK_ddr_rd,
            PeriodData      =>  PD_SCK_ddr,
            XOn             =>  XOn,
            MsgOn           =>  MsgOn,
            Violation       =>  Pviol_SCK_ddr,
            HeaderMsg       =>  InstancePath & PartID,
            CheckEnabled    =>  ddr_rd);

        -- Period Check SCK for READ, serial mode
        VitalPeriodPulseCheck (
            TestSignal      =>  SCK_ipd,
            TestSignalName  =>  "SCK",
            Period          =>  tperiod_SCK_reg_rd,
            PeriodData      =>  PD_SCK_reg,
            XOn             =>  XOn,
            MsgOn           =>  MsgOn,
            Violation       =>  Pviol_SCK_reg,
            HeaderMsg       =>  InstancePath & PartID,
            CheckEnabled    =>  reg_rd);

        Violation :=   Tviol_CSNeg_SCK OR
                       Tviol_CSNeg_RESETNeg OR
                       Tviol_CSNeg_IO3RESETNeg OR
                       Tviol_SI_SCK OR
                       Tviol_SI_SCK_ddr_F OR
                       Tviol_SO_SCK OR
                       Tviol_SO_SCK_ddr_F OR
                       Tviol_WPNeg_SCK OR
                       Tviol_WPNeg_SCK_ddr_F OR
                       Tviol_WPNeg_CSNeg_F OR
                       Tviol_IO3RESETNeg_SCK OR
                       Tviol_RESETNeg_SCK OR
                       Tviol_IO3RESETNeg_SCK_ddr_F OR
                       Pviol_SCK_rd OR
                       Pviol_SCK_fast OR
                       Pviol_SCK_ddr OR
                       Pviol_SCK_reg OR
                       Pviol_CSNeg OR
                       Pviol_RESETNeg;

            Viol <= Violation;

            ASSERT Violation = '0'
                REPORT InstancePath & partID & ": simulation may be" &
                    " inaccurate due to timing violations"
                SEVERITY WARNING;

        END IF;
    END PROCESS VITALTimingCheck;

    ----------------------------------------------------------------------------
    -- sequential process for FSM state transition
    ----------------------------------------------------------------------------

    StateTransition1: PROCESS(next_state, PoweredUp, RST, HW_RST_out, SFT_RST_out, change_addr)
    BEGIN
        IF PoweredUp = '1' THEN
            IF (RESETNeg = '0' OR IO3RESETNeg = '0') AND falling_edge(RST) THEN
                -- no state transition while RESET# low
                current_state <= RESET_STATE;
                HW_RST_in <= '1', '0' AFTER 1 ns;
                reseted <= '0';
            ELSIF HW_RST_out = '1' AND SFT_RST_out = '1' THEN
                current_state <= next_state;
                reseted <= '1';
            END IF;

            IF SFT_RST_out = '0' THEN
                current_state <= RESET_STATE;
                reseted <= '0';
            END IF;
        END IF;
    END PROCESS;

    -- Timing control for the Hardware Reset
    Threset1: PROCESS(HW_RST_in)
    BEGIN
        IF rising_edge(HW_RST_in) THEN
            HW_RST_out <= '0', '1' AFTER tdevice_RPH;
        END IF;
    END PROCESS;
    -- Timing control for the Software Reset
    Threset2: PROCESS(SFT_RST_in)
    BEGIN
        IF rising_edge(SFT_RST_in) THEN
            SFT_RST_out <= '0', '1' AFTER tdevice_RPH;
        END IF;
    END PROCESS;

    HW_RESET: PROCESS(RESETNeg, IO3RESETNeg)
    BEGIN
        -- hw reset ignored during WRR operation and WRAR to NV Status and
        -- Configuration registers
        IF falling_edge(RESETNeg) THEN
            IF WRR_NV_ACT = '0' AND NOT (WRAR_NV_ACT = '1' AND
            (Address = 0 OR Address = 2 OR Address = 3 OR Address = 4)) THEN
                RST <= RESETNeg AFTER 200 ns;
            END IF;
        END IF;

        IF falling_edge(IO3RESETNeg) AND IO3R = '1' AND (CSNeg_ipd = '1' OR (QUAD = '0' AND QPI = '0')) THEN
            IF WRR_NV_ACT = '0' AND NOT (WRAR_NV_ACT = '1' AND
            (Address = 0 OR Address = 2 OR Address = 3 OR Address = 4)) THEN
                RST <= IO3RESETNeg AFTER 200 ns;
            END IF;
        END IF;
        IF PoweredUp = '1' THEN
            IF rising_edge(RESETNeg) OR
            (rising_edge(IO3RESETNeg) AND IO3R = '1') THEN
                RST <= '1';
            END IF;
        END IF;
    END PROCESS;

    ---------------------------------------------------------------------------
    -- Timing control for the Page Program
    ---------------------------------------------------------------------------
    ProgTime : PROCESS(PSTART, PGSUSP, PGRES, reseted)
        VARIABLE pob          : time;
        VARIABLE elapsed_pgm  : time;
        VARIABLE start_pgm    : time;
        VARIABLE duration_pgm : time;
    BEGIN
        IF rising_edge(PSTART) OR rising_edge(reseted) THEN
            IF wr_cnt = 1 THEN
                pob  := tdevice_BP1;
            ELSIF wr_cnt = PageSize THEN
                pob  := tdevice_PP;
            ELSE
                pob  := tdevice_BP1 + wr_cnt*tdevice_BP2;
            END IF;

            IF IRP_ACT = '1' THEN
                pob  := tdevice_BP1 + tdevice_BP2;
            END IF;

            IF PASS_PGM_ACT = '1' THEN
                pob  := tdevice_BP1 + 7*tdevice_BP2;
            END IF;
        END IF;
        IF rising_edge(reseted) THEN
            PDONE <= '1';  -- reset done, programing terminated
        ELSIF reseted = '1' THEN
            IF rising_edge(PSTART) AND PDONE = '1' THEN
                elapsed_pgm := 0 ns;
                start_pgm := NOW;
                duration_pgm := pob;
                PDONE <= '0', '1' AFTER duration_pgm;
            END IF;
        END IF;
        IF PGSUSP'EVENT AND PGSUSP = '1' AND PDONE /= '1' THEN
            elapsed_pgm  := NOW - start_pgm;
            duration_pgm := duration_pgm - elapsed_pgm;
            PDONE <= '0';
        END IF;
        IF PGRES'EVENT AND PGRES = '1' THEN
            start_pgm := NOW;
            PDONE <= '0', '1' AFTER duration_pgm;
        END IF;
    END PROCESS ProgTime;

    ---------------------------------------------------------------------------
    -- Timing control for the Write Status Register
    ---------------------------------------------------------------------------
    WriteTime : PROCESS(WSTART_NV, WSTART_V, reseted)
        VARIABLE wob      : time;
    BEGIN
        IF rising_edge(reseted) THEN
            WDONE <= '1';  -- reset done, programing terminated
        ELSIF reseted = '1' THEN
            IF rising_edge(WSTART_NV) AND WDONE = '1' THEN
                wob  := tdevice_WRR;
                WDONE <= '0', '1' AFTER wob;
            ELSIF rising_edge(WSTART_V) AND WDONE = '1' THEN
                wob  := tdevice_CS;
                WDONE <= '0', '1' AFTER wob;
            END IF;
        END IF;

    END PROCESS WriteTime;

    ---------------------------------------------------------------------------
    -- Timing control for block erase operation
    ---------------------------------------------------------------------------
    ErsTime : PROCESS(ESTART, ESUSP, ERES, reseted)
        VARIABLE seo      : time;
        VARIABLE ceo      : time;
        VARIABLE beo      : time;
        VARIABLE hbeo     : time;
        VARIABLE elapsed_ers  : time;
        VARIABLE start_ers    : time;
        VARIABLE duration_ers : time;
    BEGIN
        IF LongTimming THEN
            seo := tdevice_SE;
            ceo := tdevice_CE;
            beo := tdevice_BE;
            hbeo := tdevice_HBE;
        ELSE
            seo := tdevice_SE / 1000;
            ceo := tdevice_CE / 1000;
            beo := tdevice_BE / 1000;
            hbeo := tdevice_HBE / 1000;
        END IF;

        IF (rising_edge(ESTART) or rising_edge(reseted)) THEN
            IF SECT_ERS_ACT = '1' THEN
                duration_ers := seo;
            ELSIF HALF_BLOCK_ERS_ACT = '1' THEN
                duration_ers := hbeo;
            ELSIF BLOCK_ERS_ACT = '1' THEN
                duration_ers := beo;
            ELSIF CHIP_ERS_ACT = '1' THEN
                duration_ers := ceo;
            ELSE
                duration_ers := seo;
            END IF;
        END IF;

        IF rising_edge(reseted) THEN
            EDONE <= '1';
        ELSIF reseted = '1' THEN
            IF rising_edge(ESTART) AND EDONE = '1' THEN
                elapsed_ers := 0 ns;
                EDONE <= '0', '1' AFTER duration_ers;
                start_ers := NOW;
            ELSIF ESUSP'EVENT AND ESUSP = '1' AND EDONE /= '1' THEN
                elapsed_ers  := NOW - start_ers;
                duration_ers := duration_ers - elapsed_ers;
                EDONE <= '0';
            ELSIF ERES'EVENT AND ERES = '1' THEN
                start_ers := NOW;
                EDONE <= '0', '1' AFTER duration_ers;
            END IF;
        END IF;

    END PROCESS ErsTime;

    SuspTime : PROCESS(ERSSUSP_in,PRGSUSP_in)
        VARIABLE susp_time : time;
    BEGIN
        IF LongTimming THEN
            susp_time  := tdevice_SUSP;
        ELSE
            susp_time  := tdevice_SUSP / 10;
        END IF;

        IF rising_edge(ERSSUSP_in) THEN
            ERSSUSP_out <= '0', '1' AFTER susp_time;
        ELSIF falling_edge(ERSSUSP_in) THEN
            ERSSUSP_out <= '0';
        END IF;

        IF rising_edge(PRGSUSP_in) THEN
            PRGSUSP_out <= '0', '1' AFTER susp_time;
        ELSIF falling_edge(ERSSUSP_in) THEN
            PRGSUSP_out <= '0';
        END IF;
    END PROCESS SuspTime;

    PassUlckTime : PROCESS(PASSULCK_in)
        VARIABLE passulck_time : time;
    BEGIN
        passulck_time := tdevice_PASSACC;

        IF rising_edge(PASSULCK_in) THEN
            PASSULCK_out <= '0', '1' AFTER passulck_time;
        ELSIF falling_edge(PASSULCK_in) THEN
            PASSULCK_out <= '0';
        END IF;
    END PROCESS PassUlckTime;

    CheckCEOnPowerUP :PROCESS(CSNeg_ipd)
    BEGIN
        IF (PoweredUp = '0' AND falling_edge(CSNeg_ipd)) THEN
            REPORT InstancePath & partID &
            ": Device is selected during Power Up"
            SEVERITY WARNING;
        END IF;
    END PROCESS;

    ---------------------------------------------------------------------------
    -- Main Behavior Process
    -- combinational process for next state generation
    ---------------------------------------------------------------------------

    StateGen :PROCESS(CSNeg_ipd, SCK_ipd, WDONE, PDONE, EDONE, HW_RST_out, SFT_RST_out,
                      ERSSUSP_out, PRGSUSP_out, PASSULCK_out, RES_in, change_addr)

    BEGIN

        CASE current_state IS
            WHEN  STANDBY =>
                IF opcode_cnt = 8 THEN
                    IF Instruct = READ OR Instruct = READ4 THEN
                        next_state <= RD_ADDR;
                    ELSIF Instruct = FAST_READ OR Instruct = FAST_READ4 THEN
                        next_state <= FAST_RD_ADDR;
                    ELSIF Instruct = DOR OR Instruct = DOR4 THEN
                        next_state <= DUALO_RD_ADDR;
                    ELSIF rising_edge(change_addr) AND (Instruct = DIOR OR Instruct = DIOR4) THEN
                        next_state <= DUALIO_RD_ADDR;
                    ELSIF (Instruct = QOR OR Instruct = QOR4) AND QUAD = '1' THEN
                        next_state <= QUADO_RD_ADDR;
                    ELSIF (Instruct = QIOR OR Instruct = QIOR4) AND (QUAD = '1' OR QPI = '1') THEN
                        next_state <= QUADIO_RD_ADDR;
                    ELSIF (Instruct = DDRQIOR OR Instruct = DDRQIOR4) AND (QUAD = '1' OR QPI = '1') THEN
                        next_state <= DDRQUADIO_RD_ADDR;
                    ELSIF Instruct = DLPRD THEN
                        next_state <= DLPRD_DUMMY;
                    ELSIF Instruct = IRPRD THEN
                        next_state <= IRPRD_DUMMY;
                    ELSIF Instruct = IBLRD OR Instruct = IBLRD4 THEN
                        next_state <= IBLRD_ADDR;
                    ELSIF Instruct = SECRR THEN
                        next_state <= SECRR_ADDR;
                    ELSIF Instruct = PASSRD AND PWDMLB = '1' THEN
                        next_state <= PASSRD_DUMMY;
                    ELSIF Instruct = PRRD THEN
                        next_state <= PRRD_DUMMY;
                    ELSIF Instruct = RDID THEN
                        next_state <= RDID_DATA_OUTPUT;
                    ELSIF Instruct = RDQID AND (QUAD = '1' OR QPI = '1') THEN
                        next_state <= RDQID_DATA_OUTPUT;
                    ELSIF Instruct = RUID THEN
                        next_state <= RUID_DUMMY;
                    ELSIF Instruct = RSFDP THEN
                        next_state <= RSFDP_ADDR;
                    ELSIF Instruct = SET_BURST THEN
                        next_state <= SET_BURST_DATA_INPUT;
                    ELSIF Instruct = RDSR1 THEN
                        next_state <= RDSR1_DATA_OUTPUT;
                    ELSIF Instruct = RDSR2 THEN
                        next_state <= RDSR2_DATA_OUTPUT;
                    ELSIF CSNeg_ipd = '0' AND SCK_ipd = '1' AND Instruct = RDCR1 THEN
                        next_state <= RDCR1_DATA_OUTPUT;
                    ELSIF Instruct = RDCR2 THEN
                        next_state <= RDCR2_DATA_OUTPUT;
                    ELSIF Instruct = RDCR3 THEN
                        next_state <= RDCR3_DATA_OUTPUT;
                    ELSIF Instruct = RDAR THEN
                        next_state <= RDAR_ADDR;
                    ELSIF Instruct = RES THEN
                        next_state <= RDP_DUMMY;
                    ELSIF (Instruct = PP OR Instruct = PP4) AND WEL = '1' THEN
                        next_state <= PGM_ADDR;
                    ELSIF (Instruct = QPP OR Instruct = QPP4) AND WEL = '1' AND QUAD = '1' THEN
                        next_state <= PGM_ADDR;
                    ELSIF (Instruct = SE OR Instruct = SE4) AND WEL = '1' THEN
                        next_state <= SECT_ERS_ADDR;
                    ELSIF (Instruct = HBE OR Instruct = HBE4) AND WEL = '1' THEN
                        next_state <= HALF_BLOCK_ERS_ADDR;
                    ELSIF (Instruct = BE OR Instruct = BE4) AND WEL = '1' THEN
                        next_state <= BLOCK_ERS_ADDR;
                    ELSIF (Instruct = IBL OR Instruct = IBL4) AND WPS = '1' THEN
                        next_state <= IBL_LOCK;
                    ELSIF Instruct = IRPP AND WEL = '1' THEN
                        next_state <= IRP_PGM_DATA_INPUT;
                    ELSIF Instruct = WRR AND (WEL = '1' OR WREN_V = '1') THEN
                        next_state <= WRR_DATA_INPUT;
                    ELSIF Instruct = WRAR AND WEL = '1' THEN
                        next_state <= WRAR_ADDR;
                    ELSIF Instruct = PASSP AND WEL = '1' AND PWDMLB = '1' THEN
                        next_state <= PASSP_DATA_INPUT;
                    ELSIF Instruct = SECRP AND WEL = '1' THEN
                        next_state <= SEC_REG_PGM_ADDR;
                    ELSIF Instruct = SECRE AND WEL = '1' THEN
                        next_state <= SEC_REG_ERS_ADDR;
                    ELSIF Instruct = PASSU THEN
                        next_state <= PASSU_DATA_INPUT;
                    ELSIF (Instruct = IBUL OR Instruct = IBUL4) AND WPS = '1' THEN
                        next_state <= IBL_UNLOCK;
                    ELSIF (Instruct = SPRP OR Instruct = SPRP4) AND WEL = '1' AND NVLOCK = '1' THEN
                        next_state <= SET_PNTR_PROT_ADDR;
                    ELSIF (Instruct = PDLRNV) THEN
                        IF (SRP1 = '0' AND (SRP0 = '0' OR WPNegIn = '1' OR QUAD = '1' OR QPI = '1')) AND WEL = '1' THEN
                            IF DLRNV_programmed = '0' THEN -- OTP
                                next_state <= PGM_NV_DLR_DATA;
                            END IF;
                        END IF;
                    ELSIF (Instruct = WDLRV) THEN
                        IF (SRP1 = '0' AND (SRP0 = '0' OR WPNegIn = '1' OR QUAD = '1' OR QPI = '1')) AND WEL = '1' THEN
                            next_state <= DLRV_WRITE_DATA;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) THEN
                        IF opcode_cnt = 8 THEN
                            IF Instruct = RSTEN THEN
                                next_state <= SFT_RST_EN;
                            ELSIF Instruct = DEEP_PD THEN
                                next_state <= DPD;
                            ELSIF Instruct = CE AND WEL = '1' THEN
                                next_state <= CHIP_ERS;
                            END IF;
                        END IF;
                    END IF;
                END IF;

            WHEN SFT_RST_EN =>
                IF rising_edge(CSNeg_ipd) THEN
                    IF opcode_cnt = 8 THEN
                        IF Instruct = RSTCMD THEN
                            next_state <= RESET_STATE;
                        ELSE
                            next_state <= STANDBY;
                        END IF;
                    END IF;
                END IF;

            WHEN RESET_STATE =>
                IF rising_edge(SFT_RST_out) OR rising_edge(HW_RST_out) THEN
                    IF SFT_RST_out = '1' AND HW_RST_out = '1' THEN
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN DPD =>
                IF CSNeg_ipd = '0' THEN
                    IF opcode_cnt = 9 AND Instruct = RES THEN
                        next_state <= RDP_DUMMY;
                    END IF;
                END IF;
                IF falling_edge(RES_in) THEN
                    next_state <= STANDBY;
                END IF;

            WHEN RD_ADDR =>
                IF CSNeg_ipd = '0' THEN
                    IF Instruct = READ AND ADS = '0' THEN
                        IF addr_cnt = 24 THEN
                            next_state <= RD_DATA;
                        END IF;
                    ELSIF Instruct = READ4 OR (Instruct = READ AND ADS = '1') THEN
                        IF addr_cnt = 32 THEN
                            next_state <= RD_DATA;
                        END IF;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF PS = '1' THEN
                        next_state <= PGMSUS;
                    ELSIF ES = '1' THEN
                        next_state <= ERSSUS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN RD_DATA | FAST_RD_DATA | DUALO_RD_DATA | QUADO_RD_DATA =>
                IF rising_edge(CSNeg_ipd) THEN
                    IF PS = '1' THEN
                        next_state <= PGMSUS;
                    ELSIF ES = '1' THEN
                        next_state <= ERSSUS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN FAST_RD_ADDR =>
                IF CSNeg_ipd = '0' THEN
                    IF Instruct = FAST_READ AND ADS = '0' THEN
                        IF addr_cnt = 24 THEN
                            next_state <= FAST_RD_DUMMY;
                        END IF;
                    ELSIF Instruct = FAST_READ4 OR
                    (Instruct = FAST_READ AND ADS = '1') THEN
                        IF addr_cnt = 32 THEN
                            next_state <= FAST_RD_DUMMY;
                        END IF;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF PS = '1' THEN
                        next_state <= PGMSUS;
                    ELSIF ES = '1' THEN
                        next_state <= ERSSUS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN FAST_RD_DUMMY =>
                IF CSNeg_ipd = '0' THEN
                    IF dummy_cnt = Latency_code THEN
                        next_state <= FAST_RD_DATA;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF PS = '1' THEN
                        next_state <= PGMSUS;
                    ELSIF ES = '1' THEN
                        next_state <= ERSSUS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN DUALO_RD_ADDR =>
                IF CSNeg_ipd = '0' THEN
                    IF Instruct = DOR AND ADS = '0' THEN
                        IF addr_cnt = 24 THEN
                            next_state <= DUALO_RD_DUMMY;
                        END IF;
                    ELSIF Instruct = DOR4 OR
                    (Instruct = DOR AND ADS = '1') THEN
                        IF addr_cnt = 32 THEN
                            next_state <= DUALO_RD_DUMMY;
                        END IF;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF PS = '1' THEN
                        next_state <= PGMSUS;
                    ELSIF ES = '1' THEN
                        next_state <= ERSSUS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN DUALO_RD_DUMMY =>
                IF CSNeg_ipd = '0' THEN
                    IF dummy_cnt = Latency_code THEN
                        next_state <= DUALO_RD_DATA;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF PS = '1' THEN
                        next_state <= PGMSUS;
                    ELSIF ES = '1' THEN
                        next_state <= ERSSUS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN QUADO_RD_ADDR =>
                IF CSNeg_ipd = '0' THEN
                    IF Instruct = QOR AND ADS = '0' THEN
                        IF addr_cnt = 24 THEN
                            next_state <= QUADO_RD_DUMMY;
                        END IF;
                    ELSIF Instruct = QOR4 OR
                    (Instruct = QOR AND ADS = '1') THEN
                        IF addr_cnt = 32 THEN
                            next_state <= QUADO_RD_DUMMY;
                        END IF;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF PS = '1' THEN
                        next_state <= PGMSUS;
                    ELSIF ES = '1' THEN
                        next_state <= ERSSUS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN QUADO_RD_DUMMY =>
                IF CSNeg_ipd = '0' THEN
                    IF dummy_cnt = Latency_code THEN
                        next_state <= QUADO_RD_DATA;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF PS = '1' THEN
                        next_state <= PGMSUS;
                    ELSIF ES = '1' THEN
                        next_state <= ERSSUS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN DUALIO_RD_ADDR =>
                IF CSNeg_ipd = '0' THEN
                    IF rising_edge(change_addr) AND Instruct = DIOR AND ADS = '0' THEN
                        IF addr_cnt = 12 THEN
                            next_state <= DUALIO_RD_MODE;
                        END IF;
                    ELSIF Instruct = DIOR4 OR
                    (Instruct = DIOR AND ADS = '1') THEN
                        IF addr_cnt = 16 THEN
                            next_state <= DUALIO_RD_MODE;
                        END IF;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF PS = '1' THEN
                        next_state <= PGMSUS;
                    ELSIF ES = '1' THEN
                        next_state <= ERSSUS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN DUALIO_RD_MODE =>
                IF CSNeg_ipd = '0' THEN
                    IF mode_cnt = 4 THEN
                        next_state <= DUALIO_RD_DUMMY;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF PS = '1' THEN
                        next_state <= PGMSUS;
                    ELSIF ES = '1' THEN
                        next_state <= ERSSUS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN DUALIO_RD_DUMMY =>
                IF CSNeg_ipd = '0' THEN
                    IF dummy_cnt = Latency_code THEN
                        next_state <= DUALIO_RD_DATA;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF PS = '1' THEN
                        next_state <= PGMSUS;
                    ELSIF ES = '1' THEN
                        next_state <= ERSSUS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN DUALIO_RD_DATA =>
                IF rising_edge(CSNeg_ipd) THEN
                    IF mode_byte(7 DOWNTO 4) = "1010" THEN
                        next_state <= DUALIO_RD_ADDR;
                    ELSIF PS = '1' THEN
                        next_state <= PGMSUS;
                    ELSIF ES = '1' THEN
                        next_state <= ERSSUS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN QUADIO_RD_ADDR =>
                IF CSNeg_ipd = '0' THEN
                    IF Instruct = QIOR AND ADS = '0' THEN
                        IF addr_cnt = 6 THEN
                            next_state <= QUADIO_RD_MODE;
                        END IF;
                    ELSIF Instruct = QIOR4 OR
                    (Instruct = QIOR AND ADS = '1') THEN
                        IF addr_cnt = 8 THEN
                            next_state <= QUADIO_RD_MODE;
                        END IF;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF PS = '1' THEN
                        next_state <= PGMSUS;
                    ELSIF ES = '1' THEN
                        next_state <= ERSSUS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN QUADIO_RD_MODE =>
                IF CSNeg_ipd = '0' THEN
                    IF mode_cnt = 2 THEN
                        next_state <= QUADIO_RD_DUMMY;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF PS = '1' THEN
                        next_state <= PGMSUS;
                    ELSIF ES = '1' THEN
                        next_state <= ERSSUS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN QUADIO_RD_DUMMY =>
                IF CSNeg_ipd = '0' THEN
                    IF dummy_cnt = Latency_code THEN
                        next_state <= QUADIO_RD_DATA;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF PS = '1' THEN
                        next_state <= PGMSUS;
                    ELSIF ES = '1' THEN
                        next_state <= ERSSUS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN QUADIO_RD_DATA =>
                IF rising_edge(CSNeg_ipd) THEN
                    IF mode_byte(7 DOWNTO 4) = "1010" THEN
                        next_state <= QUADIO_RD_ADDR;
                    ELSIF PS = '1' THEN
                        next_state <= PGMSUS;
                    ELSIF ES = '1' THEN
                        next_state <= ERSSUS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN DDRQUADIO_RD_ADDR =>
                IF CSNeg_ipd = '0' THEN
                    IF Instruct = DDRQIOR AND ADS = '0' THEN
                        IF addr_cnt = 24 THEN
                            next_state <= DDRQUADIO_RD_MODE;
                        END IF;
                    ELSIF Instruct = DDRQIOR4 OR
                    (Instruct = DDRQIOR AND ADS = '1') THEN
                        IF addr_cnt = 32 THEN
                            next_state <= DDRQUADIO_RD_MODE;
                        END IF;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF PS = '1' THEN
                        next_state <= PGMSUS;
                    ELSIF ES = '1' THEN
                        next_state <= ERSSUS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN DDRQUADIO_RD_MODE =>
                IF CSNeg_ipd = '0' THEN
                    IF mode_cnt = 8 THEN
                        next_state <= DDRQUADIO_RD_DUMMY;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF PS = '1' THEN
                        next_state <= PGMSUS;
                    ELSIF ES = '1' THEN
                        next_state <= ERSSUS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN DDRQUADIO_RD_DUMMY =>
                IF CSNeg_ipd = '0' THEN
                    IF dummy_cnt = 2*Latency_code THEN
                        next_state <= DDRQUADIO_RD_DATA;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF PS = '1' THEN
                        next_state <= PGMSUS;
                    ELSIF ES = '1' THEN
                        next_state <= ERSSUS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN DDRQUADIO_RD_DATA =>
                IF rising_edge(CSNeg_ipd) THEN
                    IF mode_byte(7 DOWNTO 4) = NOT (mode_byte(3 DOWNTO 0)) THEN
                        next_state <= DDRQUADIO_RD_ADDR;
                    ELSIF PS = '1' THEN
                        next_state <= PGMSUS;
                    ELSIF ES = '1' THEN
                        next_state <= ERSSUS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN RDAR_ADDR =>
                IF CSNeg_ipd = '0' THEN
                    IF (QPI = '1' AND ((ADS = '0' AND addr_cnt = 6) OR (ADS = '1' AND addr_cnt = 8))) OR
                    (QPI = '0' AND ((ADS = '0' AND addr_cnt = 24) OR (ADS = '1' AND addr_cnt = 32))) THEN
                        next_state <= RDAR_DUMMY;
                    END IF;
                END IF;
                -- if the Read Any Register is broken early (in address phase)
                IF rising_edge(CSNeg_ipd) THEN
                    next_state <= STANDBY;
                    IF CHIP_ERS_ACT = '1' THEN
                        next_state <= CHIP_ERS;
                    END IF;
                    IF SECT_ERS_ACT = '1' THEN
                        next_state <= SECT_ERS;
                    END IF;
                    IF HALF_BLOCK_ERS_ACT = '1' THEN
                        next_state <= HALF_BLOCK_ERS;
                    END IF;
                    IF BLOCK_ERS_ACT = '1' THEN
                        next_state <= BLOCK_ERS;
                    END IF;
                    IF ES = '1' THEN
                        next_state <= ERSSUS;
                    END IF;
                    IF PGM_ACT = '1' THEN
                        next_state <= PGM;
                    END IF;
                    IF PS = '1' THEN
                        next_state <= PGMSUS;
                    END IF;
                    IF PGM_SEC_REG_ACT = '1' THEN
                        next_state <= PGM_SEC_REG;
                    END IF;
                    IF SECT_ERS_SEC_REG_ACT = '1' THEN
                        next_state <= SECT_ERS_SEC_REG;
                    END IF;
                    IF WRR_NV_ACT = '1' THEN
                        next_state <= WRR_NV;
                    END IF;
                    IF WRAR_NV_ACT = '1' THEN
                        next_state <= WRAR_NV;
                    END IF;
                    IF IRP_ACT = '1' THEN
                        next_state <= IRP_PGM;
                    END IF;
                    IF DLRNV_ACT = '1' THEN
                        next_state <= PGM_NV_DLR;
                    END IF;
                    IF SET_PNTR_PROT_ACT = '1' THEN
                        next_state <= SET_PNTR_PROT;
                    END IF;
                    IF PASS_PGM_ACT = '1' THEN
                        next_state <= PASS_PGM;
                    END IF;
                    IF PASSULCK_in = '1' THEN
                        next_state <= PASS_ULCK;
                    END IF;
                END IF;

            WHEN RDAR_DUMMY =>
                IF CSNeg_ipd = '0' THEN
                    IF dummy_cnt = Latency_code THEN
                        next_state <= RDAR_DATA_OUTPUT;
                    END IF;
                END IF;
                -- if the Read Any Register is broken early (in dummy phase)
                IF rising_edge(CSNeg_ipd) THEN
                    next_state <= STANDBY;
                    IF CHIP_ERS_ACT = '1' THEN
                        next_state <= CHIP_ERS;
                    END IF;
                    IF SECT_ERS_ACT = '1' THEN
                        next_state <= SECT_ERS;
                    END IF;
                    IF HALF_BLOCK_ERS_ACT = '1' THEN
                        next_state <= HALF_BLOCK_ERS;
                    END IF;
                    IF BLOCK_ERS_ACT = '1' THEN
                        next_state <= BLOCK_ERS;
                    END IF;
                    IF ES = '1' THEN
                        next_state <= ERSSUS;
                    END IF;
                    IF PGM_ACT = '1' THEN
                        next_state <= PGM;
                    END IF;
                    IF PS = '1' THEN
                        next_state <= PGMSUS;
                    END IF;
                    IF PGM_SEC_REG_ACT = '1' THEN
                        next_state <= PGM_SEC_REG;
                    END IF;
                    IF SECT_ERS_SEC_REG_ACT = '1' THEN
                        next_state <= SECT_ERS_SEC_REG;
                    END IF;
                    IF WRR_NV_ACT = '1' THEN
                        next_state <= WRR_NV;
                    END IF;
                    IF WRAR_NV_ACT = '1' THEN
                        next_state <= WRAR_NV;
                    END IF;
                    IF IRP_ACT = '1' THEN
                        next_state <= IRP_PGM;
                    END IF;
                    IF DLRNV_ACT = '1' THEN
                        next_state <= PGM_NV_DLR;
                    END IF;
                    IF SET_PNTR_PROT_ACT = '1' THEN
                        next_state <= SET_PNTR_PROT;
                    END IF;
                    IF PASS_PGM_ACT = '1' THEN
                        next_state <= PASS_PGM;
                    END IF;
                    IF PASSULCK_in = '1' THEN
                        next_state <= PASS_ULCK;
                    END IF;
                END IF;

            WHEN RDSR1_DATA_OUTPUT | RDSR2_DATA_OUTPUT | RDCR1_DATA_OUTPUT |
                 RDCR2_DATA_OUTPUT | RDCR3_DATA_OUTPUT | RDAR_DATA_OUTPUT =>
                IF rising_edge(CSNeg_ipd) THEN
                    next_state <= STANDBY;
                    IF CHIP_ERS_ACT = '1' THEN
                        next_state <= CHIP_ERS;
                    END IF;
                    IF SECT_ERS_ACT = '1' THEN
                        next_state <= SECT_ERS;
                    END IF;
                    IF HALF_BLOCK_ERS_ACT = '1' THEN
                        next_state <= HALF_BLOCK_ERS;
                    END IF;
                    IF BLOCK_ERS_ACT = '1' THEN
                        next_state <= BLOCK_ERS;
                    END IF;
                    IF ES = '1' THEN
                        next_state <= ERSSUS;
                    END IF;
                    IF PGM_ACT = '1' THEN
                        next_state <= PGM;
                    END IF;
                    IF PS = '1' THEN
                        next_state <= PGMSUS;
                    END IF;
                    IF PGM_SEC_REG_ACT = '1' THEN
                        next_state <= PGM_SEC_REG;
                    END IF;
                    IF SECT_ERS_SEC_REG_ACT = '1' THEN
                        next_state <= SECT_ERS_SEC_REG;
                    END IF;
                    IF WRR_NV_ACT = '1' THEN
                        next_state <= WRR_NV;
                    END IF;
                    IF WRAR_NV_ACT = '1' THEN
                        next_state <= WRAR_NV;
                    END IF;
                    IF IRP_ACT = '1' THEN
                        next_state <= IRP_PGM;
                    END IF;
                    IF DLRNV_ACT = '1' THEN
                        next_state <= PGM_NV_DLR;
                    END IF;
                    IF SET_PNTR_PROT_ACT = '1' THEN
                        next_state <= SET_PNTR_PROT;
                    END IF;
                    IF PASS_PGM_ACT = '1' THEN
                        next_state <= PASS_PGM;
                    END IF;
                    IF PASSULCK_in = '1' THEN
                        next_state <= PASS_ULCK;
                    END IF;
                END IF;

            WHEN DLPRD_DUMMY =>
                IF CSNeg_ipd = '0' THEN
                    IF dummy_cnt = Latency_code THEN
                        next_state <= DLPRD_DATA_OUTPUT;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF PS = '1' THEN
                        next_state <= PGMSUS;
                    ELSIF ES = '1' THEN
                        next_state <= ERSSUS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN DLPRD_DATA_OUTPUT | IBLRD_DATA_OUTPUT | SECRR_DATA_OUTPUT |
                 RDID_DATA_OUTPUT | RDQID_DATA_OUTPUT | RUID_DATA_OUTPUT |
                 RSFDP_DATA_OUTPUT | SET_BURST_DATA_INPUT | IBL_LOCK | IBL_UNLOCK =>
                IF rising_edge(CSNeg_ipd) THEN
                    IF PS = '1' THEN
                        next_state <= PGMSUS;
                    ELSIF ES = '1' THEN
                        next_state <= ERSSUS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN IRPRD_DUMMY =>
                IF CSNeg_ipd = '0' THEN
                    IF dummy_cnt = Latency_code THEN
                        next_state <= IRPRD_DATA_OUTPUT;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    next_state <= STANDBY;
                END IF;

            WHEN IRPRD_DATA_OUTPUT | PASSRD_DATA_OUTPUT |
                 PRRD_DATA_OUTPUT | DLRV_WRITE_DATA =>
                IF rising_edge(CSNeg_ipd) THEN
                    next_state <= STANDBY;
                END IF;

            WHEN IBLRD_ADDR =>
                IF CSNeg_ipd = '0' THEN
                    IF (QPI = '1' AND
                    ((Instruct = IBLRD4 AND addr_cnt = 8) OR
                    (Instruct = IBLRD AND ((ADS = '0' AND addr_cnt = 6) OR (ADS = '1' AND addr_cnt = 8))))) OR
                    (QPI = '0' AND
                    ((Instruct = IBLRD4 AND addr_cnt = 32) OR
                    (Instruct = IBLRD AND ((ADS = '0' AND addr_cnt = 24) OR (ADS = '1' AND addr_cnt = 32))))) THEN
                        next_state <= IBLRD_DATA_OUTPUT;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF PS = '1' THEN
                        next_state <= PGMSUS;
                    ELSIF ES = '1' THEN
                        next_state <= ERSSUS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN SECRR_ADDR =>
                IF falling_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                    IF (QPI = '1' AND ((ADS = '0' AND addr_cnt = 6) OR (ADS = '1' AND addr_cnt = 8))) OR
                    (QPI = '0' AND ((ADS = '0' AND addr_cnt = 24) OR (ADS = '1' AND addr_cnt = 32))) THEN
                        next_state <= SECRR_DUMMY;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF PS = '1' THEN
                        next_state <= PGMSUS;
                    ELSIF ES = '1' THEN
                        next_state <= ERSSUS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN SECRR_DUMMY =>
                IF CSNeg_ipd = '0' THEN
                    IF dummy_cnt = Latency_code THEN
                        next_state <= SECRR_DATA_OUTPUT;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF PS = '1' THEN
                        next_state <= PGMSUS;
                    ELSIF ES = '1' THEN
                        next_state <= ERSSUS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN PASSRD_DUMMY =>
                IF CSNeg_ipd = '0' THEN
                    IF dummy_cnt = Latency_code THEN
                        next_state <= PASSRD_DATA_OUTPUT;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    next_state <= STANDBY;
                END IF;

            WHEN PRRD_DUMMY =>
                IF CSNeg_ipd = '0' THEN
                    IF dummy_cnt = Latency_code THEN
                        next_state <= PRRD_DATA_OUTPUT;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    next_state <= STANDBY;
                END IF;

            WHEN RUID_DUMMY =>
                IF CSNeg_ipd = '0' THEN
                    IF dummy_cnt = Latency_code THEN
                        next_state <= RUID_DATA_OUTPUT;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF PS = '1' THEN
                        next_state <= PGMSUS;
                    ELSIF ES = '1' THEN
                        next_state <= ERSSUS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN RSFDP_ADDR =>
                IF CSNeg_ipd = '0' THEN
                    IF (QPI = '1' AND ((ADS = '0' AND addr_cnt = 6) OR (ADS = '1' AND addr_cnt = 8))) OR
                    (QPI = '0' AND ((ADS = '0' AND addr_cnt = 24) OR (ADS = '1' AND addr_cnt = 32))) THEN
                        next_state <= RSFDP_DUMMY;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF PS = '1' THEN
                        next_state <= PGMSUS;
                    ELSIF ES = '1' THEN
                        next_state <= ERSSUS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN RSFDP_DUMMY =>
                IF CSNeg_ipd = '0' THEN
                    IF dummy_cnt = Latency_code THEN
                        next_state <= RSFDP_DATA_OUTPUT;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF PS = '1' THEN
                        next_state <= PGMSUS;
                    ELSIF ES = '1' THEN
                        next_state <= ERSSUS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN RDP_DUMMY => --release DP
                IF CSNeg_ipd = '0' THEN
                    IF dummy_cnt = 24 THEN
                        next_state <= RDP_DATA_OUTPUT;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF DPD_ACT = '1' THEN
                        next_state <= DPD;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN RDP_DATA_OUTPUT =>
                IF rising_edge(CSNeg_ipd) THEN
                    IF DPD_ACT = '1' THEN
                        next_state <= DPD;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;
                IF falling_edge(RES_in) THEN -- when in DPD mode
                    next_state <= STANDBY;
                END IF;

            WHEN PGM_ADDR =>
                IF CSNeg_ipd = '0' THEN
                    IF QPI = '1' AND Instruct = PP AND ADS = '0' THEN
                        IF addr_cnt = 6 THEN
                            next_state <= PGM_DATAIN;
                        END IF;
                    ELSIF QPI = '1' AND (Instruct = PP4 OR (Instruct = PP AND ADS = '1')) THEN
                        IF addr_cnt = 8 THEN
                            next_state <= PGM_DATAIN;
                        END IF;
                    ELSIF QPI = '0' AND ((Instruct = PP OR Instruct = QPP) AND ADS = '0') THEN
                        IF addr_cnt = 24 THEN
                            next_state <= PGM_DATAIN;
                        END IF;
                    ELSIF QPI = '0' AND (Instruct = PP4 OR Instruct = QPP4 OR
                    ((Instruct = PP OR Instruct = QPP) AND ADS = '1')) THEN
                        IF addr_cnt = 32 THEN
                            next_state <= PGM_DATAIN;
                        END IF;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF ES = '1' THEN -- erase suspend
                        next_state <= ERSSUS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN PGM_DATAIN =>
                IF rising_edge(CSNeg_ipd) THEN
                  IF data_cnt = 0 AND byte_cnt > 0 THEN
                        next_state <= PGM;
                    ELSIF ES = '1' THEN -- erase suspend
                        next_state <= ERSSUS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN PGM =>
                    IF opcode_cnt = 8 THEN
                        IF Instruct = RDSR1 THEN
                            next_state <= RDSR1_DATA_OUTPUT;
                        ELSIF Instruct = RDSR2 THEN
                            next_state <= RDSR2_DATA_OUTPUT;
                        ELSIF Instruct = RDCR1 THEN
                            next_state <= RDCR1_DATA_OUTPUT;
                        ELSIF Instruct = RDCR2 THEN
                            next_state <= RDCR2_DATA_OUTPUT;
                        ELSIF Instruct = RDCR3 THEN
                            next_state <= RDCR3_DATA_OUTPUT;
                        ELSIF Instruct = RDAR THEN
                            next_state <= RDAR_ADDR;
                        END IF;
                    END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF opcode_cnt = 8 THEN
                        IF Instruct = CLSR THEN
                            IF P_ERR = '1' THEN
                                IF ES = '1' THEN -- erase suspend
                                    next_state <= ERSSUS;
                                ELSE
                                    next_state <= STANDBY;
                                END IF;
                            END IF;
                        ELSIF Instruct = RSTEN THEN
                            next_state <= SFT_RST_EN;
                        END IF;
                    END IF;
                END IF;

                IF rising_edge(PRGSUSP_out) THEN
                    next_state <= PGMSUS;
                END IF;
                IF rising_edge(PDONE) OR
                -- operation finished during status read
                (rising_edge(CSNeg_ipd) AND PDONE = '1' AND P_ERR = '0') THEN
                    IF ES = '1' THEN -- erase suspend
                        next_state <= ERSSUS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN SECT_ERS_ADDR =>
                IF rising_edge(CSNeg_ipd) THEN
                    IF (QPI = '1' AND
                    ((Instruct = SE4 AND addr_cnt = 8) OR
                    (Instruct = SE AND ((ADS = '0' AND addr_cnt = 6) OR (ADS = '1' AND addr_cnt = 8))))) OR
                    (QPI = '0' AND
                    ((Instruct = SE4 AND addr_cnt = 32) OR
                    (Instruct = SE AND ((ADS = '0' AND addr_cnt = 24) OR (ADS = '1' AND addr_cnt = 32))))) THEN
                        next_state <= SECT_ERS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN HALF_BLOCK_ERS_ADDR =>
                IF rising_edge(CSNeg_ipd) THEN
                    IF (QPI = '1' AND
                    ((Instruct = HBE4 AND addr_cnt = 8) OR
                    (Instruct = HBE AND ((ADS = '0' AND addr_cnt = 6) OR (ADS = '1' AND addr_cnt = 8))))) OR
                    (QPI = '0' AND
                    ((Instruct = HBE4 AND addr_cnt = 32) OR
                    (Instruct = HBE AND ((ADS = '0' AND addr_cnt = 24) OR (ADS = '1' AND addr_cnt = 32))))) THEN
                        next_state <= HALF_BLOCK_ERS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN BLOCK_ERS_ADDR =>
                IF rising_edge(CSNeg_ipd) THEN
                    IF (QPI = '1' AND
                    ((Instruct = BE4 AND addr_cnt = 8) OR
                    (Instruct = BE AND ((ADS = '0' AND addr_cnt = 6) OR (ADS = '1' AND addr_cnt = 8))))) OR
                    (QPI = '0' AND
                    ((Instruct = BE4 AND addr_cnt = 32) OR
                    (Instruct = BE AND ((ADS = '0' AND addr_cnt = 24) OR (ADS = '1' AND addr_cnt = 32))))) THEN
                        next_state <= BLOCK_ERS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN SECT_ERS | HALF_BLOCK_ERS | BLOCK_ERS =>
                IF opcode_cnt = 8 THEN
                    IF Instruct = RDSR1 THEN
                        next_state <= RDSR1_DATA_OUTPUT;
                    ELSIF Instruct = RDSR2 THEN
                        next_state <= RDSR2_DATA_OUTPUT;
                    ELSIF Instruct = RDCR1 THEN
                        next_state <= RDCR1_DATA_OUTPUT;
                    ELSIF Instruct = RDCR2 THEN
                        next_state <= RDCR2_DATA_OUTPUT;
                    ELSIF Instruct = RDCR3 THEN
                        next_state <= RDCR3_DATA_OUTPUT;
                    ELSIF Instruct = RDAR THEN
                        next_state <= RDAR_ADDR;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF opcode_cnt = 8 THEN
                        IF Instruct = CLSR THEN
                            IF E_ERR = '1' THEN
                                next_state <= STANDBY;
                            END IF;
                        ELSIF Instruct = RSTEN THEN
                            next_state <= SFT_RST_EN;
                        END IF;
                    END IF;
                END IF;
                IF rising_edge(ERSSUSP_out) THEN
                    next_state <= ERSSUS;
                END IF;
                IF rising_edge(EDONE) OR
                -- operation finished during status read
                (rising_edge(CSNeg_ipd) AND EDONE = '1' AND E_ERR = '0') THEN
                    next_state <= STANDBY;
                END IF;

            WHEN CHIP_ERS | SECT_ERS_SEC_REG =>
                IF opcode_cnt = 8 THEN
                    IF Instruct = RDSR1 THEN
                        next_state <= RDSR1_DATA_OUTPUT;
                    ELSIF Instruct = RDSR2 THEN
                        next_state <= RDSR2_DATA_OUTPUT;
                    ELSIF Instruct = RDCR1 THEN
                        next_state <= RDCR1_DATA_OUTPUT;
                    ELSIF Instruct = RDCR2 THEN
                        next_state <= RDCR2_DATA_OUTPUT;
                    ELSIF Instruct = RDCR3 THEN
                        next_state <= RDCR3_DATA_OUTPUT;
                    ELSIF Instruct = RDAR THEN
                        next_state <= RDAR_ADDR;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF opcode_cnt = 8 THEN
                        IF Instruct = CLSR THEN
                            IF E_ERR = '1' THEN
                                next_state <= STANDBY;
                            END IF;
                        ELSIF Instruct = RSTEN THEN
                            next_state <= SFT_RST_EN;
                        END IF;
                    END IF;
                END IF;
                IF rising_edge(EDONE) OR
                -- operation finished during status read
                (rising_edge(CSNeg_ipd) AND EDONE = '1' AND E_ERR = '0') THEN
                    next_state <= STANDBY;
                END IF;

            WHEN SEC_REG_PGM_ADDR =>
                IF CSNeg_ipd = '0' THEN
                    IF (QPI = '1' AND ((ADS = '0' AND addr_cnt = 6) OR (ADS = '1' AND addr_cnt = 8))) OR
                    (QPI = '0' AND ((ADS = '0' AND addr_cnt = 24) OR (ADS = '1' AND addr_cnt = 32))) THEN
                        next_state <= SEC_REG_PGM_DATAIN;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF ES = '1' THEN
                        next_state <= ERSSUS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN SEC_REG_PGM_DATAIN =>
                IF rising_edge(CSNeg_ipd) THEN
                    IF data_cnt = 0 AND byte_cnt > 0 AND Address <= SECRHiAddr THEN
                      next_state <= PGM_SEC_REG;
                    ELSIF ES = '1' THEN
                        next_state <= ERSSUS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN PGM_SEC_REG =>
                IF opcode_cnt = 8 THEN
                    IF Instruct = RDSR1 THEN
                        next_state <= RDSR1_DATA_OUTPUT;
                    ELSIF Instruct = RDSR2 THEN
                        next_state <= RDSR2_DATA_OUTPUT;
                    ELSIF Instruct = RDCR1 THEN
                        next_state <= RDCR1_DATA_OUTPUT;
                    ELSIF Instruct = RDCR2 THEN
                        next_state <= RDCR2_DATA_OUTPUT;
                    ELSIF Instruct = RDCR3 THEN
                        next_state <= RDCR3_DATA_OUTPUT;
                    ELSIF Instruct = RDAR THEN
                        next_state <= RDAR_ADDR;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF opcode_cnt = 8 THEN
                        IF Instruct = CLSR THEN
                            IF P_ERR = '1' THEN
                                IF ES = '1' THEN -- erase suspend
                                    next_state <= ERSSUS;
                                ELSE
                                    next_state <= STANDBY;
                                END IF;
                            END IF;
                        ELSIF Instruct = RSTEN THEN
                            next_state <= SFT_RST_EN;
                        END IF;
                    END IF;
                END IF;
                IF rising_edge(PDONE) OR
                -- operation finished during status read
                (rising_edge(CSNeg_ipd) AND PDONE = '1' AND P_ERR = '0') THEN
                    IF ES = '1' THEN -- erase suspend
                        next_state <= ERSSUS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN SEC_REG_ERS_ADDR =>
                IF rising_edge(CSNeg_ipd) THEN
                    IF (QPI = '1' AND ((ADS = '0' AND addr_cnt = 6) OR (ADS = '1' AND addr_cnt = 8))) OR
                    (QPI = '0' AND ((ADS = '0' AND addr_cnt = 24) OR (ADS = '1' AND addr_cnt = 32))) THEN
                        next_state <= SECT_ERS_SEC_REG;
                    ELSIF ES = '1' THEN
                        next_state <= ERSSUS;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN PGMSUS =>
                IF Instruct = READ OR Instruct = READ4 THEN
                    next_state <= RD_ADDR;
                ELSIF Instruct = FAST_READ OR Instruct = FAST_READ4 THEN
                    next_state <= FAST_RD_ADDR;
                ELSIF Instruct = DOR OR Instruct = DOR4 THEN
                    next_state <= DUALO_RD_ADDR;
                ELSIF Instruct = DIOR OR Instruct = DIOR4 THEN
                    next_state <= DUALIO_RD_ADDR;
                ELSIF Instruct = QOR OR Instruct = QOR4 THEN
                    IF QUAD = '1' THEN
                        next_state <= QUADO_RD_ADDR;
                    END IF;
                ELSIF Instruct = QIOR OR Instruct = QIOR4 THEN
                    IF QUAD = '1' OR QPI = '1' THEN
                        next_state <= QUADIO_RD_ADDR;
                    END IF;
                ELSIF Instruct = DDRQIOR OR Instruct = DDRQIOR4 THEN
                    IF QUAD = '1' OR QPI = '1' THEN
                        next_state <= DDRQUADIO_RD_ADDR;
                    END IF;
                ELSIF Instruct = DLPRD THEN
                    next_state <= DLPRD_DUMMY;
                ELSIF Instruct = IBLRD OR Instruct = IBLRD4 THEN
                    next_state <= IBLRD_ADDR;
                ELSIF Instruct = SECRR THEN
                    next_state <= SECRR_ADDR;
                ELSIF Instruct = RDID THEN
                    next_state <= RDID_DATA_OUTPUT;
                ELSIF Instruct = RDQID THEN
                    next_state <= RDQID_DATA_OUTPUT;
                ELSIF Instruct = RUID THEN
                    next_state <= RUID_DUMMY;
                ELSIF Instruct = RSFDP THEN
                    next_state <= RSFDP_ADDR;
                ELSIF Instruct = SET_BURST THEN
                    next_state <= SET_BURST_DATA_INPUT;
                ELSIF Instruct = RDSR1 THEN
                    next_state <= RDSR1_DATA_OUTPUT;
                ELSIF Instruct = RDSR2 THEN
                    next_state <= RDSR2_DATA_OUTPUT;
                ELSIF Instruct = RDCR1 THEN
                    next_state <= RDCR1_DATA_OUTPUT;
                ELSIF Instruct = RDCR2 THEN
                    next_state <= RDCR2_DATA_OUTPUT;
                ELSIF Instruct = RDCR3 THEN
                    next_state <= RDCR3_DATA_OUTPUT;
                ELSIF Instruct = RDAR THEN
                    next_state <= RDAR_ADDR;
                ELSIF Instruct = IBL OR Instruct = IBL4 THEN
                    IF WPS = '1' THEN
                        next_state <= IBL_LOCK;
                    END IF;
                ELSIF Instruct = IBUL OR Instruct = IBUL4 THEN
                    IF WPS = '1' THEN
                        next_state <= IBL_UNLOCK;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF opcode_cnt = 8 THEN
                        IF Instruct = RSTEN THEN
                            next_state <= SFT_RST_EN;
                        ELSIF Instruct = EPR THEN
                            next_state <= PGM;
                        END IF;
                    END IF;
                END IF;

            WHEN ERSSUS =>
                IF Instruct = READ OR Instruct = READ4 THEN
                    next_state <= RD_ADDR;
                ELSIF Instruct = FAST_READ OR Instruct = FAST_READ4 THEN
                    next_state <= FAST_RD_ADDR;
                ELSIF Instruct = DOR OR Instruct = DOR4 THEN
                    next_state <= DUALO_RD_ADDR;
                ELSIF Instruct = DIOR OR Instruct = DIOR4 THEN
                    next_state <= DUALIO_RD_ADDR;
                ELSIF Instruct = QOR OR Instruct = QOR4 THEN
                    IF QUAD = '1' THEN
                        next_state <= QUADO_RD_ADDR;
                    END IF;
                ELSIF Instruct = QIOR OR Instruct = QIOR4 THEN
                    IF QUAD = '1' OR QPI = '1' THEN
                        next_state <= QUADIO_RD_ADDR;
                    END IF;
                ELSIF Instruct = DDRQIOR OR Instruct = DDRQIOR4 THEN
                    IF QUAD = '1' OR QPI = '1' THEN
                        next_state <= DDRQUADIO_RD_ADDR;
                    END IF;
                ELSIF Instruct = DLPRD THEN
                    next_state <= DLPRD_DUMMY;
                ELSIF Instruct = IBLRD OR Instruct = IBLRD4 THEN
                    next_state <= IBLRD_ADDR;
                ELSIF Instruct = SECRR THEN
                    next_state <= SECRR_ADDR;
                ELSIF Instruct = RDID THEN
                    next_state <= RDID_DATA_OUTPUT;
                ELSIF Instruct = RDQID THEN
                    next_state <= RDQID_DATA_OUTPUT;
                ELSIF Instruct = RUID THEN
                    next_state <= RUID_DUMMY;
                ELSIF Instruct = RSFDP THEN
                    next_state <= RSFDP_ADDR;
                ELSIF Instruct = SET_BURST THEN
                    next_state <= SET_BURST_DATA_INPUT;
                ELSIF Instruct = RDSR1 THEN
                    next_state <= RDSR1_DATA_OUTPUT;
                ELSIF Instruct = RDSR2 THEN
                    next_state <= RDSR2_DATA_OUTPUT;
                ELSIF Instruct = RDCR1 THEN
                    next_state <= RDCR1_DATA_OUTPUT;
                ELSIF Instruct = RDCR2 THEN
                    next_state <= RDCR2_DATA_OUTPUT;
                ELSIF Instruct = RDCR3 THEN
                    next_state <= RDCR3_DATA_OUTPUT;
                ELSIF Instruct = RDAR THEN
                    next_state <= RDAR_ADDR;
                ELSIF Instruct = IBL OR Instruct = IBL4 THEN
                    IF WPS = '1' THEN
                        next_state <= IBL_LOCK;
                    END IF;
                ELSIF Instruct = IBUL OR Instruct = IBUL4 THEN
                    IF WPS = '1' THEN
                        next_state <= IBL_UNLOCK;
                    END IF;
                ELSIF Instruct = PP OR Instruct = PP4 THEN
                    IF WEL = '1' THEN
                        next_state <= PGM_ADDR;
                    END IF;
                ELSIF Instruct = QPP OR Instruct = QPP4 THEN
                    IF WEL = '1' AND QUAD = '1' THEN
                        next_state <= PGM_ADDR;
                    END IF;
                ELSIF Instruct = SECRP THEN
                    IF WEL = '1' THEN
                        next_state <= SEC_REG_PGM_ADDR;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF opcode_cnt = 8 THEN
                        IF Instruct = RSTEN THEN
                            next_state <= SFT_RST_EN;
                        ELSIF Instruct = EPR THEN
                            IF SECT_ERS_ACT = '1' THEN
                                next_state <= SECT_ERS;
                            ELSIF HALF_BLOCK_ERS_ACT = '1' THEN
                                next_state <= HALF_BLOCK_ERS;
                            ELSIF BLOCK_ERS_ACT = '1' THEN
                                next_state <= BLOCK_ERS;
                            END IF;
                        END IF;
                    END IF;
                END IF;

            WHEN WRR_DATA_INPUT =>
                IF rising_edge(CSNeg_ipd) THEN
                    IF data_cnt = 0 AND byte_cnt > 0 AND byte_cnt <= 4 THEN
                        IF SRP1 = '0' AND (SRP0 = '0' OR WPNegIn = '1' OR QUAD = '1' OR QPI = '1') THEN
                            IF WEL = '1' THEN
                                next_state <= WRR_NV;
                            ELSIF WREN_V = '1' THEN
                                next_state <= WRR_V;
                            END IF;
                        ELSE
                            next_state <= STANDBY;
                        END IF;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN WRR_NV =>
                IF opcode_cnt = 8 THEN
                    IF Instruct = RDSR1 THEN
                        next_state <= RDSR1_DATA_OUTPUT;
                    ELSIF Instruct = RDSR2 THEN
                        next_state <= RDSR2_DATA_OUTPUT;
                    ELSIF Instruct = RDCR1 THEN
                        next_state <= RDCR1_DATA_OUTPUT;
                    ELSIF Instruct = RDCR2 THEN
                        next_state <= RDCR2_DATA_OUTPUT;
                    ELSIF Instruct = RDCR3 THEN
                        next_state <= RDCR3_DATA_OUTPUT;
                    ELSIF Instruct = RDAR THEN
                        next_state <= RDAR_ADDR;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF opcode_cnt = 8 AND Instruct = CLSR AND P_ERR = '1' THEN
                        next_state <= STANDBY;
                    END IF;
                END IF;
                IF rising_edge(WDONE) OR
                -- operation finished during status read
                (rising_edge(CSNeg_ipd) AND WDONE = '1' AND P_ERR = '0') THEN
                    next_state <= STANDBY;
                END IF;

            WHEN WRR_V | WRAR_V =>
                IF rising_edge(WDONE) THEN
                    next_state <= STANDBY;
                END IF;

            WHEN WRAR_ADDR =>
                IF CSNeg_ipd = '0' THEN
                    IF (QPI = '1' AND ((ADS = '0' AND addr_cnt = 6) OR (ADS = '1' AND addr_cnt = 8))) OR
                    (QPI = '0' AND ((ADS = '0' AND addr_cnt = 24) OR (ADS = '1' AND addr_cnt = 32))) THEN
                        next_state <= WRAR_DATA_INPUT;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    next_state <= STANDBY;
                END IF;

            WHEN WRAR_DATA_INPUT =>
                IF rising_edge(CSNeg_ipd) THEN
                    IF data_cnt = 8 THEN
                        IF Address_wrar = 0 OR Address_wrar = 2 OR
                        Address_wrar = 3 OR Address_wrar = 4 OR
                        Address_wrar = 5 THEN
                            IF SRP1 = '0' AND (SRP0 = '0' OR WPNegIn = '1' OR QUAD = '1' OR QPI = '1') THEN
                                next_state <= WRAR_NV;
                            ELSE
                                next_state <= STANDBY;
                            END IF;
                        END IF;
                        IF Address_wrar >= 16#20# AND Address_wrar <= 16#27# THEN
                            IF PWDMLB = '1' THEN
                                next_state <= WRAR_NV;
                            ELSE
                                next_state <= STANDBY;
                            END IF;
                        END IF;
                        IF Address_wrar = 16#30# OR Address_wrar = 16#31# THEN
                            next_state <= WRAR_NV;
                        END IF;
                        IF Address_wrar = 16#39# OR Address_wrar = 16#3A#  OR Address_wrar = 16#3B# THEN
                            IF NVLOCK  = '1' THEN
                                next_state <= WRAR_NV;
                            ELSE
                                next_state <= STANDBY;
                            END IF;
                        END IF;
                        IF Address_wrar = 16#800000# OR Address_wrar = 16#800002# OR
                        Address_wrar = 16#800003# OR Address_wrar = 16#800005# THEN
                            IF SRP1 = '0' AND (SRP0 = '0' OR WPNegIn = '1' OR QUAD = '1' OR QPI = '1') THEN
                                next_state <= WRAR_V;
                            ELSE
                                next_state <= STANDBY;
                            END IF;
                        END IF;
                        IF Address_wrar = 16#800004# THEN
                            next_state <= WRAR_V;
                        END IF;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN WRAR_NV =>
                IF opcode_cnt = 8 THEN
                    IF Instruct = RDSR1 THEN
                        next_state <= RDSR1_DATA_OUTPUT;
                    ELSIF Instruct = RDSR2 THEN
                        next_state <= RDSR2_DATA_OUTPUT;
                    ELSIF Instruct = RDCR1 THEN
                        next_state <= RDCR1_DATA_OUTPUT;
                    ELSIF Instruct = RDCR2 THEN
                        next_state <= RDCR2_DATA_OUTPUT;
                    ELSIF Instruct = RDCR3 THEN
                        next_state <= RDCR3_DATA_OUTPUT;
                    ELSIF Instruct = RDAR THEN
                        next_state <= RDAR_ADDR;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF opcode_cnt = 8 THEN
                        IF Instruct = CLSR AND P_ERR = '1' THEN
                            next_state <= STANDBY;
                        ELSIF Instruct = RSTEN THEN
                            IF Address /= 0 AND Address /= 2 AND
                            Address /= 3 AND Address /= 4 THEN
                                next_state <= SFT_RST_EN;
                            END IF;
                        END IF;
                    END IF;
                END IF;
                IF rising_edge(WDONE) OR
                -- operation finished during status read
                (rising_edge(CSNeg_ipd) AND WDONE = '1' AND P_ERR = '0') THEN
                    next_state <= STANDBY;
                END IF;

            WHEN IRP_PGM_DATA_INPUT =>
                IF rising_edge(CSNeg_ipd) THEN
                    IF data_cnt = 0 AND byte_cnt = 2 THEN
                        next_state <= IRP_PGM;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN IRP_PGM | PGM_NV_DLR | PASS_PGM =>
                IF opcode_cnt = 8 THEN
                    IF Instruct = RDSR1 THEN
                        next_state <= RDSR1_DATA_OUTPUT;
                    ELSIF Instruct = RDSR2 THEN
                        next_state <= RDSR2_DATA_OUTPUT;
                    ELSIF Instruct = RDCR1 THEN
                        next_state <= RDCR1_DATA_OUTPUT;
                    ELSIF Instruct = RDCR2 THEN
                        next_state <= RDCR2_DATA_OUTPUT;
                    ELSIF Instruct = RDCR3 THEN
                        next_state <= RDCR3_DATA_OUTPUT;
                    ELSIF Instruct = RDAR THEN
                        next_state <= RDAR_ADDR;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF opcode_cnt = 8 THEN
                        IF Instruct = CLSR AND P_ERR = '1' THEN
                            next_state <= STANDBY;
                        ELSIF Instruct = RSTEN THEN
                            next_state <= SFT_RST_EN;
                        END IF;
                    END IF;
                END IF;
                IF rising_edge(PDONE) OR
                -- operation finished during status read
                (rising_edge(CSNeg_ipd) AND PDONE = '1' AND P_ERR = '0') THEN
                    next_state <= STANDBY;
                END IF;

            WHEN PGM_NV_DLR_DATA =>
                IF rising_edge(CSNeg_ipd) THEN
                    IF data_cnt = 8 THEN
                        next_state <= PGM_NV_DLR;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN SET_PNTR_PROT_ADDR =>
                IF rising_edge(CSNeg_ipd) THEN
                    IF (QPI = '1' AND
                    ((Instruct = SPRP4 AND addr_cnt = 8) OR
                    (Instruct = SPRP AND ((ADS = '0' AND addr_cnt = 6) OR (ADS = '1' AND addr_cnt = 8))))) OR
                    (QPI = '0' AND
                    ((Instruct = SPRP4 AND addr_cnt = 32) OR
                    (Instruct = SPRP AND ((ADS = '0' AND addr_cnt = 24) OR (ADS = '1' AND addr_cnt = 32))))) THEN
                        next_state <= SET_PNTR_PROT;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN SET_PNTR_PROT =>
                IF opcode_cnt = 8 THEN
                    IF Instruct = RDSR1 THEN
                        next_state <= RDSR1_DATA_OUTPUT;
                    ELSIF Instruct = RDSR2 THEN
                        next_state <= RDSR2_DATA_OUTPUT;
                    ELSIF Instruct = RDCR1 THEN
                        next_state <= RDCR1_DATA_OUTPUT;
                    ELSIF Instruct = RDCR2 THEN
                        next_state <= RDCR2_DATA_OUTPUT;
                    ELSIF Instruct = RDCR3 THEN
                        next_state <= RDCR3_DATA_OUTPUT;
                    ELSIF Instruct = RDAR THEN
                        next_state <= RDAR_ADDR;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF opcode_cnt = 8 THEN
                        IF Instruct = CLSR AND (P_ERR = '1' OR E_ERR = '1') THEN
                            next_state <= STANDBY;
                        ELSIF Instruct = RSTEN THEN
                            next_state <= SFT_RST_EN;
                        END IF;
                    END IF;
                END IF;
                IF rising_edge(WDONE) OR
                -- operation finished during status read
                (rising_edge(CSNeg_ipd) AND WDONE = '1' AND P_ERR = '0') THEN
                    next_state <= STANDBY;
                END IF;

            WHEN PASSP_DATA_INPUT | PASSU_DATA_INPUT =>
                IF rising_edge(CSNeg_ipd) THEN
                    IF data_cnt = 0 AND byte_cnt = 8 THEN
                        next_state <= PASS_PGM;
                    ELSE
                        next_state <= STANDBY;
                    END IF;
                END IF;

            WHEN PASS_ULCK =>
                IF opcode_cnt = 8 THEN
                    IF Instruct = RDSR1 THEN
                        next_state <= RDSR1_DATA_OUTPUT;
                    ELSIF Instruct = RDSR2 THEN
                        next_state <= RDSR2_DATA_OUTPUT;
                    ELSIF Instruct = RDCR1 THEN
                        next_state <= RDCR1_DATA_OUTPUT;
                    ELSIF Instruct = RDCR2 THEN
                        next_state <= RDCR2_DATA_OUTPUT;
                    ELSIF Instruct = RDCR3 THEN
                        next_state <= RDCR3_DATA_OUTPUT;
                    ELSIF Instruct = RDAR THEN
                        next_state <= RDAR_ADDR;
                    END IF;
                END IF;
                IF rising_edge(CSNeg_ipd) THEN
                    IF opcode_cnt = 8 THEN
                        IF Instruct = CLSR AND P_ERR = '1' THEN
                            next_state <= STANDBY;
                        ELSIF Instruct = RSTEN THEN
                            next_state <= SFT_RST_EN;
                        END IF;
                    END IF;
                END IF;
                IF rising_edge(PASSULCK_out) OR
                -- operation finished during status read
                (rising_edge(CSNeg_ipd) AND PASSULCK_out = '1' AND P_ERR = '0') THEN
                    next_state <= STANDBY;
                END IF;

        END CASE;

    END PROCESS StateGen;

  FSMStateTranEvent : PROCESS (Instruct, address_cnt, any_read)
  BEGIN
    IF Instruct'EVENT AND Instruct /= NONE THEN
      change_addr <= '1', '0' AFTER 1 ns;
    END IF;

    IF (current_state /= STANDBY) AND
    (Instruct /= WRR) AND (Instruct /= WRAR) THEN
        IF ((Instruct = READ) AND to_nat(WRR_reg_in) = 0) OR Instruct /= READ THEN
            IF ADS = '1' AND address_cnt = 32 THEN
                change_addr <= '1', '0' AFTER 1 ns;
            ELSIF ADS = '0' AND address_cnt = 24 THEN
                change_addr <= '1', '0' AFTER 1 ns;
            END IF;
        END IF;
    ELSIF current_state /= STANDBY AND
    Instruct = WRR AND address_cnt = 0 THEN
        change_addr <= '1', '0' AFTER 1 ns;
    END IF;

    IF (any_read'EVENT) THEN
      change_addr <= '1', '0' AFTER 1 ns;
    END IF;

  END PROCESS;

    ---------------------------------------------------------------------------
    --FSM Output generation and general funcionality
    ---------------------------------------------------------------------------
    Functional : PROCESS(PoweredUp, CSNeg_ipd, SCK_ipd, RES_out, WDONE, PDONE,
                         EDONE, ERSSUSP_out, PRGSUSP_out, PASSULCK_out, QEN_out,
                         QEXN_out, SFT_RST_out, HW_RST_out, change_addr)

        VARIABLE WData          : WByteType:= (OTHERS => MaxData);

        VARIABLE Addr           : NATURAL;
        VARIABLE Addr_tmp       : NATURAL;
        VARIABLE AddrLOW        : NATURAL;
        VARIABLE AddrHIGH       : NATURAL;

        VARIABLE SectorErase    : NATURAL RANGE 0 TO SecNum := 0;
        VARIABLE HalfBlockErase : NATURAL RANGE 0 TO HalfBlockNum := 0;
        VARIABLE BlockErase     : NATURAL RANGE 0 TO BlockNum := 0;

        VARIABLE data_out       : std_logic_vector(7 DOWNTO 0);

        VARIABLE old_bit        : std_logic_vector(7 DOWNTO 0);
        VARIABLE new_bit        : std_logic_vector(7 DOWNTO 0);
        VARIABLE old_int        : INTEGER RANGE -1 TO MaxData;
        VARIABLE new_int        : INTEGER RANGE -1 TO MaxData;
        --Data Learning Pattern Enable
        VARIABLE dlp_act        : BOOLEAN := FALSE;
        VARIABLE CLK_PER        : time;
        VARIABLE LAST_CLK       : time;

    PROCEDURE EndProgramming IS
    BEGIN
        WIP <= '0';
        WEL <= '0';
        PGM_ACT <= '0';
        cnt := 0;
        FOR i IN 0 TO wr_cnt LOOP
            Mem(Addr_tmp + i - cnt) := WData(i);
            IF (Addr_tmp + i) = AddrHIGH THEN
                Addr_tmp := AddrLOW;
                cnt := i + 1;
            END IF;
        END LOOP;
    END EndProgramming;

    PROCEDURE EndSECRProgramming IS
    BEGIN
        WIP <= '0';
        WEL <= '0';
        PGM_SEC_REG_ACT <= '0';
        cnt := 0;
        FOR i IN 0 TO wr_cnt LOOP
            SECRMem(Addr_tmp + i - cnt) := WData(i);
            IF (Addr_tmp + i) = AddrHIGH THEN
                Addr_tmp := AddrLOW;
                cnt := i + 1;
            END IF;
        END LOOP;
    END EndSECRProgramming;

    PROCEDURE EndSecErasing IS
    BEGIN
        WIP <= '0';
        WEL <= '0';
        SECT_ERS_ACT <= '0';
        AddrLOW  := SectorErase*(SecSize+1);
        AddrHIGH := AddrLOW + SecSize;
        FOR i IN AddrLOW TO AddrHIGH LOOP
            Mem(i) := MaxData;
        END LOOP;
    END EndSecErasing;

    PROCEDURE EndHalfBlockErasing IS
    BEGIN
        WIP <= '0';
        WEL <= '0';
        HALF_BLOCK_ERS_ACT <= '0';
        AddrLOW  := HalfBlockErase*(HalfBlockSize+1);
        AddrHIGH := AddrLOW + HalfBlockSize;
        FOR i IN AddrLOW TO AddrHIGH LOOP
            Mem(i) := MaxData;
        END LOOP;
    END EndHalfBlockErasing;

    PROCEDURE EndBlockErasing IS
    BEGIN
        WIP <= '0';
        WEL <= '0';
        BLOCK_ERS_ACT <= '0';
        AddrLOW  := BlockErase*(BlockSize+1);
        AddrHIGH := AddrLOW + BlockSize;
        FOR i IN AddrLOW TO AddrHIGH LOOP
            Mem(i) := MaxData;
        END LOOP;
    END EndBlockErasing;

    PROCEDURE EndChipErasing IS
    BEGIN
        WIP <= '0';
        WEL <= '0';
        CHIP_ERS_ACT <= '0';
        FOR i IN 0 TO AddrRANGE LOOP
            Mem(i) := MaxData;
        END LOOP;
    END EndChipErasing;

    PROCEDURE EndSECRErasing IS
    BEGIN
        WIP <= '0';
        WEL <= '0';
        SECT_ERS_SEC_REG_ACT <= '0';
        AddrLOW  := sec_region*(SecRegSize+1);
        AddrHIGH := AddrLOW + SecRegSize;
        FOR i IN AddrLOW TO AddrHIGH LOOP
            SECRMem(i) := MaxData;
        END LOOP;
    END EndSECRErasing;

    PROCEDURE EndWRR_NV IS
    BEGIN
        WIP <= '0';
        WEL <= '0';
        WRR_NV_ACT <= '0';
        IF byte_cnt = 1 OR byte_cnt = 2 OR byte_cnt = 3 OR byte_cnt = 4 THEN
            SR1_in <= WRR_reg_in(7 DOWNTO 0);
            SR1_NV(7 DOWNTO 2) <= WRR_reg_in(7 DOWNTO 2); -- SRP0, TBPROT, BP3-BP0
            SR1_V(7 DOWNTO 2)  <= WRR_reg_in(7 DOWNTO 2);
        END IF;
        IF byte_cnt = 2 OR byte_cnt = 3 OR byte_cnt = 4 THEN
            CR1_in <= WRR_reg_in(15 DOWNTO 8);
            CR1_NV(6) <= WRR_reg_in(14);  --CMP
            CMP <= WRR_reg_in(14);

            IF CR1_in(5) = '1' THEN  -- OTP LB3
                CR1_NV(5) <= WRR_reg_in(13);
                CR1_V(5)  <= WRR_reg_in(13);
            END IF;

            IF CR1_in(4) = '1' THEN  -- OTP LB2
                CR1_NV(4) <= WRR_reg_in(12);
                CR1_V(4)  <= WRR_reg_in(12);
            END IF;

            IF CR1_in(3) = '1' THEN  -- OTP LB1
                CR1_NV(3) <= WRR_reg_in(11);
                CR1_V(3)  <= WRR_reg_in(11);
            END IF;

            IF CR1_in(2) = '1' THEN  -- OTP LB0
                CR1_NV(2) <= WRR_reg_in(10);
                CR1_V(2)  <= WRR_reg_in(10);
            END IF;

            IF QIO_ONLY_OPN = '0' THEN   -- QUAD
                CR1_NV(1) <= WRR_reg_in(9);
                CR1_V(1)  <= WRR_reg_in(9);
            END IF;

            IF CR1_in(0) = '1' THEN  -- OTP SRP1
                CR1_V(0) <= '1';
                IF IRP(2 DOWNTO 0) = "111" THEN
                    CR1_NV(0) <= '1';
                END IF;
            END IF;
        END IF;
        IF byte_cnt = 3 OR byte_cnt = 4 THEN
            CR2_in <= WRR_reg_in(23 DOWNTO 16);
            CR2_NV(7) <= WRR_reg_in(23); -- IO3R
            IO3R <= WRR_reg_in(23);

            CR2_NV(6 DOWNTO 5) <= WRR_reg_in(22 DOWNTO 21); -- OI
            CR2_V(6 DOWNTO 5)  <= WRR_reg_in(22 DOWNTO 21);

            IF QPI_ONLY_OPN = '0' THEN   -- QPI
                CR2_NV(3) <= WRR_reg_in(19);
                QPI <= WRR_reg_in(19);
            END IF;
            CR2_NV(2) <= WRR_reg_in(18); -- WPS
            WPS <= WRR_reg_in(18);

            CR2_NV(1) <= WRR_reg_in(17); -- Address length
            ADS <= WRR_reg_in(17); -- Address length
        END IF;
        IF byte_cnt = 4 THEN
            CR3_in <= WRR_reg_in(31 DOWNTO 24);
            CR3_NV(6 DOWNTO 0) <= WRR_reg_in(30 DOWNTO 24); -- WL, WE, RL
            CR3_V(6 DOWNTO 0)  <= WRR_reg_in(30 DOWNTO 24);
        END IF;
    END EndWRR_NV;

    PROCEDURE EndWRR_V IS
    BEGIN
        WIP    <= '0';
        WREN_V <= '0';
        IF byte_cnt = 1 OR byte_cnt = 2 OR byte_cnt = 3 OR byte_cnt = 4 THEN
            SR1_in <= WRR_reg_in(7 DOWNTO 0);
            SR1_V(7 DOWNTO 2) <= WRR_reg_in(7 DOWNTO 2);-- SRP0, TBPROT, BP3-BP0
        END IF;
        IF byte_cnt = 2 OR byte_cnt = 3 OR byte_cnt = 4 THEN
            CR1_in <= WRR_reg_in(15 DOWNTO 8);
            CMP <= WRR_reg_in(14);
            IF QIO_ONLY_OPN = '0' THEN    -- QUAD
                IF WRR_reg_in(9) = '1' AND CR1_V(1) = '0' THEN -- enter QUAD mode
                    QEN_in <= '1';
                ELSIF WRR_reg_in(9) = '0' AND CR1_V(1) = '1' THEN -- exit QUAD mode
                    QEXN_in <= '1';
                END IF;
                CR1_V(1) <= WRR_reg_in(9);
            END IF;
            IF WRR_reg_in(8) = '1' THEN  -- SRP1
                CR1_V(0) <= WRR_reg_in(8);
            END IF;
        END IF;
        IF byte_cnt = 3 OR byte_cnt = 4 THEN
            CR2_in <= WRR_reg_in(23 DOWNTO 16);
            IO3R <= WRR_reg_in(23);
            CR2_V(6 DOWNTO 5) <= WRR_reg_in(22 DOWNTO 21); -- OI

            IF QPI_ONLY_OPN = '0' THEN   -- QPI
                IF CR2_in(3) = '1' AND QPI = '0' THEN -- enter QPI mode
                    QEN_in <= '1';
                END IF;
                IF CR2_in(3) = '0' AND QPI = '1' THEN -- exit QPI mode
                    QEXN_in <= '1';
                END IF;
                QPI <= WRR_reg_in(19);
            END IF;

            WPS <= WRR_reg_in(18); -- WPS
            ADS <= WRR_reg_in(16); -- Address length
        END IF;
        IF byte_cnt = 4 THEN
            CR3_in <= WRR_reg_in(31 DOWNTO 24);
            CR3_V(6 DOWNTO 5) <= CR3_in(6 DOWNTO 5); -- WL
            CR3_V(4) <= CR3_in(4);     -- WE
            CR3_V(3 DOWNTO 0) <= CR3_in(3 DOWNTO 0); -- RL
        END IF;
    END EndWRR_V;

    PROCEDURE EndWRAR_NV IS
    BEGIN
        WIP <= '0';
        WEL <= '0';
        WRAR_NV_ACT <= '0';
        IF Address_wrar = 0 THEN
            SR1_in <= WRAR_in;
            SR1_NV(7 DOWNTO 2) <= WRAR_in(7 DOWNTO 2); -- SRP0, TBPROT, BP3-BP0
            SR1_V(7 DOWNTO 2)  <= WRAR_in(7 DOWNTO 2);
        ELSIF Address_wrar = 2 THEN
            CR1_in <= WRAR_in;

            CR1_NV(6) <= WRAR_in(6);  --CMP
            CMP <= WRAR_in(6);

            IF WRAR_in(5) = '1' THEN  -- OTP LB3
                CR1_NV(5) <= WRAR_in(5);
                CR1_V(5)  <= WRAR_in(5);
            END IF;

            IF WRAR_in(4) = '1' THEN  -- OTP LB2
                CR1_NV(4) <= WRAR_in(4);
                CR1_V(4)  <= WRAR_in(4);
            END IF;

            IF WRAR_in(3) = '1' THEN  -- OTP LB1
                CR1_NV(3) <= WRAR_in(3);
                CR1_V(3)  <= WRAR_in(3);
            END IF;

            IF WRAR_in(2) = '1' THEN  -- OTP LB0
                CR1_NV(2) <= WRAR_in(2);
                CR1_V(2)  <= WRAR_in(2);
            END IF;

            IF QIO_ONLY_OPN = '0' THEN    -- QUAD
                CR1_NV(1) <= WRAR_in(1);
                CR1_V(1)  <= WRAR_in(1);
            END IF;

            IF WRAR_in(0) = '1' THEN  -- OTP SRP1
                CR1_V(0) <= '1';
                IF IRP(2 DOWNTO 0) = "111" THEN
                    CR1_NV(0) <= '1';
                END IF;
            END IF;
        ELSIF Address_wrar = 3 THEN
            CR2_in <= WRAR_in;

            CR2_NV(7) <= WRAR_in(7); -- IO3R
            IO3R <= WRAR_in(7);

            CR2_NV(6 DOWNTO 5) <= WRAR_in(6 DOWNTO 5); -- OI
            CR2_V(6 DOWNTO 5)  <= WRAR_in(6 DOWNTO 5);

            IF QPI_ONLY_OPN = '0' THEN   -- QPI
                CR2_NV(3) <= WRAR_in(3);
                QPI <= WRAR_in(3);
            END IF;
            CR2_NV(2) <= WRAR_in(2); -- WPS
            WPS <= WRAR_in(2);

            CR2_NV(1) <= WRAR_in(1); -- Address length
            ADS <= WRAR_in(1); -- Address length
        ELSIF Address_wrar = 4 THEN
            CR3_in <= WRAR_in;
            CR3_NV(6 DOWNTO 0) <= WRAR_in(6 DOWNTO 0); -- WL, WE, RL
            CR3_V(6 DOWNTO 0)  <= WRAR_in(6 DOWNTO 0);
        ELSIF Address_wrar = 5 THEN
            FOR i IN 0 TO 7 LOOP
                IF DLRNV(i) = '0' THEN -- OTP Non-volatile DDR Data Learning Pattern reg
                    DLRNV(i) := WRAR_in(i);
                END IF;
            END LOOP;
        ELSIF Address_wrar = 16#20# AND PWDMLB = '1' THEN
            FOR i IN 0 TO 7 LOOP
                IF Password_reg(i) = '1' THEN -- OTP Non-volatile Password register
                    Password_reg(i) := WRAR_in(i);
                END IF;
            END LOOP;
        ELSIF Address_wrar = 16#21# AND PWDMLB = '1' THEN
            FOR i IN 0 TO 7 LOOP
                IF Password_reg(8+i) = '1' THEN
                    Password_reg(8+i) := WRAR_in(i);
                END IF;
            END LOOP;
        ELSIF Address_wrar = 16#22# AND PWDMLB = '1' THEN
            FOR i IN 0 TO 7 LOOP
                IF Password_reg(16+i) = '1' THEN
                    Password_reg(16+i) := WRAR_in(i);
                END IF;
            END LOOP;
        ELSIF Address_wrar = 16#23# AND PWDMLB = '1' THEN
            FOR i IN 0 TO 7 LOOP
                IF Password_reg(24+i) = '1' THEN
                    Password_reg(24+i) := WRAR_in(i);
                END IF;
            END LOOP;
        ELSIF Address_wrar = 16#24# AND PWDMLB = '1' THEN
            FOR i IN 0 TO 7 LOOP
                IF Password_reg(32+i) = '1' THEN
                    Password_reg(32+i) := WRAR_in(i);
                END IF;
            END LOOP;
        ELSIF Address_wrar = 16#25# AND PWDMLB = '1' THEN
            FOR i IN 0 TO 7 LOOP
                IF Password_reg(40+i) = '1' THEN
                    Password_reg(40+i) := WRAR_in(i);
                END IF;
            END LOOP;
        ELSIF Address_wrar = 16#26# AND PWDMLB = '1' THEN
            FOR i IN 0 TO 7 LOOP
                IF Password_reg(48+i) = '1' THEN
                    Password_reg(48+i) := WRAR_in(i);
                END IF;
            END LOOP;
        ELSIF Address_wrar = 16#27# AND PWDMLB = '1' THEN
            FOR i IN 0 TO 7 LOOP
                IF Password_reg(56+i) = '1' THEN
                    Password_reg(56+i) := WRAR_in(i);
                END IF;
            END LOOP;
        ELSIF Address_wrar = 16#30# THEN
            IF IRP(6) = '1' THEN
                IRP(6) := WRAR_in(6); -- OTP
            END IF;
            IF IRP(4) = '1' THEN
                IRP(4) := WRAR_in(4);
            END IF;
            IF WRAR_in(2 DOWNTO 0) = "110" OR WRAR_in(2 DOWNTO 0) = "101" OR
            WRAR_in(2 DOWNTO 0) = "011" THEN
                IRP(2 DOWNTO 0) := WRAR_in(2 DOWNTO 0);
            END IF;
        ELSIF Address_wrar = 16#39# THEN
            PRPR(15 DOWNTO 8) <= WRAR_in;
        ELSIF Address_wrar = 16#3A# THEN
            PRPR(23 DOWNTO 16) <= WRAR_in;
        ELSIF Address_wrar = 16#3B# THEN
            PRPR(31 DOWNTO 24) <= WRAR_in;
        END IF;
    END EndWRAR_NV;

    PROCEDURE EndWRAR_V IS
    BEGIN
        WIP <= '0';
        WEL <= '0';
        WREN_V <= '0';
        IF Address_wrar = 16#800000# THEN
            SR1_in <= WRAR_in(7 DOWNTO 0);
            SR1_V(7 DOWNTO 2) <= WRAR_in(7 DOWNTO 2); -- SRP0, TBPROT, BP3-BP0
        ELSIF Address_wrar = 16#800002# THEN
            CR1_in <= WRAR_in;
            CMP <= WRAR_in(6);
            IF QIO_ONLY_OPN = '0' THEN -- QUAD
                IF WRAR_in(1) = '1' AND WRAR_in(1) = '0' THEN -- enter QUAD mode
                    CR1_V(1) <= WRAR_in(1);
                    QEN_in   <= '1';
                ELSIF WRAR_in(1) = '0' AND WRAR_in(1) = '1' THEN -- exit QUAD mode
                    CR1_V(1) <= WRAR_in(1);
                    QEXN_in  <= '1';
                END IF;
            END IF;
            IF WRAR_in(0) = '1' THEN -- SRP1
                CR1_V(0) <= WRAR_in(0);
            END IF;
        ELSIF Address_wrar = 16#800003# THEN
            CR2_in <= WRAR_in;

            IO3R <= WRAR_in(7);
            CR2_V(6 DOWNTO 5) <= WRAR_in(6 DOWNTO 5); -- OI

            IF QPI_ONLY_OPN = '0' THEN -- QPI
                IF WRAR_in(3) = '1' AND QPI = '0' THEN -- enter QPI mode
                    QPI <= WRAR_in(3);
                    QEN_in <= '1';
                ELSIF WRAR_in(3) = '0' AND QPI = '1' THEN -- exit QPI mode
                    QPI <= WRAR_in(3);
                    QEXN_in <= '1';
                END IF;
            END IF;

            WPS <= WRAR_in(2); -- WPS
            ADS <= WRAR_in(0); -- Address length
        ELSIF Address_wrar = 16#800004# THEN
            CR3_in <= WRAR_in;
            CR3_V(6 DOWNTO 5) <= WRAR_in(6 DOWNTO 5); -- WL
            CR3_V(4) <= WRAR_in(4);     -- WE
            CR3_V(3 DOWNTO 0) <= WRAR_in(3 DOWNTO 0); -- RL
        ELSIF Address_wrar = 16#800005# THEN
            DLRV := WRAR_in;
        END IF;
    END EndWRAR_V;

    PROCEDURE EndIRPP IS
    BEGIN
        WIP <= '0';
        IRP_ACT <= '0';
        IF IRP(6) = '1' THEN
            IRP(6) := IRP_in(6);
        END IF;
        IF IRP(4) = '1' THEN
            IRP(4) := IRP_in(4);
        END IF;
        IF IRP_in(2 DOWNTO 0) = "110" OR IRP_in(2 DOWNTO 0) = "101" OR
        IRP_in(2 DOWNTO 0) = "011" THEN
            IRP(2 DOWNTO 0) := IRP_in(2 DOWNTO 0);
        END IF;
    END EndIRPP;

    PROCEDURE EndPassProgramming IS
    BEGIN
        WIP <= '0';
        WEL <= '0';
        PASS_PGM_ACT <= '0';
        FOR i IN 0 TO 63 LOOP
            IF Password_reg(i) = '1' THEN -- OTP Non-volatile Password register
                Password_reg(i) := Password_reg_in(i);
            END IF;
        END LOOP;
    END EndPassProgramming;

    PROCEDURE EndSPRP IS
    BEGIN
        WIP <= '0';
        WEL <= '0';
        SET_PNTR_PROT_ACT <= '0';
        PRPR <= PRPR_in;
    END EndSPRP;


        PROCEDURE READ_ALL_REG(
            VARIABLE RDAR_reg : INOUT std_logic_vector(7 DOWNTO 0);
            VARIABLE Addr     : NATURAL) IS
        BEGIN
            IF Addr = 16#0000000# THEN
                RDAR_reg := SR1_NV;
            ELSIF Addr = 16#0000002# THEN
                RDAR_reg := CR1_NV;
            ELSIF Addr = 16#0000003# THEN
                RDAR_reg := CR2_NV;
            ELSIF Addr = 16#0000004# THEN
                RDAR_reg := CR3_NV;
            ELSIF Addr = 16#0000005# THEN
                RDAR_reg := DLRNV;
            ELSIF Addr = 16#0000020# THEN
                IF PWDMLB = '1' THEN
                    RDAR_reg := Password_reg(7 DOWNTO 0);
                ELSE
                    RDAR_reg := "XXXXXXXX";
                END IF;
            ELSIF Addr = 16#00000021# THEN
                IF PWDMLB = '1' THEN
                    RDAR_reg := Password_reg(15 DOWNTO 8);
                ELSE
                    RDAR_reg := "XXXXXXXX";
                END IF;
            ELSIF Addr = 16#00000022# THEN
                IF PWDMLB = '1' THEN
                    RDAR_reg := Password_reg(23 DOWNTO 16);
                ELSE
                    RDAR_reg := "XXXXXXXX";
                END IF;
            ELSIF Addr = 16#00000023# THEN
                IF PWDMLB = '1' THEN
                    RDAR_reg := Password_reg(31 DOWNTO 24);
                ELSE
                    RDAR_reg := "XXXXXXXX";
                END IF;
            ELSIF Addr = 16#0000024# THEN
                IF PWDMLB = '1' THEN
                    RDAR_reg := Password_reg(39 DOWNTO 32);
                ELSE
                    RDAR_reg := "XXXXXXXX";
                END IF;
            ELSIF Addr = 16#0000025# THEN
                IF PWDMLB = '1' THEN
                    RDAR_reg := Password_reg(47 DOWNTO 40);
                ELSE
                    RDAR_reg := "XXXXXXXX";
                END IF;
            ELSIF Addr = 16#0000026# THEN
                IF PWDMLB = '1' THEN
                    RDAR_reg := Password_reg(55 DOWNTO 48);
                ELSE
                    RDAR_reg := "XXXXXXXX";
                END IF;
            ELSIF Addr = 16#0000027# THEN
                IF PWDMLB = '1' THEN
                    RDAR_reg := Password_reg(63 DOWNTO 56);
                ELSE
                    RDAR_reg := "XXXXXXXX";
                END IF;
            ELSIF Addr = 16#0000030# THEN
                RDAR_reg := IRP(7 DOWNTO 0);
            ELSIF Addr = 16#0000031# THEN
                RDAR_reg := IRP(15 DOWNTO 8);
            ELSIF Addr = 16#0000039# THEN
                RDAR_reg := PRPR(15 DOWNTO 8);
            ELSIF Addr = 16#000003A# THEN
                RDAR_reg := PRPR(23 DOWNTO 16);
            ELSIF Addr = 16#000003B# THEN
                RDAR_reg := PRPR(31 DOWNTO 24);

            ELSIF Addr = 16#0800000# THEN
                RDAR_reg := SR1_V;
            ELSIF Addr = 16#0800001# THEN
                RDAR_reg := SR2_V;
            ELSIF Addr = 16#0800002# THEN
                RDAR_reg := CR1_V;
            ELSIF Addr = 16#0800003# THEN
                RDAR_reg := CR2_V;
            ELSIF Addr = 16#0800004# THEN
                RDAR_reg := CR3_V;
            ELSIF Addr = 16#0800005# THEN
                RDAR_reg := DLRV;
            ELSIF Addr = 16#0800040# THEN
                RDAR_reg := PR;
            ELSE
                RDAR_reg := "XXXXXXXX";
            END IF;
        END READ_ALL_REG;

        FUNCTION Return_DLP (Latency_code : NATURAL; dummy_cnt : NATURAL)
                                                RETURN BOOLEAN IS
            VARIABLE result : BOOLEAN;
        BEGIN
            IF (Latency_code >= 4) AND (dummy_cnt >= (2*Latency_code-8)) THEN
                result := TRUE;
            ELSE
                result := FALSE;
            END IF;
            RETURN result;
        END Return_DLP;

    BEGIN
        -----------------------------------------------------------------------
        -- Functionality Section
        -----------------------------------------------------------------------
        IF CSNeg_ipd'EVENT AND mode_byte(7 DOWNTO 4) = "1010" THEN
            read_cnt := 0;
            addr_cnt := 0;
        END IF;

        IF rising_edge(PoweredUp) THEN
            SR1_NV <= (OTHERS => '0');
            SR1_V  <= (OTHERS => '0');
            SR2_V  <= (OTHERS => '0');
            IF QIO_ONLY_OPN = '1' THEN
                CR1_NV <= "00000010";--16#02#;
                CR1_V  <= "00000010";--16#02#;
            END IF;
            IF QPI_ONLY_OPN = '1' THEN
                CR2_NV <= "01101000";--16#68#;
                CR2_V  <= "01101000";--16#68#;
            END IF;
            CR3_NV  <= "01111000";--16#78#;
            CR3_V   <= "01111000";--16#78#;
            IF SECURE_OPN = '1' THEN
                IRP := (OTHERS => '1');
            END IF;
            Password_reg := (OTHERS => '1');
            PR      := "01000001";--16#41#;
            PRPR    <= (OTHERS => '1');
            DLRV    := (OTHERS => '0');
            DLRNV   := (OTHERS => '0');
            IBL_Sec_Prot <= (OTHERS => '0');
        END IF;

        IF PoweredUp = '1' THEN
            CASE current_state IS
                WHEN STANDBY =>
                    IF falling_edge(CSNeg_ipd) THEN
                        Instruct <= NONE;
                        opcode := (OTHERS => '0');
                        opcode_cnt := 0;
                        addr_cnt   := 0;
                        dummy_cnt  := 0;
                        mode_cnt   := 0;
                        DPD_ACT    <= '0';
                        dlp_act    := FALSE;
                        RES_in     <= '0';
                        Address    := 0;
                        Address_in := (OTHERS => '0');
                        mode_byte  := (OTHERS => '0');
                        data_cnt   := 0;
                        bit_cnt    := 0;
                        read_cnt   := 0;
                        byte_cnt   := 0;
                        PGM_ACT    <= '0';
                        PGM_SEC_REG_ACT <= '0';
                        SECT_ERS_ACT    <= '0';
                        HALF_BLOCK_ERS_ACT <= '0';
                        BLOCK_ERS_ACT <= '0';
                        CHIP_ERS_ACT  <= '0';
                        SECT_ERS_SEC_REG_ACT <= '0';
                        WRR_NV_ACT  <= '0';
                        WRAR_NV_ACT <= '0';
                        IRP_ACT     <= '0';
                        DLRNV_ACT   <= '0';
                        SET_PNTR_PROT_ACT <= '0';
                        PASS_PGM_ACT <= '0';
                        PASSULCK_in  <= '0';
                        PS <= '0';
                        ES <= '0';
                        PRGSUSP_in <= '0';
                        ERSSUSP_in <= '0';
                        normal_rd <= false;
                        fast_rd   <= true;
                        ddr_rd    <= false;
                        reg_rd    <= false;
                        frst_addr_nibb <= false;
                        Latency_code := to_nat(CR3_V(3 DOWNTO 0));
                        CLK_PER   := 0 ns;
                        LAST_CLK  := 0 ns;
                        IF Latency_code = 0 THEN
                            Latency_code := 8;
                        END IF;
                        IF CR3_V(6 DOWNTO 5) = "00" THEN
                            WrapLength := 8;
                        END IF;
                        IF CR3_V(6 DOWNTO 5) = "01" THEN
                            WrapLength := 16;
                        END IF;
                        IF CR3_V(6 DOWNTO 5) = "10" THEN
                            WrapLength := 32;
                        END IF;
                        IF CR3_V(6 DOWNTO 5) = "11" THEN
                            WrapLength := 64;
                        END IF;
                    END IF;

                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' AND
                    QEN_in = '0' AND QEXN_in = '0' THEN
                        IF QPI = '1' THEN
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := IO3RESETNegIn;
                                opcode(6-opcode_cnt) := WPNegIn;
                                opcode(5-opcode_cnt) := SOIn;
                                opcode(4-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 4;
                        ELSE
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 1;
                        END IF;

                        IF opcode_cnt = 8 THEN
                            Instruct <= NONE;
                            CASE opcode IS
                                WHEN "00000011"  =>
                                    Instruct <= READ; -- 03h
                                WHEN "00010011"  =>
                                    Instruct <= READ4; -- 13h
                                WHEN "00001011"  =>
                                    Instruct <= FAST_READ; -- 0Bh
                                WHEN "00001100"  =>
                                    Instruct <= FAST_READ4; -- 0Ch
                                WHEN "00111011"  =>
                                    Instruct <= DOR; -- 3Bh
                                WHEN "00111100"  =>
                                    Instruct <= DOR4; -- 3Ch
                                WHEN "10111011"  =>
                                    Instruct <= DIOR; -- BBh
                                WHEN "10111100"  =>
                                    Instruct <= DIOR4; -- BCh
                                WHEN "01101011"  =>
                                    Instruct <= QOR; -- 6Bh
                                WHEN "01101100"  =>
                                    Instruct <= QOR4; -- 6Ch
                                WHEN "11101011"  =>
                                    Instruct <= QIOR; -- EBh
                                WHEN "11101100"  =>
                                    Instruct <= QIOR4; -- ECh
                                WHEN "11101101"  =>
                                    Instruct <= DDRQIOR; -- EDh
                                WHEN "11101110"  =>
                                    Instruct <= DDRQIOR4; -- EEh
                                WHEN "01000001"  =>
                                    Instruct <= DLPRD; -- 41h
                                    Latency_code := 1;
                                WHEN "00101011"  =>
                                    Instruct <= IRPRD; -- 2Bh
                                    Latency_code := 1;
                                WHEN "00111101"  =>
                                    Instruct <= IBLRD;-- 3Dh
                                WHEN "11100000"  =>
                                    Instruct <= IBLRD4;-- E0h
                                WHEN "01100110"  =>
                                    Instruct <= RSTEN; -- 66h
                                WHEN "10011001"  =>
                                    Instruct <= RSTCMD; -- 99h
                                WHEN "01001000"  =>
                                    Instruct <= SECRR; -- 48h
                                WHEN "11100111"  =>
                                    Instruct <= PASSRD; -- E7h
                                    Latency_code := 1;
                                WHEN "10100111"  =>
                                    Instruct <= PRRD; -- A7h
                                    Latency_code := 1;
                                WHEN "10011111"  =>
                                    Instruct <= RDID;-- 9Fh
                                WHEN "10101111"  =>
                                    Instruct <= RDQID;-- AFh
                                WHEN "01001011"  =>
                                    Instruct <= RUID; -- 4Bh
                                    Latency_code := 32;
                                WHEN "01011010"  =>
                                    Instruct <= RSFDP;-- 5Ah
                                WHEN "01110111"  =>
                                    Instruct <= SET_BURST; -- 77h
                                WHEN "10110111"  =>
                                    Instruct <= BEN4; -- B7h
                                WHEN "11101001"  =>
                                    Instruct <= BEX4; -- E9h
                                WHEN "00111000"  =>
                                    Instruct <= QPIEN; -- 38h
                                WHEN "11110101"  =>
                                    Instruct <= QPIEX; -- F5h
                                WHEN "00000101"  =>
                                    Instruct <= RDSR1; -- 05h
                                WHEN "00000111"  =>
                                    Instruct <= RDSR2; -- 07h
                                WHEN "00110101"  =>
                                    Instruct <= RDCR1; -- 35h
                                WHEN "00010101"  =>
                                    Instruct <= RDCR2; -- 15h
                                WHEN "00110011"  =>
                                    Instruct <= RDCR3; -- 33h
                                WHEN "01100101"  =>
                                    Instruct <= RDAR; -- 65h
                                WHEN "10111001"  => Instruct <= DEEP_PD; -- B9h
                                WHEN "10101011"  => Instruct <= RES; -- ABh
                                WHEN "00000110"  => Instruct <= WREN; -- 06h
                                WHEN "01010000"  => Instruct <= WRENV; -- 50h
                                WHEN "00000100"  => Instruct <= WRDI; -- 04h
                                WHEN "00110000"  => Instruct <= CLSR; -- 30h
                                WHEN "00000010"  => Instruct <= PP; -- 02h
                                WHEN "00010010"  => Instruct <= PP4; -- 12h
                                WHEN "00110010"  => Instruct <= QPP; -- 32h
                                WHEN "00110100"  => Instruct <= QPP4; -- 34h
                                WHEN "00100000"  => Instruct <= SE; -- 20h
                                WHEN "00100001"  => Instruct <= SE4; -- 21h
                                WHEN "01010010"  => Instruct <= HBE; -- 52h
                                WHEN "01010011"  => Instruct <= HBE4; -- 53h
                                WHEN "11011000"  => Instruct <= BE; -- D8h
                                WHEN "11011100"  => Instruct <= BE4; -- DCh
                                WHEN "01100000"  => Instruct <= CE; -- 60h
                                WHEN "11000111"  => Instruct <= CE; -- C7h
                                WHEN "00110110"  => Instruct <= IBL; -- 36h
                                WHEN "11100001"  => Instruct <= IBL4; -- E1h
                                WHEN "00101111"  => Instruct <= IRPP;
                                WHEN "00000001"  => Instruct <= WRR; -- 01h
                                WHEN "01110001"  => Instruct <= WRAR; -- 71h
                                WHEN "11101000"  => Instruct <= PASSP; -- E8h
                                WHEN "01000010"  => Instruct <= SECRP; -- 42h
                                WHEN "01000100"  => Instruct <= SECRE; -- 44h
                                WHEN "11101010"  => Instruct <= PASSU; -- EAh
                                WHEN "10100110"  => Instruct <= PRL; -- A6h
                                WHEN "00111001"  => Instruct <= IBUL; -- 39h
                                WHEN "11100010"  => Instruct <= IBUL4; -- E2h
                                WHEN "01111110"  => Instruct <= GBL; -- 7Eh
                                WHEN "10011000"  => Instruct <= GBUL; -- 98h
                                WHEN "11111011"  => Instruct <= SPRP; -- FBh
                                WHEN "11100011"  => Instruct <= SPRP4; -- E3h
                                WHEN "01000011"  => Instruct <= PDLRNV; -- 43h
                                WHEN "01001010"  => Instruct <= WDLRV; -- 4Ah

                                WHEN others =>
                                    null;

                            END CASE;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) THEN
                        IF opcode_cnt = 8 THEN
                            IF Instruct = DEEP_PD THEN
                                DPD_in <= '1';
                            ELSIF Instruct = BEN4 THEN
                                IF srp1 = '0' AND (srp0 = '0' OR WPNegIn = '1' OR QUAD = '1' OR QPI = '1') THEN
                                    ADS <= '1';
                                END IF;
                            ELSIF Instruct = BEX4 THEN
                                IF srp1 = '0' AND (srp0 = '0' OR WPNegIn = '1' OR QUAD = '1' OR QPI = '1') THEN
                                    ADS <= '0';
                                END IF;
                            ELSIF Instruct = QPIEN THEN
                                IF QPI_ONLY_OPN = '0' THEN
                                    IF srp1 = '0' AND (srp0 = '0' OR WPNegIn = '1' OR QUAD = '1' OR QPI = '1') THEN
                                        QPI <= '1';
                                        QEN_in <= '1';
                                    END IF;
                                END IF;
                            ELSIF Instruct = QPIEX THEN
                                IF QPI_ONLY_OPN = '0' THEN
                                    IF srp1 = '0' AND (srp0 = '0' OR WPNegIn = '1' OR QUAD = '1' OR QPI = '1') THEN
                                        QPI <= '0';
                                        QEXN_in <= '1';
                                    END IF;
                                END IF;
                            ELSIF Instruct = WREN THEN
                                WEL <= '1';
                                WREN_V <= '0';
                            ELSIF Instruct = WRENV THEN
                                WEL <= '0';
                                WREN_V <= '1';
                            ELSIF Instruct = WRDI THEN
                                WEL <= '0';
                                WREN_V <= '0';
                            ELSIF Instruct = CLSR THEN
                                WIP <= '0';
                                WEL <= '0';
                                WREN_V <= '0';
                                P_ERR <= '0';
                                E_ERR <= '0';
                            ELSIF Instruct = CE THEN
                                IF WEL = '1' THEN
                                    WIP <= '1';
                                    IF to_nat(Sec_Prot) /= 0 THEN
                                        E_ERR <= '1';
                                    ELSE
                                        ESTART <= '1', '0' AFTER 1 ns;
                                        FOR i IN 0 TO AddrRANGE LOOP
                                            Mem(i) := -1;
                                        END LOOP;
                                    END IF;
                                END IF;
                            ELSIF Instruct = PRL THEN
                                IF WEL = '1' THEN
                                    NVLOCK := '0';
                                    SECRRP := IRP(6);
                                END IF;
                            ELSIF Instruct = GBL THEN
                                IF WPS = '1' THEN
                                    IBL_Sec_Prot <= (OTHERS => '0');
                                END IF;
                            ELSIF Instruct = GBUL THEN
                                IF WPS = '1' THEN
                                    IBL_Sec_Prot <= (OTHERS => '1');
                                END IF;
                            END IF;
                        END IF;
                    END IF;

                WHEN SFT_RST_EN =>
                    IF falling_edge(CSNeg_ipd) THEN
                        Instruct <= NONE;
                        opcode_cnt := 0;
                    END IF;
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := IO3RESETNegIn;
                                opcode(6-opcode_cnt) := WPNegIn;
                                opcode(5-opcode_cnt) := SOIn;
                                opcode(4-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 4;
                        ELSE
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 1;
                        END IF;
                        IF opcode_cnt = 8 THEN
                            IF opcode = "10011001" THEN -- 99h (RST)
                                Instruct <= RSTCMD;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) THEN
                        IF opcode_cnt = 8 THEN
                            IF Instruct = RSTCMD THEN
                                SFT_RST_in <= '1', '0' AFTER 1 ns;
                            END IF;
                        END IF;
                    END IF;

                WHEN RESET_STATE =>
                    IF rising_edge(SFT_RST_out) THEN
                        SR1_V     <= SR1_NV;
                        SR2_V     <= (OTHERS => '0');
                        CR1_V(7 DOWNTO 1)<= CR1_NV(7 DOWNTO 1);
                        CR2_V(7 DOWNTO 1)<= CR2_NV(7 DOWNTO 1);
                        ADS       <= CR2_NV(1);
                        CR3_V     <= CR3_NV;
                        DLRV      := DLRNV;
                        PR(6)     := IRP(6);
                        IF IRP(4) = '1' THEN -- IBL lock
                            IBL_Sec_Prot <= (OTHERS => '0');
                        ELSE        -- IBL unlock
                            IBL_Sec_Prot <= (OTHERS => '1');
                        END IF;
                    END IF;
                    IF rising_edge(HW_RST_out) THEN
                        SR1_V     <= SR1_NV;
                        SR2_V     <= (OTHERS => '0');
                        CR1_V     <= CR1_NV;
                        CR2_V(7 DOWNTO 1)<= CR2_NV(7 DOWNTO 1);
                        ADS       <= CR2_NV(1);
                        CR3_V     <= CR3_NV;
                        DLRV      := DLRNV;
                        IF IRP(4) = '1' THEN -- IBL lock
                            IBL_Sec_Prot <= (OTHERS => '0');
                        ELSE        -- IBL unlock
                            IBL_Sec_Prot <= (OTHERS => '1');
                        END IF;
                        IF IRP(2) = '0' THEN   -- Password protection mode
                            PR(0) := '0';
                            PR(6) := IRP(6);
                        ELSIF IRP(1) = '0' THEN-- Power Suply Lock-Down
                            PR(0) := '1';
                            PR(6) := IRP(6);
                        ELSIF IRP(0) = '0' THEN-- Permanent protection
                            PR(0) := '0';
                            PR(6) := '1';
                        END IF;
                    END IF;

                WHEN DPD =>
                    IF falling_edge(CSNeg_ipd) THEN
                        Instruct <= NONE;
                        opcode_cnt := 0;
                    END IF;
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := IO3RESETNegIn;
                                opcode(6-opcode_cnt) := WPNegIn;
                                opcode(5-opcode_cnt) := SOIn;
                                opcode(4-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 4;
                        ELSE
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 1;
                        END IF;
                        IF opcode_cnt = 8 THEN
                            IF opcode = "10101011" THEN -- ABh (RES)
                                Instruct <= RES;
                            END IF;
                        ELSIF opcode_cnt > 8 THEN
                            dummy_cnt := dummy_cnt + 1;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) THEN
                        IF opcode_cnt = 8 THEN
                            IF Instruct = RES THEN
                                RES_in <= '1';
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(RES_out) THEN
                        RES_in <= '0';
                    END IF;

                WHEN RD_ADDR | FAST_RD_ADDR | DUALO_RD_ADDR | QUADO_RD_ADDR =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF (Instruct = READ OR Instruct = FAST_READ
                        OR Instruct = DOR OR Instruct = QOR) AND ADS = '0' THEN
                            Address_in(addr_cnt) := SIIn;
                            addr_cnt := addr_cnt + 1;
                            IF addr_cnt = 24 THEN
                                any_read <= TRUE, FALSE AFTER 1 ns;
                                FOR I IN 23 DOWNTO 0 LOOP
                                    addr_bytes(23-i) := Address_in(i);
                                END LOOP;
                                addr_bytes(31 DOWNTO 24) := "00000000";
                                Address := to_nat(addr_bytes);
                            END IF;
                        ELSIF Instruct = READ4 OR Instruct = FAST_READ4 OR
                        Instruct = DOR4 OR Instruct = QOR4 OR
                        ((Instruct = READ OR Instruct = FAST_READ OR
                        Instruct = DOR OR Instruct = QOR) AND ADS = '1') THEN
                            Address_in(addr_cnt) := SIIn;
                            addr_cnt := addr_cnt + 1;
                            IF addr_cnt = 32 THEN
                                FOR I IN 31 DOWNTO 0 LOOP
                                    addr_bytes(31-i) := Address_in(i);
                                END LOOP;
                                addr_bytes(31 DOWNTO 24) := "00000000";
                                Address := to_nat(addr_bytes);
                            END IF;
                        END IF;
                    END IF;

                WHEN RD_DATA =>
                    IF falling_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        normal_rd <= true;
                        IF NOT (PS = '1' AND pgm_page = Address/(PageSize+1)) AND
                        NOT (ES = '1' AND SECT_ERS_ACT = '1' AND SectorErase = Address/(SecSize+1)) AND
                        NOT (ES = '1' AND HALF_BLOCK_ERS_ACT = '1' AND
                        HalfBlockErase = Address/(HalfBlockSize+1)) AND
                        NOT (ES = '1' AND BLOCK_ERS_ACT = '1' AND BlockErase = Address/(BlockSize+1)) AND
                        (Mem(Address) /= -1) THEN
                            data_out := to_slv(Mem(Address),8);
                            SOut_zd <= data_out(7-read_cnt);
                        ELSE
                            SOut_zd <= 'X';
                        END IF;
                        read_cnt := read_cnt + 1;
                        IF read_cnt = 8 THEN
                            read_cnt := 0;
                            IF Address = AddrRANGE THEN
                                Address := 0;
                            ELSE
                                Address := Address + 1;
                            END IF;
                        END IF;
                    END IF;

                WHEN FAST_RD_DUMMY =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        dummy_cnt := dummy_cnt + 1;
                        CLK_PER   := NOW - LAST_CLK;
                        LAST_CLK  := NOW;
                        IF dummy_cnt = Latency_code THEN
                            any_read <= TRUE, FALSE AFTER 1 ns;
                            IF (CLK_PER < 20 ns AND Latency_code = 1) OR -- > 50MHz
                            (CLK_PER < 15.38 ns AND Latency_code = 2) OR -- > 65MHz
                            (CLK_PER < 13.33 ns AND Latency_code = 3) OR -- > 75MHz
                            (CLK_PER < 11.76 ns AND Latency_code = 4) OR -- > 85MHz
                            (CLK_PER < 10.52 ns AND Latency_code = 5) OR -- > 95MHz
                            (CLK_PER <  9.25 ns AND Latency_code <= 8) THEN  -- > 108MHz
                                ASSERT FALSE
                                REPORT "More wait states are required for " &
                                    "this clock frequency value"
                                SEVERITY WARNING;
                            END IF;
                        END IF;
                    END IF;

                WHEN FAST_RD_DATA =>
                    IF falling_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        fast_rd <= true;
                        IF NOT (PS = '1' AND pgm_page = Address/(PageSize+1)) AND
                        NOT (ES = '1' AND SECT_ERS_ACT = '1' AND SectorErase = Address/(SecSize+1)) AND
                        NOT (ES = '1' AND HALF_BLOCK_ERS_ACT = '1' AND
                        HalfBlockErase = Address/(HalfBlockSize+1)) AND
                        NOT (ES = '1' AND BLOCK_ERS_ACT = '1' AND BlockErase = Address/(BlockSize+1)) AND
                        (Mem(Address) /= -1) THEN
                            data_out := to_slv(Mem(Address),8);
                            SOut_zd <= data_out(7-read_cnt);
                        ELSE
                            SOut_zd <= 'X';
                        END IF;
                        read_cnt := read_cnt + 1;
                        IF read_cnt = 8 THEN
                            read_cnt := 0;
                            IF Address = AddrRANGE THEN
                                Address := 0;
                            ELSE
                                Address := Address + 1;
                            END IF;
                        END IF;
                    END IF;

                WHEN DUALO_RD_DUMMY =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        dummy_cnt := dummy_cnt + 1;
                        CLK_PER   := NOW - LAST_CLK;
                        LAST_CLK  := NOW;
                        IF dummy_cnt = Latency_code THEN
                            any_read <= TRUE, FALSE AFTER 1 ns;
                            IF (CLK_PER < 20 ns AND Latency_code = 1) OR -- > 50MHz
                            (CLK_PER < 15.38 ns AND Latency_code = 2) OR -- > 65MHz
                            (CLK_PER < 13.33 ns AND Latency_code = 3) OR -- > 75MHz
                            (CLK_PER < 11.76 ns AND Latency_code = 4) OR -- > 85MHz
                            (CLK_PER < 10.52 ns AND Latency_code = 5) OR -- > 95MHz
                            (CLK_PER <  9.52 ns AND Latency_code = 6) OR -- > 105MHz
                            (CLK_PER <  9.25 ns AND Latency_code <= 8) THEN  -- > 108MHz
                                ASSERT FALSE
                                REPORT "More wait states are required for " &
                                    "this clock frequency value"
                                SEVERITY WARNING;
                            END IF;
                        END IF;
                    END IF;

                WHEN DUALO_RD_DATA | DUALIO_RD_DATA =>
                    IF falling_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        fast_rd <= true;
                        IF NOT (PS = '1' AND pgm_page = Address/(PageSize+1)) AND
                        NOT (ES = '1' AND SECT_ERS_ACT = '1' AND SectorErase = Address/(SecSize+1)) AND
                        NOT (ES = '1' AND HALF_BLOCK_ERS_ACT = '1' AND
                        HalfBlockErase = Address/(HalfBlockSize+1)) AND
                        NOT (ES = '1' AND BLOCK_ERS_ACT = '1' AND BlockErase = Address/(BlockSize+1)) AND
                        (Mem(Address) /= -1) THEN
                            data_out := to_slv(Mem(Address),8);
                            SOut_zd  <= data_out(7-read_cnt);
                            SIOut_zd <= data_out(6-read_cnt);
                        ELSE
                            SOut_zd  <= 'X';
                            SIOut_zd <= 'X';
                        END IF;
                        read_cnt := read_cnt + 2;
                        IF read_cnt = 8 THEN
                            read_cnt := 0;
                            IF Address = AddrRANGE THEN
                                Address := 0;
                            ELSE
                                Address := Address + 1;
                            END IF;
                        END IF;
                    END IF;

                WHEN QUADO_RD_DUMMY | QUADIO_RD_DUMMY =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        dummy_cnt := dummy_cnt + 1;
                        CLK_PER   := NOW - LAST_CLK;
                        LAST_CLK  := NOW;
                        IF dummy_cnt = Latency_code THEN
                            any_read <= TRUE, FALSE AFTER 1 ns;
                            IF (CLK_PER < 28.57 ns AND Latency_code = 1) OR -- > 35MHz
                            (CLK_PER < 22.22 ns AND Latency_code = 2) OR -- > 45MHz
                            (CLK_PER < 18.18 ns AND Latency_code = 3) OR -- > 55MHz
                            (CLK_PER < 15.38 ns AND Latency_code = 4) OR -- > 65MHz
                            (CLK_PER < 13.33 ns AND Latency_code = 5) OR -- > 75MHz
                            (CLK_PER < 11.76 ns AND Latency_code = 6) OR -- > 85MHz
                            (CLK_PER < 10.52 ns AND Latency_code = 7) OR -- > 95MHz
                            (CLK_PER < 9.25  ns AND Latency_code = 8) OR -- > 108MHz
                            (CLK_PER < 8.695 ns AND Latency_code <= 10) OR -- > 115MHz
                            (CLK_PER < 8.333 ns AND Latency_code <= 12) THEN  -- > 120MHz
                                ASSERT FALSE
                                REPORT "More wait states are required for " &
                                    "this clock frequency value"
                                SEVERITY WARNING;
                            END IF;
                        END IF;
                    END IF;

                WHEN QUADO_RD_DATA =>
                    IF falling_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        fast_rd <= true;
                        IF NOT (PS = '1' AND pgm_page = Address/(PageSize+1)) AND
                        NOT (ES = '1' AND SECT_ERS_ACT = '1' AND SectorErase = Address/(SecSize+1)) AND
                        NOT (ES = '1' AND HALF_BLOCK_ERS_ACT = '1' AND
                        HalfBlockErase = Address/(HalfBlockSize+1)) AND
                        NOT (ES = '1' AND BLOCK_ERS_ACT = '1' AND BlockErase = Address/(BlockSize+1)) AND
                        (Mem(Address) /= -1) THEN
                            data_out := to_slv(Mem(Address),8);
                            IO3RESETNegOut_zd <= data_out(7-read_cnt);
                            WPNegOut_zd    <= data_out(6-read_cnt);
                            SOut_zd        <= data_out(5-read_cnt);
                            SIOut_zd       <= data_out(4-read_cnt);
                        ELSE
                            IO3RESETNegOut_zd <= 'X';
                            WPNegOut_zd    <= 'X';
                            SOut_zd        <= 'X';
                            SIOut_zd       <= 'X';
                        END IF;
                        read_cnt := read_cnt + 4;
                        IF read_cnt = 8 THEN
                            read_cnt := 0;
                            IF Address = AddrRANGE THEN
                                Address := 0;
                            ELSE
                                Address := Address + 1;
                            END IF;
                        END IF;
                    END IF;

                WHEN DUALIO_RD_ADDR =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF Instruct = DIOR AND ADS = '0' THEN
                            Address_in(2*addr_cnt)   := SOIn;
                            Address_in(2*addr_cnt+1) := SIIn;
                            addr_cnt := addr_cnt + 1;
                            IF addr_cnt = 12 THEN
                                any_read <= TRUE, FALSE AFTER 1 ns;
                                FOR I IN 23 DOWNTO 0 LOOP
                                    addr_bytes(23-i) := Address_in(i);
                                END LOOP;
                                addr_bytes(31 DOWNTO 24) := "00000000";
                                Address := to_nat(addr_bytes);
                            END IF;
                        ELSIF Instruct = DIOR4 OR (Instruct = DIOR AND ADS = '1') THEN
                            Address_in(2*addr_cnt)   := SOIn;
                            Address_in(2*addr_cnt+1) := SIIn;
                            addr_cnt := addr_cnt + 1;
                            IF addr_cnt = 16 THEN
                                FOR I IN 31 DOWNTO 0 LOOP
                                    addr_bytes(31-i) := Address_in(i);
                                END LOOP;
                                addr_bytes(31 DOWNTO 24) := "00000000";
                                Address := to_nat(addr_bytes);
                            END IF;
                        END IF;
                        IF mode_byte(7 DOWNTO 4) = "1010" THEN
                            IF opcode_cnt < 8 THEN
                                -- latching data for MBR instruct
                                Instruct_tmp(7-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 1;
                        END IF;
                    END IF;
                    -- Continuous read
                    IF falling_edge(CSNeg_ipd) AND mode_byte(7 DOWNTO 4) = "1010" THEN
                        opcode_cnt := 0;
                        addr_cnt   := 0;
                        dummy_cnt  := 0;
                        mode_cnt   := 0;
                        mode_byte  := (OTHERS => '0');
                        read_cnt   := 0;
                    END IF;

                WHEN DUALIO_RD_MODE =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        mode_in(2*mode_cnt)   := SOIn;
                        mode_in(2*mode_cnt+1) := SIIn;
                        mode_cnt := mode_cnt + 1;
                        IF mode_cnt = 4 THEN
                            any_read <= TRUE, FALSE AFTER 1 ns;
                            FOR I IN 7 DOWNTO 0 LOOP
                                mode_byte(i) := mode_in(7-i);
                            END LOOP;
                        END IF;
                    END IF;

                WHEN DUALIO_RD_DUMMY =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                       dummy_cnt := dummy_cnt + 1;
                        CLK_PER   := NOW - LAST_CLK;
                        LAST_CLK  := NOW;
                        IF dummy_cnt = Latency_code THEN
                            any_read <= TRUE, FALSE AFTER 1 ns;
                            IF (CLK_PER < 13.33 ns AND Latency_code = 1) OR -- > 75MHz
                            (CLK_PER < 11.76 ns AND Latency_code = 2) OR -- > 85MHz
                            (CLK_PER < 10.52 ns AND Latency_code = 3) OR -- > 95MHz
                            (CLK_PER < 9.25 ns AND Latency_code <= 6) THEN -- > 108MHz
                                ASSERT FALSE
                                REPORT "More wait states are required for " &
                                    "this clock frequency value"
                                SEVERITY WARNING;
                            END IF;
                        END IF;
                    END IF;

                WHEN QUADIO_RD_ADDR =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF Instruct = QIOR AND ADS = '0' THEN
                            Address_in(4*addr_cnt)   := IO3RESETNegIn;
                            Address_in(4*addr_cnt+1) := WPNegIn;
                            Address_in(4*addr_cnt+2) := SOIn;
                            Address_in(4*addr_cnt+3) := SIIn;
                            addr_cnt := addr_cnt + 1;
                            IF addr_cnt = 6 THEN
                                FOR I IN 23 DOWNTO 0 LOOP
                                    addr_bytes(23-i) := Address_in(i);
                                END LOOP;
                                addr_bytes(31 DOWNTO 24) := "00000000";
                                Address := to_nat(addr_bytes);
                            END IF;
                        ELSIF Instruct = QIOR4 OR (Instruct = QIOR AND ADS = '1') THEN
                            Address_in(4*addr_cnt)   := IO3RESETNegIn;
                            Address_in(4*addr_cnt+1) := WPNegIn;
                            Address_in(4*addr_cnt+2) := SOIn;
                            Address_in(4*addr_cnt+3) := SIIn;
                            addr_cnt := addr_cnt + 1;
                            IF addr_cnt = 8 THEN
                                FOR I IN 31 DOWNTO 0 LOOP
                                    addr_bytes(31-i) := Address_in(i);
                                END LOOP;
                                addr_bytes(31 DOWNTO 24) := "00000000";
                                Address := to_nat(addr_bytes);
                            END IF;
                        END IF;
                        IF mode_byte(7 DOWNTO 4) = "1010" THEN
                            IF opcode_cnt < 8 THEN
                                -- latching data for MBR instruct
                                Instruct_tmp(7-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 1;
                        END IF;
                    END IF;
                    -- Continuous read
                    IF falling_edge(CSNeg_ipd) AND mode_byte(7 DOWNTO 4) = "1010" THEN
                        opcode_cnt := 0;
                        addr_cnt   := 0;
                        dummy_cnt  := 0;
                        mode_cnt   := 0;
                        mode_byte  := (OTHERS => '0');
                        read_cnt   := 0;
                    END IF;

                WHEN QUADIO_RD_MODE =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        mode_in(4*mode_cnt)  := IO3RESETNegIn;
                        mode_in(4*mode_cnt+1):= WPNegIn;
                        mode_in(4*mode_cnt+2):= SOIn;
                        mode_in(4*mode_cnt+3):= SIIn;
                        mode_cnt := mode_cnt + 1;
                        IF mode_cnt = 2 THEN
                            any_read <= TRUE, FALSE AFTER 1 ns;
                            FOR I IN 7 DOWNTO 0 LOOP
                                mode_byte(i) := mode_in(7-i);
                            END LOOP;
                        END IF;
                    END IF;

                WHEN QUADIO_RD_DATA =>
                    IF falling_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        fast_rd <= true;
                        IF NOT (PS = '1' AND pgm_page = Address/(PageSize+1)) AND
                        NOT (ES = '1' AND SECT_ERS_ACT = '1' AND SectorErase = Address/(SecSize+1)) AND
                        NOT (ES = '1' AND HALF_BLOCK_ERS_ACT = '1' AND
                        HalfBlockErase = Address/(HalfBlockSize+1)) AND
                        NOT (ES = '1' AND BLOCK_ERS_ACT = '1' AND BlockErase = Address/(BlockSize+1)) AND
                        (Mem(Address) /= -1) THEN
                            data_out := to_slv(Mem(Address),8);
                            IO3RESETNegOut_zd <= data_out(7-read_cnt);
                            WPNegOut_zd    <= data_out(6-read_cnt);
                            SOut_zd        <= data_out(5-read_cnt);
                            SIOut_zd       <= data_out(4-read_cnt);
                        ELSE
                            IO3RESETNegOut_zd <= 'X';
                            WPNegOut_zd    <= 'X';
                            SOut_zd        <= 'X';
                            SIOut_zd       <= 'X';
                        END IF;
                        read_cnt := read_cnt + 4;
                        IF read_cnt = 8 THEN
                            read_cnt := 0;
                            IF CR3_V(4) = '1' THEN -- disable burst wrap read
                                IF Address = AddrRANGE THEN
                                    Address := 0;
                                ELSE
                                    Address := Address + 1;
                                END IF;
                            ELSIF CR3_V(4) = '0' THEN -- enable burst wrap read
                                Address := Address + 1;
                                IF Address mod WrapLength = 0 THEN
                                    Address := Address - WrapLength;
                                END IF;
                            END IF;
                        END IF;
                    END IF;

                WHEN DDRQUADIO_RD_ADDR =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF Instruct = DDRQIOR AND ADS = '0' THEN
                            Address_in(23-addr_cnt) := IO3RESETNegIn;
                            Address_in(22-addr_cnt) := WPNegIn;
                            Address_in(21-addr_cnt) := SOIn;
                            Address_in(20-addr_cnt) := SIIn;
                        ELSIF Instruct = DDRQIOR4 OR (Instruct = DDRQIOR AND ADS = '1') THEN
                            Address_in(31-addr_cnt) := IO3RESETNegIn;
                            Address_in(30-addr_cnt) := WPNegIn;
                            Address_in(29-addr_cnt) := SOIn;
                            Address_in(28-addr_cnt) := SIIn;
                        END IF;
                        IF mode_byte(7 DOWNTO 4) = NOT (mode_byte(3 DOWNTO 0)) THEN
                            IF opcode_cnt < 8 THEN
                                -- latching data for MBR instruct
                                Instruct_tmp(7-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 1;
                        END IF;
                        frst_addr_nibb <= true;
                    END IF;
                    IF falling_edge(SCK_ipd) AND CSNeg_ipd = '0' AND frst_addr_nibb THEN
                        IF Instruct = DDRQIOR AND ADS = '0' THEN
                            Address_in(19-addr_cnt) := IO3RESETNegIn;
                            Address_in(18-addr_cnt) := WPNegIn;
                            Address_in(17-addr_cnt) := SOIn;
                            Address_in(16-addr_cnt) := SIIn;
                            addr_cnt := addr_cnt + 8;
                            IF addr_cnt = 24 THEN
                                Address := to_nat(Address_in);
                            END IF;
                        ELSIF Instruct = DDRQIOR4 OR (Instruct = DDRQIOR AND ADS = '1') THEN
                            Address_in(27-addr_cnt) := IO3RESETNegIn;
                            Address_in(26-addr_cnt) := WPNegIn;
                            Address_in(25-addr_cnt) := SOIn;
                            Address_in(24-addr_cnt) := SIIn;
                            addr_cnt := addr_cnt + 8;
                            IF addr_cnt = 32 THEN
                                Address := to_nat(Address_in);
                            END IF;
                        END IF;
                    END IF;
                    IF falling_edge(CSNeg_ipd) THEN
                        opcode_cnt := 0;
                        addr_cnt   := 0;
                        dummy_cnt  := 0;
                        mode_cnt   := 0;
                        mode_byte  := (OTHERS => '0');
                        read_cnt   := 0;
                        frst_addr_nibb <= false;
                    END IF;

                WHEN DDRQUADIO_RD_MODE =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        mode_byte(7) := IO3RESETNegIn;
                        mode_byte(6) := WPNegIn;
                        mode_byte(5) := SOIn;
                        mode_byte(4) := SIIn;
                    END IF;
                    IF falling_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        mode_byte(3) := IO3RESETNegIn;
                        mode_byte(2) := WPNegIn;
                        mode_byte(1) := SOIn;
                        mode_byte(0) := SIIn;
                        mode_cnt := mode_cnt + 8;
                        any_read <= TRUE, FALSE AFTER 1 ns;
                        IF (2*Latency_code - dummy_cnt = 8) AND DLRV /= "00000000" THEN
                            dlp_act := TRUE;
                        END IF;
                        IF dlp_act THEN
                            IO3RESETNegOut_zd <= DLRV(7-read_cnt);
                            WPNegOut_zd <= DLRV(7-read_cnt);
                            SOut_zd     <= DLRV(7-read_cnt);
                            SIOut_zd    <= DLRV(7-read_cnt);
                            read_cnt := read_cnt + 1;
                        END IF;
                        dummy_cnt := dummy_cnt + 1;
                    END IF;

                WHEN DDRQUADIO_RD_DUMMY =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF dlp_act THEN
                            IO3RESETNegOut_zd <= DLRV(7-read_cnt);
                            WPNegOut_zd <= DLRV(7-read_cnt);
                            SOut_zd     <= DLRV(7-read_cnt);
                            SIOut_zd    <= DLRV(7-read_cnt);
                            read_cnt := read_cnt + 1;
                            IF read_cnt = 8 THEN
                                read_cnt := 0;
                                dlp_act  := FALSE;
                            END IF;
                        END IF;
                        dummy_cnt := dummy_cnt + 1;
                        CLK_PER   := NOW - LAST_CLK;
                        LAST_CLK  := NOW;
                        IF dummy_cnt = 2*Latency_code THEN
                            any_read <= TRUE, FALSE AFTER 1 ns;
                            IF (CLK_PER < 50 ns AND Latency_code = 1) OR -- > 20MHz
                            (CLK_PER < 40 ns AND Latency_code = 2) OR -- > 25MHz
                            (CLK_PER < 28.57 ns AND Latency_code = 3) OR -- > 35MHz
                            (CLK_PER < 22.22 ns AND Latency_code = 4) OR -- > 45MHz
                            (CLK_PER < 18.18 ns AND Latency_code = 5) OR -- > 55MHz
                            (CLK_PER < 16.66 ns AND Latency_code <= 6) THEN -- > 60MHz
                                ASSERT FALSE
                                REPORT "More wait states are required for " &
                                    "this clock frequency value"
                                SEVERITY WARNING;
                            END IF;
                        END IF;
                    END IF;
                    IF falling_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF (2*Latency_code - dummy_cnt = 8) AND DLRV /= "00000000" THEN
                            dlp_act := TRUE;
                        END IF;
                        IF dlp_act THEN
                            IO3RESETNegOut_zd <= DLRV(7-read_cnt);
                            WPNegOut_zd <= DLRV(7-read_cnt);
                            SOut_zd     <= DLRV(7-read_cnt);
                            SIOut_zd    <= DLRV(7-read_cnt);
                            read_cnt := read_cnt + 1;
                        END IF;
                        dummy_cnt := dummy_cnt + 1;
                    END IF;

                WHEN DDRQUADIO_RD_DATA =>
                    IF falling_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        ddr_rd <= true;
                        IF NOT (PS = '1' AND pgm_page = Address/(PageSize+1)) AND
                        NOT (ES = '1' AND SECT_ERS_ACT = '1' AND SectorErase = Address/(SecSize+1)) AND
                        NOT (ES = '1' AND HALF_BLOCK_ERS_ACT = '1' AND
                        HalfBlockErase = Address/(HalfBlockSize+1)) AND
                        NOT (ES = '1' AND BLOCK_ERS_ACT = '1' AND BlockErase = Address/(BlockSize+1)) AND
                        (Mem(Address) /= -1) THEN
                            data_out := to_slv(Mem(Address),8);
                            IO3RESETNegOut_zd <= data_out(7-read_cnt);
                            WPNegOut_zd    <= data_out(6-read_cnt);
                            SOut_zd        <= data_out(5-read_cnt);
                            SIOut_zd       <= data_out(4-read_cnt);
                        ELSE
                            IO3RESETNegOut_zd <= 'X';
                            WPNegOut_zd    <= 'X';
                            SOut_zd        <= 'X';
                            SIOut_zd       <= 'X';
                        END IF;
                        read_cnt := read_cnt + 4;
                    END IF;
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IO3RESETNegOut_zd <= data_out(7-read_cnt);
                        WPNegOut_zd    <= data_out(6-read_cnt);
                        SOut_zd        <= data_out(5-read_cnt);
                        SIOut_zd       <= data_out(4-read_cnt);
                        read_cnt := read_cnt + 4;
                        IF read_cnt = 8 THEN
                            read_cnt := 0;
                            IF CR3_V(4) = '1' THEN -- disable burst wrap read
                                IF Address = AddrRANGE THEN
                                    Address := 0;
                                ELSE
                                    Address := Address + 1;
                                END IF;
                            ELSIF CR3_V(4) = '0' THEN -- enable burst wrap read
                                Address := Address + 1;
                                IF Address mod WrapLength = 0 THEN
                                    Address := Address - WrapLength;
                                END IF;
                            END IF;
                        END IF;
                    END IF;

                WHEN RDAR_ADDR =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF ADS = '0' THEN
                                Address_in(4*addr_cnt)   := IO3RESETNegIn;
                                Address_in(4*addr_cnt+1) := WPNegIn;
                                Address_in(4*addr_cnt+2) := SOIn;
                                Address_in(4*addr_cnt+3) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 6 THEN
                                    FOR I IN 23 DOWNTO 0 LOOP
                                        addr_bytes(23-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            ELSIF ADS = '1' THEN
                                Address_in(4*addr_cnt)   := IO3RESETNegIn;
                                Address_in(4*addr_cnt+1) := WPNegIn;
                                Address_in(4*addr_cnt+2) := SOIn;
                                Address_in(4*addr_cnt+3) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 8 THEN
                                    FOR I IN 31 DOWNTO 0 LOOP
                                        addr_bytes(31-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            END IF;
                        ELSE
                            IF ADS = '0' THEN
                                Address_in(addr_cnt) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 24 THEN
                                    FOR I IN 23 DOWNTO 0 LOOP
                                        addr_bytes(23-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            ELSIF ADS = '1' THEN
                                Address_in(addr_cnt) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 32 THEN
                                    FOR I IN 31 DOWNTO 0 LOOP
                                        addr_bytes(31-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                    -- embedded operation finished during Read Any Register operation
                    IF rising_edge(PDONE) THEN
                        IF PGM_ACT = '1' THEN
                            EndProgramming;
                        ELSIF PGM_SEC_REG_ACT = '1' THEN
                            EndSECRProgramming;
                        ELSIF IRP_ACT = '1' THEN
                            EndIRPP;
                        ELSIF DLRNV_ACT = '1' THEN
                            WIP <= '0';
                            WEL <= '0';
                            DLRNV := DLRNV_in;
                            DLRV  := DLRNV;
                            DLRNV_ACT <= '0';
                            DLRNV_programmed <= '1';
                        ELSIF PASS_PGM_ACT = '1' THEN
                            EndPassProgramming;
                        END IF;
                    END IF;
                    IF rising_edge(EDONE) THEN
                        IF SECT_ERS_ACT = '1' THEN
                            EndSecErasing;
                        ELSIF HALF_BLOCK_ERS_ACT = '1' THEN
                            EndHalfBlockErasing;
                        ELSIF BLOCK_ERS_ACT = '1' THEN
                            EndBlockErasing;
                        ELSIF CHIP_ERS_ACT = '1' THEN
                            EndChipErasing;
                        ELSIF SECT_ERS_SEC_REG_ACT = '1' THEN
                            EndSECRErasing;
                        END IF;
                    END IF;
                    IF rising_edge(WDONE) THEN
                        IF WRR_NV_ACT = '1' THEN
                            EndWRR_NV;
                        ELSIF WRAR_NV_ACT = '1' THEN
                            EndWRAR_NV;
                        ELSIF SET_PNTR_PROT_ACT = '1' THEN
                            EndSPRP;
                        END IF;
                    END IF;

                WHEN RDAR_DUMMY =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        dummy_cnt := dummy_cnt + 1;
                        CLK_PER   := NOW - LAST_CLK;
                        LAST_CLK  := NOW;
                        IF dummy_cnt = Latency_code THEN
                            any_read <= TRUE, FALSE AFTER 1 ns;
                            IF QPI = '1' THEN
                                IF (CLK_PER < 66.6 ns AND Latency_code = 1) OR -- > 15MHz
                                (CLK_PER < 40 ns AND Latency_code = 2) OR -- > 25MHz
                                (CLK_PER < 28.57 ns AND Latency_code = 3) OR -- > 35MHz
                                (CLK_PER < 22.22 ns AND Latency_code = 4) OR -- > 45MHz
                                (CLK_PER < 18.18 ns AND Latency_code = 5) OR -- > 55MHz
                                (CLK_PER < 15.38 ns AND Latency_code = 6) OR -- > 65MHz
                                (CLK_PER < 13.33 ns AND Latency_code = 7) OR -- > 75MHz
                                (CLK_PER < 11.76 ns AND Latency_code = 8) OR -- > 85MHz
                                (CLK_PER < 10.52 ns AND Latency_code = 9) OR -- > 95MHz
                                (CLK_PER < 9.25 ns  AND Latency_code = 10) OR -- > 108MHz
                                (CLK_PER < 8.695 ns AND Latency_code <= 12) OR -- > 115MHz
                                (CLK_PER < 8.333 ns AND Latency_code <= 14) THEN  -- > 120MHz
                                    ASSERT FALSE
                                    REPORT "More wait states are required for " &
                                        "this clock frequency value"
                                    SEVERITY WARNING;
                                END IF;
                            ELSE
                                IF (CLK_PER < 20 ns AND Latency_code = 1) OR -- > 50MHz
                                (CLK_PER < 15.38 ns AND Latency_code = 2) OR -- > 65MHz
                                (CLK_PER < 13.33 ns AND Latency_code = 3) OR -- > 75MHz
                                (CLK_PER < 11.76 ns AND Latency_code = 4) OR -- > 85MHz
                                (CLK_PER < 10.52 ns AND Latency_code = 5) OR -- > 95MHz
                                (CLK_PER <  9.25 ns AND Latency_code <= 8) THEN  -- > 108MHz
                                    ASSERT FALSE
                                    REPORT "More wait states are required for " &
                                        "this clock frequency value"
                                    SEVERITY WARNING;
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                    -- embedded operation finished during status read
                    IF rising_edge(PDONE) THEN
                        IF PGM_ACT = '1' THEN
                            EndProgramming;
                        ELSIF PGM_SEC_REG_ACT = '1' THEN
                            EndSECRProgramming;
                        ELSIF IRP_ACT = '1' THEN
                            EndIRPP;
                        ELSIF DLRNV_ACT = '1' THEN
                            WIP <= '0';
                            WEL <= '0';
                            DLRNV := DLRNV_in;
                            DLRV  := DLRNV;
                            DLRNV_ACT <= '0';
                            DLRNV_programmed <= '1';
                        ELSIF PASS_PGM_ACT = '1' THEN
                            EndPassProgramming;
                        END IF;
                    END IF;
                    IF rising_edge(EDONE) THEN
                        IF SECT_ERS_ACT = '1' THEN
                            EndSecErasing;
                        ELSIF HALF_BLOCK_ERS_ACT = '1' THEN
                            EndHalfBlockErasing;
                        ELSIF BLOCK_ERS_ACT = '1' THEN
                            EndBlockErasing;
                        ELSIF CHIP_ERS_ACT = '1' THEN
                            EndChipErasing;
                        ELSIF SECT_ERS_SEC_REG_ACT = '1' THEN
                            EndSECRErasing;
                        END IF;
                    END IF;
                    IF rising_edge(WDONE) THEN
                        IF WRR_NV_ACT = '1' THEN
                            EndWRR_NV;
                        ELSIF WRAR_NV_ACT = '1' THEN
                            EndWRAR_NV;
                        ELSIF SET_PNTR_PROT_ACT = '1' THEN
                            EndSPRP;
                        END IF;
                    END IF;

                WHEN RDAR_DATA_OUTPUT =>
                    IF falling_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        fast_rd <= true;
                        READ_ALL_REG(RDAR_reg, Address);-- Address
                        data_out := RDAR_reg;
                        IF QPI = '1' THEN
                            IO3RESETNegOut_zd <= data_out(7-read_cnt);
                            WPNegOut_zd    <= data_out(6-read_cnt);
                            SOut_zd        <= data_out(5-read_cnt);
                            SIOut_zd       <= data_out(4-read_cnt);
                            read_cnt := read_cnt + 4;
                            IF read_cnt = 8 THEN
                                read_cnt := 0;
                            END IF;
                        ELSE
                            SOut_zd <= data_out(7-read_cnt);
                            read_cnt := read_cnt + 1;
                            IF read_cnt = 8 THEN
                                read_cnt := 0;
                            END IF;
                        END IF;
                    END IF;
                    -- embedded operation finished during status read
                    IF rising_edge(PDONE) THEN
                        IF PGM_ACT = '1' THEN
                            EndProgramming;
                        ELSIF PGM_SEC_REG_ACT = '1' THEN
                            EndSECRProgramming;
                        ELSIF IRP_ACT = '1' THEN
                            EndIRPP;
                        ELSIF DLRNV_ACT = '1' THEN
                            WIP <= '0';
                            WEL <= '0';
                            DLRNV := DLRNV_in;
                            DLRV  := DLRNV;
                            DLRNV_ACT <= '0';
                            DLRNV_programmed <= '1';
                        ELSIF PASS_PGM_ACT = '1' THEN
                            EndPassProgramming;
                        END IF;
                    END IF;
                    IF rising_edge(EDONE) THEN
                        IF SECT_ERS_ACT = '1' THEN
                            EndSecErasing;
                        ELSIF HALF_BLOCK_ERS_ACT = '1' THEN
                            EndHalfBlockErasing;
                        ELSIF BLOCK_ERS_ACT = '1' THEN
                            EndBlockErasing;
                        ELSIF CHIP_ERS_ACT = '1' THEN
                            EndChipErasing;
                        ELSIF SECT_ERS_SEC_REG_ACT = '1' THEN
                            EndSECRErasing;
                        END IF;
                    END IF;
                    IF rising_edge(WDONE) THEN
                        IF WRR_NV_ACT = '1' THEN
                            EndWRR_NV;
                        ELSIF WRAR_NV_ACT = '1' THEN
                            EndWRAR_NV;
                        ELSIF SET_PNTR_PROT_ACT = '1' THEN
                            EndSPRP;
                        END IF;
                    END IF;

                WHEN RDSR1_DATA_OUTPUT =>
                    IF falling_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        reg_rd <= true;
                        data_out := SR1_V;
                        IF QPI = '1' THEN
                            IO3RESETNegOut_zd <= data_out(7-read_cnt);
                            WPNegOut_zd    <= data_out(6-read_cnt);
                            SOut_zd        <= data_out(5-read_cnt);
                            SIOut_zd       <= data_out(4-read_cnt);
                            read_cnt := read_cnt + 4;
                            IF read_cnt = 8 THEN
                                read_cnt := 0;
                            END IF;
                        ELSE
                            SOut_zd <= data_out(7-read_cnt);
                            read_cnt := read_cnt + 1;
                            IF read_cnt = 8 THEN
                                read_cnt := 0;
                            END IF;
                        END IF;
                    END IF;
                    -- embedded operation finished during status read
                    IF rising_edge(PDONE) THEN
                        IF PGM_ACT = '1' THEN
                            EndProgramming;
                        ELSIF PGM_SEC_REG_ACT = '1' THEN
                            EndSECRProgramming;
                        ELSIF IRP_ACT = '1' THEN
                            EndIRPP;
                        ELSIF DLRNV_ACT = '1' THEN
                            WIP <= '0';
                            WEL <= '0';
                            DLRNV := DLRNV_in;
                            DLRV  := DLRNV;
                            DLRNV_ACT <= '0';
                            DLRNV_programmed <= '1';
                        ELSIF PASS_PGM_ACT = '1' THEN
                            EndPassProgramming;
                        END IF;
                    END IF;
                    IF rising_edge(EDONE) THEN
                        IF SECT_ERS_ACT = '1' THEN
                            EndSecErasing;
                        ELSIF HALF_BLOCK_ERS_ACT = '1' THEN
                            EndHalfBlockErasing;
                        ELSIF BLOCK_ERS_ACT = '1' THEN
                            EndBlockErasing;
                        ELSIF CHIP_ERS_ACT = '1' THEN
                            EndChipErasing;
                        ELSIF SECT_ERS_SEC_REG_ACT = '1' THEN
                            EndSECRErasing;
                        END IF;
                    END IF;
                    IF rising_edge(WDONE) THEN
                        IF WRR_NV_ACT = '1' THEN
                            EndWRR_NV;
                        ELSIF WRAR_NV_ACT = '1' THEN
                            EndWRAR_NV;
                        ELSIF SET_PNTR_PROT_ACT = '1' THEN
                            EndSPRP;
                        END IF;
                    END IF;

                WHEN RDSR2_DATA_OUTPUT =>
                    IF falling_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        reg_rd   <= true;
                        data_out := SR2_V;
                        SOut_zd  <= data_out(7-read_cnt);
                        read_cnt := read_cnt + 1;
                        IF read_cnt = 8 THEN
                            read_cnt := 0;
                        END IF;
                    END IF;
                    -- embedded operation finished during status read
                    IF rising_edge(PDONE) THEN
                        IF PGM_ACT = '1' THEN
                            EndProgramming;
                        ELSIF PGM_SEC_REG_ACT = '1' THEN
                            EndSECRProgramming;
                        ELSIF IRP_ACT = '1' THEN
                            EndIRPP;
                        ELSIF DLRNV_ACT = '1' THEN
                            WIP <= '0';
                            WEL <= '0';
                            DLRNV := DLRNV_in;
                            DLRV  := DLRNV;
                            DLRNV_ACT <= '0';
                            DLRNV_programmed <= '1';
                        ELSIF PASS_PGM_ACT = '1' THEN
                            EndPassProgramming;
                        END IF;
                    END IF;
                    IF rising_edge(EDONE) THEN
                        IF SECT_ERS_ACT = '1' THEN
                            EndSecErasing;
                        ELSIF HALF_BLOCK_ERS_ACT = '1' THEN
                            EndHalfBlockErasing;
                        ELSIF BLOCK_ERS_ACT = '1' THEN
                            EndBlockErasing;
                        ELSIF CHIP_ERS_ACT = '1' THEN
                            EndChipErasing;
                        ELSIF SECT_ERS_SEC_REG_ACT = '1' THEN
                            EndSECRErasing;
                        END IF;
                    END IF;
                    IF rising_edge(WDONE) THEN
                        IF WRR_NV_ACT = '1' THEN
                            EndWRR_NV;
                        ELSIF WRAR_NV_ACT = '1' THEN
                            EndWRAR_NV;
                        ELSIF SET_PNTR_PROT_ACT = '1' THEN
                            EndSPRP;
                        END IF;
                    END IF;

                WHEN RDCR1_DATA_OUTPUT =>
                    IF falling_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        reg_rd   <= true;
                        data_out := CR1_V;
                        SOut_zd  <= data_out(7-read_cnt);
                        read_cnt := read_cnt + 1;
                        IF read_cnt = 8 THEN
                            read_cnt := 0;
                        END IF;
                    END IF;
                    -- embedded operation finished during status read
                    IF rising_edge(PDONE) THEN
                        IF PGM_ACT = '1' THEN
                            EndProgramming;
                        ELSIF PGM_SEC_REG_ACT = '1' THEN
                            EndSECRProgramming;
                        ELSIF IRP_ACT = '1' THEN
                            EndIRPP;
                        ELSIF DLRNV_ACT = '1' THEN
                            WIP <= '0';
                            WEL <= '0';
                            DLRNV := DLRNV_in;
                            DLRV  := DLRNV;
                            DLRNV_ACT <= '0';
                            DLRNV_programmed <= '1';
                        ELSIF PASS_PGM_ACT = '1' THEN
                            EndPassProgramming;
                        END IF;
                    END IF;
                    IF rising_edge(EDONE) THEN
                        IF SECT_ERS_ACT = '1' THEN
                            EndSecErasing;
                        ELSIF HALF_BLOCK_ERS_ACT = '1' THEN
                            EndHalfBlockErasing;
                        ELSIF BLOCK_ERS_ACT = '1' THEN
                            EndBlockErasing;
                        ELSIF CHIP_ERS_ACT = '1' THEN
                            EndChipErasing;
                        ELSIF SECT_ERS_SEC_REG_ACT = '1' THEN
                            EndSECRErasing;
                        END IF;
                    END IF;
                    IF rising_edge(WDONE) THEN
                        IF WRR_NV_ACT = '1' THEN
                            EndWRR_NV;
                        ELSIF WRAR_NV_ACT = '1' THEN
                            EndWRAR_NV;
                        ELSIF SET_PNTR_PROT_ACT = '1' THEN
                            EndSPRP;
                        END IF;
                    END IF;

                WHEN RDCR2_DATA_OUTPUT =>
                    IF falling_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        reg_rd   <= true;
                        data_out := CR2_V;
                        SOut_zd  <= data_out(7-read_cnt);
                        read_cnt := read_cnt + 1;
                        IF read_cnt = 8 THEN
                            read_cnt := 0;
                        END IF;
                    END IF;
                    -- embedded operation finished during status read
                    IF rising_edge(PDONE) THEN
                        IF PGM_ACT = '1' THEN
                            EndProgramming;
                        ELSIF PGM_SEC_REG_ACT = '1' THEN
                            EndSECRProgramming;
                        ELSIF IRP_ACT = '1' THEN
                            EndIRPP;
                        ELSIF DLRNV_ACT = '1' THEN
                            WIP <= '0';
                            WEL <= '0';
                            DLRNV := DLRNV_in;
                            DLRV  := DLRNV;
                            DLRNV_ACT <= '0';
                            DLRNV_programmed <= '1';
                        ELSIF PASS_PGM_ACT = '1' THEN
                            EndPassProgramming;
                        END IF;
                    END IF;
                    IF rising_edge(EDONE) THEN
                        IF SECT_ERS_ACT = '1' THEN
                            EndSecErasing;
                        ELSIF HALF_BLOCK_ERS_ACT = '1' THEN
                            EndHalfBlockErasing;
                        ELSIF BLOCK_ERS_ACT = '1' THEN
                            EndBlockErasing;
                        ELSIF CHIP_ERS_ACT = '1' THEN
                            EndChipErasing;
                        ELSIF SECT_ERS_SEC_REG_ACT = '1' THEN
                            EndSECRErasing;
                        END IF;
                    END IF;
                    IF rising_edge(WDONE) THEN
                        IF WRR_NV_ACT = '1' THEN
                            EndWRR_NV;
                        ELSIF WRAR_NV_ACT = '1' THEN
                            EndWRAR_NV;
                        ELSIF SET_PNTR_PROT_ACT = '1' THEN
                            EndSPRP;
                        END IF;
                    END IF;

                WHEN RDCR3_DATA_OUTPUT =>
                    IF falling_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        reg_rd   <= true;
                        data_out := CR3_V;
                        SOut_zd  <= data_out(7-read_cnt);
                        read_cnt := read_cnt + 1;
                        IF read_cnt = 8 THEN
                            read_cnt := 0;
                        END IF;
                    END IF;
                    -- embedded operation finished during status read
                    IF rising_edge(PDONE) THEN
                        IF PGM_ACT = '1' THEN
                            EndProgramming;
                        ELSIF PGM_SEC_REG_ACT = '1' THEN
                            EndSECRProgramming;
                        ELSIF IRP_ACT = '1' THEN
                            EndIRPP;
                        ELSIF DLRNV_ACT = '1' THEN
                            WIP <= '0';
                            WEL <= '0';
                            DLRNV := DLRNV_in;
                            DLRV  := DLRNV;
                            DLRNV_ACT <= '0';
                            DLRNV_programmed <= '1';
                        ELSIF PASS_PGM_ACT = '1' THEN
                            EndPassProgramming;
                        END IF;
                    END IF;
                    IF rising_edge(EDONE) THEN
                        IF SECT_ERS_ACT = '1' THEN
                            EndSecErasing;
                        ELSIF HALF_BLOCK_ERS_ACT = '1' THEN
                            EndHalfBlockErasing;
                        ELSIF BLOCK_ERS_ACT = '1' THEN
                            EndBlockErasing;
                        ELSIF CHIP_ERS_ACT = '1' THEN
                            EndChipErasing;
                        ELSIF SECT_ERS_SEC_REG_ACT = '1' THEN
                            EndSECRErasing;
                        END IF;
                    END IF;
                    IF rising_edge(WDONE) THEN
                        IF WRR_NV_ACT = '1' THEN
                            EndWRR_NV;
                        ELSIF WRAR_NV_ACT = '1' THEN
                            EndWRAR_NV;
                        ELSIF SET_PNTR_PROT_ACT = '1' THEN
                            EndSPRP;
                        END IF;
                    END IF;

                WHEN DLPRD_DUMMY | IRPRD_DUMMY | PASSRD_DUMMY | PRRD_DUMMY | RUID_DUMMY =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        dummy_cnt := dummy_cnt + 1;
                        IF dummy_cnt = Latency_code THEN
                            any_read <= TRUE, FALSE AFTER 1 ns;
                        END IF;
                    END IF;

                WHEN RDP_DUMMY =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        dummy_cnt := dummy_cnt + 1;
                        IF dummy_cnt = 24 THEN
                            any_read <= TRUE, FALSE AFTER 1 ns;
                        END IF;
                    END IF;

                WHEN DLPRD_DATA_OUTPUT =>
                    IF falling_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        fast_rd  <= true;
                        data_out := DLRV;
                        IF QPI = '1' THEN
                            IO3RESETNegOut_zd <= data_out(7-read_cnt);
                            WPNegOut_zd    <= data_out(6-read_cnt);
                            SOut_zd        <= data_out(5-read_cnt);
                            SIOut_zd       <= data_out(4-read_cnt);
                            read_cnt := read_cnt + 4;
                            IF read_cnt = 8 THEN
                                read_cnt := 0;
                            END IF;
                        ELSE
                            SOut_zd <= data_out(7-read_cnt);
                            read_cnt := read_cnt + 1;
                            IF read_cnt = 8 THEN
                                read_cnt := 0;
                            END IF;
                        END IF;
                    END IF;

                WHEN IRPRD_DATA_OUTPUT =>
                    IF falling_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        fast_rd <= true;
                        IF QPI = '1' THEN
                            IO3RESETNegOut_zd <= IRP(7-read_cnt+8*byte_cnt);
                            WPNegOut_zd    <= IRP(6-read_cnt+8*byte_cnt);
                            SOut_zd        <= IRP(5-read_cnt+8*byte_cnt);
                            SIOut_zd       <= IRP(4-read_cnt+8*byte_cnt);
                            read_cnt := read_cnt + 4;
                            IF read_cnt = 8 THEN
                                read_cnt := 0;
                                byte_cnt := byte_cnt+1;
                                IF byte_cnt = 2 THEN
                                    byte_cnt := 0;
                                END IF;
                            END IF;
                        ELSE
                            SOut_zd <= IRP(7-read_cnt+8*byte_cnt);
                            read_cnt := read_cnt + 1;
                            IF read_cnt = 8 THEN
                                read_cnt := 0;
                                byte_cnt := byte_cnt+1;
                                IF byte_cnt = 2 THEN
                                    byte_cnt := 0;
                                END IF;
                            END IF;
                        END IF;
                    END IF;

                WHEN IBLRD_ADDR =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF (Instruct = IBLRD AND ADS = '0') THEN
                                Address_in(4*addr_cnt)   := IO3RESETNegIn;
                                Address_in(4*addr_cnt+1) := WPNegIn;
                                Address_in(4*addr_cnt+2) := SOIn;
                                Address_in(4*addr_cnt+3) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 6 THEN
                                    FOR I IN 23 DOWNTO 0 LOOP
                                        addr_bytes(23-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            ELSIF Instruct = IBLRD4 OR (Instruct = IBLRD AND ADS = '1') THEN
                                Address_in(4*addr_cnt)   := IO3RESETNegIn;
                                Address_in(4*addr_cnt+1) := WPNegIn;
                                Address_in(4*addr_cnt+2) := SOIn;
                                Address_in(4*addr_cnt+3) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 8 THEN
                                    FOR I IN 31 DOWNTO 0 LOOP
                                        addr_bytes(31-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            END IF;
                        ELSE
                            IF (Instruct = IBLRD AND ADS = '0') THEN
                                Address_in(addr_cnt) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 24 THEN
                                    FOR I IN 23 DOWNTO 0 LOOP
                                        addr_bytes(23-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            ELSIF Instruct = IBLRD4 OR (Instruct = IBLRD AND ADS = '1') THEN
                                Address_in(addr_cnt) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 32 THEN
                                    FOR I IN 31 DOWNTO 0 LOOP
                                        addr_bytes(31-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            END IF;
                        END IF;
                    END IF;

                WHEN IBLRD_DATA_OUTPUT =>
                    IF falling_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        fast_rd <= true;
                        sect := Address/(SecSize+1);
                        IF IBL_Sec_Prot(sect) = '0' THEN
                            IBLAR := (OTHERS => '0');
                        ELSIF IBL_Sec_Prot(sect) = '1' THEN
                            IBLAR := (OTHERS => '1');
                        END IF;
                        data_out := IBLAR;
                        IF QPI = '1' THEN
                            IO3RESETNegOut_zd <= data_out(7-read_cnt);
                            WPNegOut_zd    <= data_out(6-read_cnt);
                            SOut_zd        <= data_out(5-read_cnt);
                            SIOut_zd       <= data_out(4-read_cnt);
                            read_cnt := read_cnt + 4;
                            IF read_cnt = 8 THEN
                                read_cnt := 0;
                            END IF;
                        ELSE
                            SOut_zd <= data_out(7-read_cnt);
                            read_cnt := read_cnt + 1;
                            IF read_cnt = 8 THEN
                                read_cnt := 0;
                            END IF;
                        END IF;
                    END IF;

                WHEN SECRR_ADDR | RSFDP_ADDR | SEC_REG_PGM_ADDR =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF ADS = '0' THEN
                                Address_in(4*addr_cnt)   := IO3RESETNegIn;
                                Address_in(4*addr_cnt+1) := WPNegIn;
                                Address_in(4*addr_cnt+2) := SOIn;
                                Address_in(4*addr_cnt+3) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 6 THEN
                                    FOR I IN 23 DOWNTO 0 LOOP
                                        addr_bytes(23-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            ELSIF ADS = '1' THEN
                                Address_in(4*addr_cnt)   := IO3RESETNegIn;
                                Address_in(4*addr_cnt+1) := WPNegIn;
                                Address_in(4*addr_cnt+2) := SOIn;
                                Address_in(4*addr_cnt+3) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 8 THEN
                                    FOR I IN 31 DOWNTO 0 LOOP
                                        addr_bytes(31-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            END IF;
                        ELSE
                            IF ADS = '0' THEN
                                Address_in(addr_cnt) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 24 THEN
                                    FOR I IN 23 DOWNTO 0 LOOP
                                        addr_bytes(23-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            ELSIF ADS = '1' THEN
                                Address_in(addr_cnt) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 32 THEN
                                    FOR I IN 31 DOWNTO 0 LOOP
                                        addr_bytes(31-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            END IF;
                        END IF;
                    END IF;

                WHEN SECRR_DUMMY | RSFDP_DUMMY =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        dummy_cnt := dummy_cnt + 1;
                        CLK_PER   := NOW - LAST_CLK;
                        LAST_CLK  := NOW;
                        IF dummy_cnt = Latency_code THEN
                            any_read <= TRUE, FALSE AFTER 1 ns;
                            IF QPI = '1' THEN
                                IF (CLK_PER < 66.6 ns AND Latency_code = 1) OR -- > 15MHz
                                (CLK_PER < 40 ns AND Latency_code = 2) OR -- > 25MHz
                                (CLK_PER < 28.57 ns AND Latency_code = 3) OR -- > 35MHz
                                (CLK_PER < 22.22 ns AND Latency_code = 4) OR -- > 45MHz
                                (CLK_PER < 18.18 ns AND Latency_code = 5) OR -- > 55MHz
                                (CLK_PER < 15.38 ns AND Latency_code = 6) OR -- > 65MHz
                                (CLK_PER < 13.33 ns AND Latency_code = 7) OR -- > 75MHz
                                (CLK_PER < 11.76 ns AND Latency_code = 8) OR -- > 85MHz
                                (CLK_PER < 10.52 ns AND Latency_code = 9) OR -- > 95MHz
                                (CLK_PER < 9.25 ns  AND Latency_code = 10) OR -- > 108MHz
                                (CLK_PER < 8.695 ns AND Latency_code <= 12) OR -- > 115MHz
                                (CLK_PER < 8.333 ns AND Latency_code <= 14) THEN  -- > 120MHz
                                    ASSERT FALSE
                                    REPORT "More wait states are required for " &
                                        "this clock frequency value"
                                    SEVERITY WARNING;
                                END IF;
                            ELSE
                                IF (CLK_PER < 20 ns AND Latency_code = 1) OR -- > 50MHz
                                (CLK_PER < 15.38 ns AND Latency_code = 2) OR -- > 65MHz
                                (CLK_PER < 13.33 ns AND Latency_code = 3) OR -- > 75MHz
                                (CLK_PER < 11.76 ns AND Latency_code = 4) OR -- > 85MHz
                                (CLK_PER < 10.52 ns AND Latency_code = 5) OR -- > 95MHz
                                (CLK_PER <  9.25 ns AND Latency_code <= 8) THEN  -- > 108MHz
                                    ASSERT FALSE
                                    REPORT "More wait states are required for " &
                                        "this clock frequency value"
                                    SEVERITY WARNING;
                                END IF;
                            END IF;
                        END IF;
                    END IF;

                WHEN SECRR_DATA_OUTPUT =>
                    IF falling_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        fast_rd <= true;
                        IF Address/(SECRHiAddr+1) = 0 THEN
                            data_out := to_slv(SECRMem(Address),8);
                            IF QPI = '1' THEN
                                IF NOT (Address/(SecRegSize+1) = 3
                                AND SECRRP = '0' AND NVLOCK = '0') THEN
                                    IO3RESETNegOut_zd <= data_out(7-read_cnt);
                                    WPNegOut_zd    <= data_out(6-read_cnt);
                                    SOut_zd        <= data_out(5-read_cnt);
                                    SIOut_zd       <= data_out(4-read_cnt);
                                    read_cnt := read_cnt + 4;
                                    IF read_cnt = 8 THEN
                                        read_cnt := 0;
                                        IF Address < SECRHiAddr THEN-- 1023
                                            Address := Address + 1;
                                        END IF;
                                    END IF;
                                ELSE
                                    -- Security Region 3 Read Password Protected
                                    IO3RESETNegOut_zd <= 'X';
                                    WPNegOut_zd    <= 'X';
                                    SOut_zd        <= 'X';
                                    SIOut_zd       <= 'X';
                                END IF;
                            ELSE
                                IF NOT (Address/(SecRegSize+1) = 3
                                AND SECRRP = '0' AND NVLOCK = '0') THEN
                                    SOut_zd <= data_out(7-read_cnt);
                                    read_cnt := read_cnt + 1;
                                    IF read_cnt = 8 THEN
                                        read_cnt := 0;
                                        IF Address < SECRHiAddr THEN-- 1023
                                            Address := Address + 1;
                                        END IF;
                                    END IF;
                                ELSE
                                    -- Security Region 3 Read Password Protected
                                    SOut_zd <= 'X';
                                END IF;
                            END IF;
                        END IF;
                    END IF;

                WHEN PASSRD_DATA_OUTPUT =>
                    IF falling_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        fast_rd <= true;
                        IF QPI = '1' THEN
                            IO3RESETNegOut_zd <= Password_reg(7-read_cnt+8*byte_cnt);
                            WPNegOut_zd    <= Password_reg(6-read_cnt+8*byte_cnt);
                            SOut_zd        <= Password_reg(5-read_cnt+8*byte_cnt);
                            SIOut_zd       <= Password_reg(4-read_cnt+8*byte_cnt);
                            read_cnt := read_cnt + 4;
                            IF read_cnt = 8 THEN
                                read_cnt := 0;
                                byte_cnt := byte_cnt+1;
                                IF byte_cnt = 8 THEN
                                    byte_cnt := 0;
                                END IF;
                            END IF;
                        ELSE
                            SOut_zd <= Password_reg(7-read_cnt+8*byte_cnt);
                            read_cnt := read_cnt + 1;
                            IF read_cnt = 8 THEN
                                read_cnt := 0;
                                byte_cnt := byte_cnt+1;
                                IF byte_cnt = 8 THEN
                                    byte_cnt := 0;
                                END IF;
                            END IF;
                        END IF;
                    END IF;

                WHEN PRRD_DATA_OUTPUT =>
                    IF falling_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        fast_rd <= true;
                        data_out := PR;
                        IF QPI = '1' THEN
                            IO3RESETNegOut_zd <= data_out(7-read_cnt);
                            WPNegOut_zd    <= data_out(6-read_cnt);
                            SOut_zd        <= data_out(5-read_cnt);
                            SIOut_zd       <= data_out(4-read_cnt);
                            read_cnt := read_cnt + 4;
                            IF read_cnt = 8 THEN
                                read_cnt := 0;
                            END IF;
                        ELSE
                            SOut_zd <= data_out(7-read_cnt);
                            read_cnt := read_cnt + 1;
                            IF read_cnt = 8 THEN
                                read_cnt := 0;
                            END IF;
                        END IF;
                    END IF;

                WHEN RDID_DATA_OUTPUT =>
                    IF falling_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        reg_rd <= true;
                        IF QPI = '1' THEN
                            IF byte_cnt < 3 THEN
                                IO3RESETNegOut_zd <= ManufIDDeviceID(7-read_cnt+8*byte_cnt);
                                WPNegOut_zd    <= ManufIDDeviceID(6-read_cnt+8*byte_cnt);
                                SOut_zd        <= ManufIDDeviceID(5-read_cnt+8*byte_cnt);
                                SIOut_zd       <= ManufIDDeviceID(4-read_cnt+8*byte_cnt);
                                read_cnt := read_cnt + 4;
                                IF read_cnt = 8 THEN
                                    read_cnt := 0;
                                    byte_cnt := byte_cnt+1;
                                END IF;
                            ELSE
                                IO3RESETNegOut_zd <= 'X';
                                WPNegOut_zd    <= 'X';
                                SOut_zd        <= 'X';
                                SIOut_zd       <= 'X';
                            END IF;
                        ELSE
                            IF byte_cnt < 3 THEN
                                SOut_zd <= ManufIDDeviceID(7-read_cnt+8*byte_cnt);
                                read_cnt := read_cnt + 1;
                                IF read_cnt = 8 THEN
                                    read_cnt := 0;
                                    byte_cnt := byte_cnt+1;
                                END IF;
                            ELSE
                                SOut_zd <= 'X';
                            END IF;
                        END IF;
                    END IF;

                WHEN RDQID_DATA_OUTPUT =>
                    IF falling_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        reg_rd <= true;
                        IF byte_cnt < 3 THEN
                            IO3RESETNegOut_zd <= ManufIDDeviceID(7-read_cnt+8*byte_cnt);
                            WPNegOut_zd    <= ManufIDDeviceID(6-read_cnt+8*byte_cnt);
                            SOut_zd        <= ManufIDDeviceID(5-read_cnt+8*byte_cnt);
                            SIOut_zd       <= ManufIDDeviceID(4-read_cnt+8*byte_cnt);
                            read_cnt := read_cnt + 4;
                            IF read_cnt = 8 THEN
                                read_cnt := 0;
                                byte_cnt := byte_cnt+1;
                            END IF;
                        ELSE
                            IO3RESETNegOut_zd <= 'X';
                            WPNegOut_zd    <= 'X';
                            SOut_zd        <= 'X';
                            SIOut_zd       <= 'X';
                        END IF;
                    END IF;

                WHEN RUID_DATA_OUTPUT =>
                    IF falling_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        fast_rd <= true;
                        IF QPI = '1' THEN
                            IF byte_cnt < 64 THEN
                                IO3RESETNegOut_zd <= UID(63-read_cnt);
                                WPNegOut_zd    <= UID(62-read_cnt);
                                SOut_zd        <= UID(61-read_cnt);
                                SIOut_zd       <= UID(60-read_cnt);
                                read_cnt := read_cnt + 4;
                            ELSE
                                IO3RESETNegOut_zd <= 'X';
                                WPNegOut_zd    <= 'X';
                                SOut_zd        <= 'X';
                                SIOut_zd       <= 'X';
                            END IF;
                        ELSE
                            IF byte_cnt < 64 THEN
                                SOut_zd <= UID(63-read_cnt);
                                read_cnt := read_cnt + 1;
                            ELSE
                                SOut_zd <= 'X';
                            END IF;
                        END IF;
                    END IF;

                WHEN RSFDP_DATA_OUTPUT =>
                    IF falling_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        fast_rd <= true;
                        IF Address <= SFDPHiAddr THEN
                            data_out := to_slv(SFDP_array(Address),8);
                            IF QPI = '1' THEN
                                IO3RESETNegOut_zd <= data_out(7-read_cnt);
                                WPNegOut_zd    <= data_out(6-read_cnt);
                                SOut_zd        <= data_out(5-read_cnt);
                                SIOut_zd       <= data_out(4-read_cnt);
                                read_cnt := read_cnt + 4;
                                IF read_cnt = 8 THEN
                                    read_cnt := 0;
                                    Address := Address + 1;
                                END IF;
                            ELSE
                                SOut_zd <= data_out(7-read_cnt);
                                read_cnt := read_cnt + 1;
                                IF read_cnt = 8 THEN
                                    read_cnt := 0;
                                    Address := Address + 1;
                                END IF;
                            END IF;
                        END IF;
                    END IF;

                WHEN SET_BURST_DATA_INPUT =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' OR QUAD = '1' THEN
                            data_cnt := data_cnt +1;
                            IF data_cnt = 7 THEN
                                WL6 <= WPNegIn;
                                WL5 <= SOIn;
                                WL4 <= SIIn;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) AND data_cnt = 8 THEN
                        CR3_V(6 DOWNTO 4) <= WL6 & WL5 & WL4;
                    END IF;

                WHEN RDP_DATA_OUTPUT =>
                    IF falling_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        fast_rd <= true;
                        IF QPI = '1' THEN
                            IF byte_cnt < 2 THEN
                                IO3RESETNegOut_zd <= DeviceID(7-read_cnt+8*byte_cnt);
                                WPNegOut_zd    <= DeviceID(6-read_cnt+8*byte_cnt);
                                SOut_zd        <= DeviceID(5-read_cnt+8*byte_cnt);
                                SIOut_zd       <= DeviceID(4-read_cnt+8*byte_cnt);
                                read_cnt := read_cnt + 4;
                                IF read_cnt = 8 THEN
                                    read_cnt := 0;
                                    byte_cnt := byte_cnt+1;
                                END IF;
                            ELSE
                                IO3RESETNegOut_zd <= 'X';
                                WPNegOut_zd    <= 'X';
                                SOut_zd        <= 'X';
                                SIOut_zd       <= 'X';
                            END IF;
                        ELSE
                            IF byte_cnt < 2 THEN
                                SOut_zd <= DeviceID(7-read_cnt+8*byte_cnt);
                                read_cnt := read_cnt + 1;
                                IF read_cnt = 8 THEN
                                    read_cnt := 0;
                                    byte_cnt := byte_cnt+1;
                                END IF;
                            ELSE
                                SOut_zd <= 'X';
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) AND DPD_ACT = '1' THEN
                        RES_in <= '1';
                    END IF;

                WHEN PGM_ADDR =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF Instruct = PP AND ADS = '0' THEN
                                Address_in(4*addr_cnt)   := IO3RESETNegIn;
                                Address_in(4*addr_cnt+1) := WPNegIn;
                                Address_in(4*addr_cnt+2) := SOIn;
                                Address_in(4*addr_cnt+3) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 6 THEN
                                    FOR I IN 23 DOWNTO 0 LOOP
                                        addr_bytes(23-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            ELSIF Instruct = PP4 OR (Instruct = PP AND ADS = '1') THEN
                                Address_in(4*addr_cnt)   := IO3RESETNegIn;
                                Address_in(4*addr_cnt+1) := WPNegIn;
                                Address_in(4*addr_cnt+2) := SOIn;
                                Address_in(4*addr_cnt+3) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 8 THEN
                                    FOR I IN 31 DOWNTO 0 LOOP
                                        addr_bytes(31-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            END IF;
                        ELSE
                            IF (Instruct = PP OR Instruct = QPP) AND ADS = '0' THEN
                                Address_in(addr_cnt) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 24 THEN
                                    FOR I IN 23 DOWNTO 0 LOOP
                                        addr_bytes(23-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            ELSIF Instruct = PP4 OR Instruct = QPP4 OR
                            ((Instruct = PP OR Instruct = QPP) AND ADS = '1') THEN
                                Address_in(addr_cnt) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 32 THEN
                                    FOR I IN 31 DOWNTO 0 LOOP
                                        addr_bytes(31-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            END IF;
                        END IF;
                    END IF;

                WHEN PGM_DATAIN =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF byte_cnt > PageSize THEN
                        --If more than PageSize+1 bytes
                        --are sent to the device previously latched data
                        --are discarded and last 256 data bytes are
                        --guaranteed to be programmed correctly within
                        --the same page.
                            FOR i IN 0 TO PageSize-1 LOOP
                                Data_in(i) := Data_in(i+1);
                            END LOOP;
                            byte_cnt := 255;
                        END IF;
                        IF QPI = '1' OR Instruct = QPP OR Instruct = QPP4 THEN
                            Data_in(byte_cnt)(7-data_cnt) := IO3RESETNegIn;
                            Data_in(byte_cnt)(6-data_cnt) := WPNegIn;
                            Data_in(byte_cnt)(5-data_cnt) := SOIn;
                            Data_in(byte_cnt)(4-data_cnt) := SIIn;
                            data_cnt := data_cnt + 4;
                        ELSE
                            Data_in(byte_cnt)(7-data_cnt) := SIIn;
                            data_cnt := data_cnt + 1;
                        END IF;
                        IF data_cnt = 8 THEN
                            data_cnt := 0;
                            byte_cnt := byte_cnt + 1;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) AND data_cnt = 0 AND byte_cnt > 0 THEN
                        WIP <= '1';
                        pgm_page := Address/(PageSize+1);
                        IF Sec_Prot(Address/(SecSize+1)) = '1' OR
                        (ES = '1' AND ((SECT_ERS_ACT = '1' AND SectorErase = Address/(SecSize+1)) OR
                        (HALF_BLOCK_ERS_ACT = '1' AND HalfBlockErase = Address/(HalfBlockSize+1)) OR
                        (BLOCK_ERS_ACT = '1' AND BlockErase = Address/(BlockSize+1)))) THEN
                            P_ERR <= '1'; -- attempt programming in protected area or
                                         -- suspended sector/half_block/block
                        ELSE
                            FOR i IN 0 TO PageSize LOOP
                                Byte_slv := Data_in(i);
                                WByte(i) <= to_nat(Byte_slv);
                            END LOOP;
                            PSTART  <= '1', '0' AFTER 1 ns;
                            Addr    := Address;
                            Addr_tmp:= Address;
                            wr_cnt  := byte_cnt - 1;
                            FOR i IN wr_cnt DOWNTO 0 LOOP
                                IF Viol /= '0' THEN
                                    WData(i) := -1;
                                ELSE
                                    WData(i) := to_nat(Data_in(i));
                                END IF;
                            END LOOP;
                            AddrLOW := (Addr/(PageSize + 1))*(PageSize + 1);
                            AddrHIGH := AddrLOW + PageSize;
                            cnt := 0;
                            FOR i IN 0 TO wr_cnt LOOP
                                new_int := WData(i);
                                old_int := Mem(Addr + i - cnt);
                                IF new_int > -1 THEN
                                    new_bit := to_slv(new_int,8);
                                    IF old_int > -1 THEN
                                        old_bit := to_slv(old_int,8);
                                        FOR j IN 0 TO 7 LOOP
                                            IF old_bit(j) = '0' THEN
                                                new_bit(j) := '0';
                                            END IF;
                                        END LOOP;
                                        new_int := to_nat(new_bit);
                                    END IF;
                                    WData(i) := new_int;
                                ELSE
                                    WData(i) := -1;
                                END IF;
                                Mem(Addr + i - cnt) := - 1;
                                IF Addr + i = AddrHIGH THEN
                                    Addr := AddrLOW;
                                    cnt := i + 1;
                                END IF;
                            END LOOP;
                        END IF;
                    END IF;

                WHEN PGM =>
                    PGM_ACT <= '1';
                    IF falling_edge(CSNeg_ipd) THEN
                        opcode_cnt := 0;
                    END IF;
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := IO3RESETNegIn;
                                opcode(6-opcode_cnt) := WPNegIn;
                                opcode(5-opcode_cnt) := SOIn;
                                opcode(4-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 4;
                        ELSE
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 1;
                        END IF;
                        IF opcode_cnt = 8 THEN
                            Instruct <= NONE;
                            IF opcode = "00000101" THEN -- 05h
                                Instruct <= RDSR1;
                            ELSIF opcode = "00000111" THEN -- 07h
                                Instruct <= RDSR2;
                            ELSIF opcode = "00110101" THEN -- 35h
                                Instruct <= RDCR1;
                            ELSIF opcode = "00010101" THEN -- 15h
                                Instruct <= RDCR2;
                            ELSIF opcode = "00110011" THEN -- 33h
                                Instruct <= RDCR3;
                            ELSIF opcode = "01100101" THEN -- 65h
                                Instruct <= RDAR;
                            ELSIF opcode = "01110101" THEN -- 75h
                                Instruct <= EPS;
                            ELSIF opcode = "00110000" THEN -- 30h
                                Instruct <= CLSR;
                            ELSIF opcode = "01100110" THEN -- 66h
                                Instruct <= RSTEN;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) THEN
                        IF opcode_cnt = 8 THEN
                            IF Instruct = EPS AND PRGSUSP_in = '0' AND
                            ES = '0' AND P_ERR = '0' THEN
                                IF RES_TO_SUSP_TIME = '0' THEN
                                    PRGSUSP_in <= '1';
                                END IF;
                            ELSIF Instruct = CLSR THEN
                                IF P_ERR = '1' THEN
                                    WIP    <= '0';
                                    WEL    <= '0';
                                    WREN_V <= '0';
                                    P_ERR  <= '0';
                                    E_ERR  <= '0';
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(PRGSUSP_out) THEN
                        WIP    <= '0';
                        PS     <= '1';
                        PGSUSP <= '1', '0' AFTER 1 ns;
                        PRGSUSP_in <= '0';
                    END IF;
                    IF rising_edge(PDONE) THEN
                        EndProgramming;
                    END IF;

                WHEN SECT_ERS_ADDR =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF (Instruct = SE AND ADS = '0') THEN
                                Address_in(4*addr_cnt)   := IO3RESETNegIn;
                                Address_in(4*addr_cnt+1) := WPNegIn;
                                Address_in(4*addr_cnt+2) := SOIn;
                                Address_in(4*addr_cnt+3) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 6 THEN
                                    FOR I IN 23 DOWNTO 0 LOOP
                                        addr_bytes(23-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            ELSIF Instruct = SE4 OR (Instruct = SE AND ADS = '1') THEN
                                Address_in(4*addr_cnt)   := IO3RESETNegIn;
                                Address_in(4*addr_cnt+1) := WPNegIn;
                                Address_in(4*addr_cnt+2) := SOIn;
                                Address_in(4*addr_cnt+3) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 8 THEN
                                    FOR I IN 31 DOWNTO 0 LOOP
                                        addr_bytes(31-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            END IF;
                        ELSE
                            IF (Instruct = SE AND ADS = '0') THEN
                                Address_in(addr_cnt) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 24 THEN
                                    FOR I IN 23 DOWNTO 0 LOOP
                                        addr_bytes(23-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            ELSIF Instruct = SE4 OR (Instruct = SE AND ADS = '1') THEN
                                Address_in(addr_cnt) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 32 THEN
                                    FOR I IN 31 DOWNTO 0 LOOP
                                        addr_bytes(31-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) THEN
                        IF (QPI = '1' AND
                        ((Instruct = SE4 AND addr_cnt = 8) OR
                        (Instruct = SE AND ((ADS = '0' AND addr_cnt = 6) OR (ADS = '1' AND addr_cnt = 8))))) OR
                        (QPI = '0' AND
                        ((Instruct = SE4 AND addr_cnt = 32) OR
                        (Instruct = SE AND ((ADS = '0' AND addr_cnt = 24) OR (ADS = '1' AND addr_cnt = 32))))) THEN
                            WIP <= '1';
                            SECT_ERS_ACT <= '1';
                            SectorErase := Address/(SecSize+1);
                            IF Sec_Prot(SectorErase) = '1' THEN
                                E_ERR <= '1';
                            ELSE
                                ESTART  <= '1', '0' AFTER 1 ns;
                                AddrLOW  := SectorErase*(SecSize+1);
                                AddrHIGH := AddrLOW + SecSize;
                                FOR i IN AddrLOW TO AddrHIGH LOOP
                                    Mem(i) := -1;
                                END LOOP;
                            END IF;
                        END IF;
                    END IF;

                WHEN HALF_BLOCK_ERS_ADDR =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF (Instruct = HBE AND ADS = '0') THEN
                                Address_in(4*addr_cnt)   := IO3RESETNegIn;
                                Address_in(4*addr_cnt+1) := WPNegIn;
                                Address_in(4*addr_cnt+2) := SOIn;
                                Address_in(4*addr_cnt+3) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 6 THEN
                                    FOR I IN 23 DOWNTO 0 LOOP
                                        addr_bytes(23-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            ELSIF Instruct = HBE4 OR (Instruct = HBE AND ADS = '1') THEN
                                Address_in(4*addr_cnt)   := IO3RESETNegIn;
                                Address_in(4*addr_cnt+1) := WPNegIn;
                                Address_in(4*addr_cnt+2) := SOIn;
                                Address_in(4*addr_cnt+3) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 8 THEN
                                    FOR I IN 31 DOWNTO 0 LOOP
                                        addr_bytes(31-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            END IF;
                        ELSE
                            IF (Instruct = HBE AND ADS = '0') THEN
                                Address_in(addr_cnt) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 24 THEN
                                    FOR I IN 23 DOWNTO 0 LOOP
                                        addr_bytes(23-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            ELSIF Instruct = HBE4 OR (Instruct = HBE AND ADS = '1') THEN
                                Address_in(addr_cnt) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 32 THEN
                                    FOR I IN 31 DOWNTO 0 LOOP
                                        addr_bytes(31-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) THEN
                        IF (QPI = '1' AND
                        ((Instruct = HBE4 AND addr_cnt = 8) OR
                        (Instruct = HBE AND ((ADS = '0' AND addr_cnt = 6) OR (ADS = '1' AND addr_cnt = 8))))) OR
                        (QPI = '0' AND
                        ((Instruct = HBE4 AND addr_cnt = 32) OR
                        (Instruct = HBE AND ((ADS = '0' AND addr_cnt = 24) OR (ADS = '1' AND addr_cnt = 32))))) THEN
                            WIP <= '1';
                            HALF_BLOCK_ERS_ACT <= '1';
                            HalfBlockErase := Address/(HalfBlockSize+1);
                            IF HalfBlock_Prot(HalfBlockErase) = '1' THEN
                                E_ERR <= '1';
                            ELSE
                                ESTART  <= '1', '0' AFTER 1 ns;
                                AddrLOW  := HalfBlockErase*(HalfBlockSize+1);
                                AddrHIGH := AddrLOW + HalfBlockSize;
                                FOR i IN AddrLOW TO AddrHIGH LOOP
                                    Mem(i) := -1;
                                END LOOP;
                            END IF;
                        END IF;
                    END IF;

                WHEN BLOCK_ERS_ADDR =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF (Instruct = BE AND ADS = '0') THEN
                                Address_in(4*addr_cnt)   := IO3RESETNegIn;
                                Address_in(4*addr_cnt+1) := WPNegIn;
                                Address_in(4*addr_cnt+2) := SOIn;
                                Address_in(4*addr_cnt+3) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 6 THEN
                                    FOR I IN 23 DOWNTO 0 LOOP
                                        addr_bytes(23-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            ELSIF Instruct = BE4 OR (Instruct = BE AND ADS = '1') THEN
                                Address_in(4*addr_cnt)   := IO3RESETNegIn;
                                Address_in(4*addr_cnt+1) := WPNegIn;
                                Address_in(4*addr_cnt+2) := SOIn;
                                Address_in(4*addr_cnt+3) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 8 THEN
                                    FOR I IN 31 DOWNTO 0 LOOP
                                        addr_bytes(31-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            END IF;
                        ELSE
                            IF (Instruct = BE AND ADS = '0') THEN
                                Address_in(addr_cnt) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 24 THEN
                                    FOR I IN 23 DOWNTO 0 LOOP
                                        addr_bytes(23-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            ELSIF Instruct = BE4 OR (Instruct = BE AND ADS = '1') THEN
                                Address_in(addr_cnt) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 32 THEN
                                    FOR I IN 31 DOWNTO 0 LOOP
                                        addr_bytes(31-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) THEN
                        IF (QPI = '1' AND
                        ((Instruct = BE4 AND addr_cnt = 8) OR
                        (Instruct = BE AND ((ADS = '0' AND addr_cnt = 6) OR (ADS = '1' AND addr_cnt = 8))))) OR
                        (QPI = '0' AND
                        ((Instruct = BE4 AND addr_cnt = 32) OR
                        (Instruct = BE AND ((ADS = '0' AND addr_cnt = 24) OR (ADS = '1' AND addr_cnt = 32))))) THEN
                            WIP <= '1';
                            BLOCK_ERS_ACT <= '1';
                            BlockErase := Address/(BlockSize+1);
                            IF Block_Prot(BlockErase) = '1' THEN
                                E_ERR <= '1';
                            ELSE
                                BLOCK_ERS_ACT <= '1';
                                ESTART  <= '1', '0' AFTER 1 ns;
                                AddrLOW  := BlockErase*(BlockSize+1);
                                AddrHIGH := AddrLOW + BlockSize;
                                FOR i IN AddrLOW TO AddrHIGH LOOP
                                    Mem(i) := -1;
                                END LOOP;
                            END IF;
                        END IF;
                    END IF;

                WHEN SECT_ERS =>
                    IF falling_edge(CSNeg_ipd) THEN
                        opcode_cnt := 0;
                    END IF;
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := IO3RESETNegIn;
                                opcode(6-opcode_cnt) := WPNegIn;
                                opcode(5-opcode_cnt) := SOIn;
                                opcode(4-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 4;
                        ELSE
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 1;
                        END IF;
                        IF opcode_cnt = 8 THEN
                            Instruct <= NONE;
                            IF opcode = "00000101" THEN -- 05h
                                Instruct <= RDSR1;
                            ELSIF opcode = "00000111" THEN -- 07h
                                Instruct <= RDSR2;
                            ELSIF opcode = "00110101" THEN -- 35h
                                Instruct <= RDCR1;
                            ELSIF opcode = "00010101" THEN -- 15h
                                Instruct <= RDCR2;
                            ELSIF opcode = "00110011" THEN -- 33h
                                Instruct <= RDCR3;
                            ELSIF opcode = "01100101" THEN -- 65h
                                Instruct <= RDAR;
                            ELSIF opcode = "01110101" THEN -- 75h
                                Instruct <= EPS;
                            ELSIF opcode = "00110000" THEN -- 30h
                                Instruct <= CLSR;
                            ELSIF opcode = "01100110" THEN -- 66h
                                Instruct <= RSTEN;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) THEN
                        IF opcode_cnt = 8 THEN
                            IF Instruct = EPS AND ERSSUSP_in = '0' AND E_ERR = '0' THEN
                                IF RES_TO_SUSP_TIME = '0' THEN
                                    ERSSUSP_in <= '1';
                                END IF;
                            ELSIF Instruct = CLSR THEN
                                IF P_ERR = '1' THEN
                                    WIP    <= '0';
                                    WEL    <= '0';
                                    WREN_V <= '0';
                                    P_ERR  <= '0';
                                    E_ERR  <= '0';
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(ERSSUSP_out) THEN
                        WIP    <= '0';
                        ES     <= '1';
                        ESUSP  <= '1', '0' AFTER 1 ns;
                        ERSSUSP_in <= '0';
                    END IF;
                    IF rising_edge(EDONE) THEN
                        EndSecErasing;
                    END IF;

                WHEN HALF_BLOCK_ERS =>
                    IF falling_edge(CSNeg_ipd) THEN
                        opcode_cnt := 0;
                    END IF;
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := IO3RESETNegIn;
                                opcode(6-opcode_cnt) := WPNegIn;
                                opcode(5-opcode_cnt) := SOIn;
                                opcode(4-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 4;
                        ELSE
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 1;
                        END IF;
                        IF opcode_cnt = 8 THEN
                            Instruct <= NONE;
                            IF opcode = "00000101" THEN -- 05h
                                Instruct <= RDSR1;
                            ELSIF opcode = "00000111" THEN -- 07h
                                Instruct <= RDSR2;
                            ELSIF opcode = "00110101" THEN -- 35h
                                Instruct <= RDCR1;
                            ELSIF opcode = "00010101" THEN -- 15h
                                Instruct <= RDCR2;
                            ELSIF opcode = "00110011" THEN -- 33h
                                Instruct <= RDCR3;
                            ELSIF opcode = "01100101" THEN -- 65h
                                Instruct <= RDAR;
                            ELSIF opcode = "01110101" THEN -- 75h
                                Instruct <= EPS;
                            ELSIF opcode = "00110000" THEN -- 30h
                                Instruct <= CLSR;
                            ELSIF opcode = "01100110" THEN -- 66h
                                Instruct <= RSTEN;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) THEN
                        IF opcode_cnt = 8 THEN
                            IF Instruct = EPS AND ERSSUSP_in = '0' AND E_ERR = '0' THEN
                                IF RES_TO_SUSP_TIME = '0' THEN
                                    ERSSUSP_in <= '1';
                                END IF;
                            ELSIF Instruct = CLSR THEN
                                IF P_ERR = '1' THEN
                                    WIP    <= '0';
                                    WEL    <= '0';
                                    WREN_V <= '0';
                                    P_ERR  <= '0';
                                    E_ERR  <= '0';
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(ERSSUSP_out) THEN
                        WIP    <= '0';
                        ES     <= '1';
                        ESUSP  <= '1', '0' AFTER 1 ns;
                        ERSSUSP_in <= '0';
                    END IF;
                    IF rising_edge(EDONE) THEN
                        EndHalfBlockErasing;
                    END IF;

                WHEN BLOCK_ERS =>
                    IF falling_edge(CSNeg_ipd) THEN
                        opcode_cnt := 0;
                    END IF;
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := IO3RESETNegIn;
                                opcode(6-opcode_cnt) := WPNegIn;
                                opcode(5-opcode_cnt) := SOIn;
                                opcode(4-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 4;
                        ELSE
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 1;
                        END IF;
                        IF opcode_cnt = 8 THEN
                            Instruct <= NONE;
                            IF opcode = "00000101" THEN -- 05h
                                Instruct <= RDSR1;
                            ELSIF opcode = "00000111" THEN -- 07h
                                Instruct <= RDSR2;
                            ELSIF opcode = "00110101" THEN -- 35h
                                Instruct <= RDCR1;
                            ELSIF opcode = "00010101" THEN -- 15h
                                Instruct <= RDCR2;
                            ELSIF opcode = "00110011" THEN -- 33h
                                Instruct <= RDCR3;
                            ELSIF opcode = "01100101" THEN -- 65h
                                Instruct <= RDAR;
                            ELSIF opcode = "01110101" THEN -- 75h
                                Instruct <= EPS;
                            ELSIF opcode = "00110000" THEN -- 30h
                                Instruct <= CLSR;
                            ELSIF opcode = "01100110" THEN -- 66h
                                Instruct <= RSTEN;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) THEN
                        IF opcode_cnt = 8 THEN
                            IF Instruct = EPS AND ERSSUSP_in = '0' AND E_ERR = '0' THEN
                                IF RES_TO_SUSP_TIME = '0' THEN
                                    ERSSUSP_in <= '1';
                                END IF;
                            ELSIF Instruct = CLSR THEN
                                IF P_ERR = '1' THEN
                                    WIP    <= '0';
                                    WEL    <= '0';
                                    WREN_V <= '0';
                                    P_ERR  <= '0';
                                    E_ERR  <= '0';
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(ERSSUSP_out) THEN
                        WIP    <= '0';
                        ES     <= '1';
                        ESUSP  <= '1', '0' AFTER 1 ns;
                        ERSSUSP_in <= '0';
                    END IF;
                    IF rising_edge(EDONE) THEN
                        EndBlockErasing;
                    END IF;

                WHEN CHIP_ERS =>
                    CHIP_ERS_ACT <= '1';
                    IF falling_edge(CSNeg_ipd) THEN
                        opcode_cnt := 0;
                    END IF;
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := IO3RESETNegIn;
                                opcode(6-opcode_cnt) := WPNegIn;
                                opcode(5-opcode_cnt) := SOIn;
                                opcode(4-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 4;
                        ELSE
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 1;
                        END IF;
                        IF opcode_cnt = 8 THEN
                            Instruct <= NONE;
                            IF opcode = "00000101" THEN -- 05h
                                Instruct <= RDSR1;
                            ELSIF opcode = "00000111" THEN -- 07h
                                Instruct <= RDSR2;
                            ELSIF opcode = "00110101" THEN -- 35h
                                Instruct <= RDCR1;
                            ELSIF opcode = "00010101" THEN -- 15h
                                Instruct <= RDCR2;
                            ELSIF opcode = "00110011" THEN -- 33h
                                Instruct <= RDCR3;
                            ELSIF opcode = "01100101" THEN -- 65h
                                Instruct <= RDAR;
                            ELSIF opcode = "00110000" THEN -- 30h
                                Instruct <= CLSR;
                            ELSIF opcode = "01100110" THEN -- 66h
                                Instruct <= RSTEN;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) THEN
                        IF opcode_cnt = 8 THEN
                            IF Instruct = CLSR THEN
                                IF E_ERR = '1' THEN
                                    WIP    <= '0';
                                    WEL    <= '0';
                                    WREN_V <= '0';
                                    P_ERR  <= '0';
                                    E_ERR  <= '0';
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(EDONE) THEN
                        EndChipErasing;
                    END IF;

                WHEN SEC_REG_PGM_DATAIN =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF byte_cnt > PageSize THEN
                        --If more than PageSize+1 bytes
                        --are sent to the device previously latched data
                        --are discarded and last 256 data bytes are
                        --guaranteed to be programmed correctly within
                        --the same page.
                            FOR i IN 0 TO PageSize-1 LOOP
                                Data_in(i) := Data_in(i+1);
                            END LOOP;
                            byte_cnt := 255;
                        END IF;
                        IF QPI = '1' THEN
                            Data_in(byte_cnt)(7-data_cnt) := IO3RESETNegIn;
                            Data_in(byte_cnt)(6-data_cnt) := WPNegIn;
                            Data_in(byte_cnt)(5-data_cnt) := SOIn;
                            Data_in(byte_cnt)(4-data_cnt) := SIIn;
                            data_cnt := data_cnt + 4;
                        ELSE
                            Data_in(byte_cnt)(7-data_cnt) := SIIn;
                            data_cnt := data_cnt + 1;
                        END IF;
                        IF data_cnt = 8 THEN
                            data_cnt := 0;
                            byte_cnt := byte_cnt + 1;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) AND data_cnt = 0 AND byte_cnt > 0 AND
                    (Address/(SECRHiAddr+1) = 0) THEN
                        WIP <= '1';
                        sec_region := Address/(SecRegSize+1);
                        -- sec region write protected or locked by the CR1 LB
                        IF (NVLOCK = '0' AND (sec_region = 2 OR sec_region = 3)) OR
                        (sec_region = 0 AND LB0 = '1') OR (sec_region = 1 AND LB1 = '1') OR
                        (sec_region = 2 AND LB2 = '1') OR (sec_region = 3 AND LB3 = '1') THEN
                            P_ERR <= '1'; -- attempt programming in protected area or
                                         -- suspended sector/half_block/block
                        ELSE
                            FOR i IN 0 TO PageSize LOOP
                                Byte_slv := Data_in(i);
                                WByte(i) <= to_nat(Byte_slv);
                            END LOOP;
                            PSTART  <= '1', '0' AFTER 1 ns;
                            Addr    := Address;
                            Addr_tmp:= Address;
                            wr_cnt  := byte_cnt - 1;
                            FOR i IN wr_cnt DOWNTO 0 LOOP
                                IF Viol /= '0' THEN
                                    WData(i) := -1;
                                ELSE
                                    WData(i) := to_nat(Data_in(i));
                                END IF;
                            END LOOP;
                            AddrLOW := (Addr/(PageSize + 1))*(PageSize + 1);
                            AddrHIGH := AddrLOW + PageSize;
                            cnt := 0;
                            FOR i IN 0 TO wr_cnt LOOP
                                new_int := WData(i);
                                old_int := SECRMem(Addr + i - cnt);
                                IF new_int > -1 THEN
                                    new_bit := to_slv(new_int,8);
                                    IF old_int > -1 THEN
                                        old_bit := to_slv(old_int,8);
                                        FOR j IN 0 TO 7 LOOP
                                            IF old_bit(j) = '0' THEN
                                                new_bit(j) := '0';
                                            END IF;
                                        END LOOP;
                                        new_int := to_nat(new_bit);
                                    END IF;
                                    WData(i) := new_int;
                                ELSE
                                    WData(i) := -1;
                                END IF;
                                SECRMem(Addr + i - cnt) := - 1;
                                IF Addr + i = AddrHIGH THEN
                                    Addr := AddrLOW;
                                    cnt := i + 1;
                                END IF;
                            END LOOP;
                        END IF;
                    END IF;

                WHEN PGM_SEC_REG =>
                    PGM_SEC_REG_ACT <= '1';
                    IF falling_edge(CSNeg_ipd) THEN
                        opcode_cnt := 0;
                    END IF;
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := IO3RESETNegIn;
                                opcode(6-opcode_cnt) := WPNegIn;
                                opcode(5-opcode_cnt) := SOIn;
                                opcode(4-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 4;
                        ELSE
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 1;
                        END IF;
                        IF opcode_cnt = 8 THEN
                            Instruct <= NONE;
                            IF opcode = "00000101" THEN -- 05h
                                Instruct <= RDSR1;
                            ELSIF opcode = "00000111" THEN -- 07h
                                Instruct <= RDSR2;
                            ELSIF opcode = "00110101" THEN -- 35h
                                Instruct <= RDCR1;
                            ELSIF opcode = "00010101" THEN -- 15h
                                Instruct <= RDCR2;
                            ELSIF opcode = "00110011" THEN -- 33h
                                Instruct <= RDCR3;
                            ELSIF opcode = "01100101" THEN -- 65h
                                Instruct <= RDAR;
                            ELSIF opcode = "00110000" THEN -- 30h
                                Instruct <= CLSR;
                            ELSIF opcode = "01100110" THEN -- 66h
                                Instruct <= RSTEN;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) THEN
                        IF opcode_cnt = 8 THEN
                            IF Instruct = CLSR THEN
                                IF P_ERR = '1' THEN
                                    WIP    <= '0';
                                    WEL    <= '0';
                                    WREN_V <= '0';
                                    P_ERR  <= '0';
                                    E_ERR  <= '0';
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(PDONE) THEN
                        EndSECRProgramming;
                    END IF;

                WHEN SEC_REG_ERS_ADDR =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF ADS = '0' THEN
                                Address_in(4*addr_cnt)   := IO3RESETNegIn;
                                Address_in(4*addr_cnt+1) := WPNegIn;
                                Address_in(4*addr_cnt+2) := SOIn;
                                Address_in(4*addr_cnt+3) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 6 THEN
                                    FOR I IN 23 DOWNTO 0 LOOP
                                        addr_bytes(23-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            ELSIF ADS = '1' THEN
                                Address_in(4*addr_cnt)   := IO3RESETNegIn;
                                Address_in(4*addr_cnt+1) := WPNegIn;
                                Address_in(4*addr_cnt+2) := SOIn;
                                Address_in(4*addr_cnt+3) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 8 THEN
                                    FOR I IN 31 DOWNTO 0 LOOP
                                        addr_bytes(31-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            END IF;
                        ELSE
                            IF ADS = '0' THEN
                                Address_in(addr_cnt) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 24 THEN
                                    FOR I IN 23 DOWNTO 0 LOOP
                                        addr_bytes(23-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            ELSIF ADS = '1' THEN
                                Address_in(addr_cnt) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 32 THEN
                                    FOR I IN 31 DOWNTO 0 LOOP
                                        addr_bytes(31-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) THEN
                        IF ((QPI = '1' AND ((ADS = '0' AND addr_cnt = 6) OR (ADS = '1' AND addr_cnt = 8))) OR
                        (QPI = '0' AND ((ADS = '0' AND addr_cnt = 24) OR (ADS = '1' AND addr_cnt = 32)))) AND
                        Address/(SECRHiAddr+1) = 0 THEN
                            WIP <= '1';
                            SECT_ERS_SEC_REG_ACT <= '1';
                            sec_region := Address/(SecRegSize+1);
                            -- sec region write protected or locked by the CR1 LB
                            IF (NVLOCK = '0' AND (sec_region = 2 OR sec_region = 3)) OR
                            (sec_region = 0 AND LB0 = '1') OR (sec_region = 1 AND LB1 = '1') OR
                            (sec_region = 2 AND LB2 = '1') OR (sec_region = 3 AND LB3 = '1') THEN
                                E_ERR <= '1';
                            ELSE
                                ESTART  <= '1', '0' AFTER 1 ns;
                                AddrLOW  := sec_region*(SecRegSize+1);
                                AddrHIGH := AddrLOW + SecRegSize;
                                FOR i IN AddrLOW TO AddrHIGH LOOP
                                    SECRMem(i) := -1;
                                END LOOP;
                            END IF;
                        END IF;
                    END IF;

                WHEN SECT_ERS_SEC_REG =>
                    IF falling_edge(CSNeg_ipd) THEN
                        opcode_cnt := 0;
                    END IF;
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := IO3RESETNegIn;
                                opcode(6-opcode_cnt) := WPNegIn;
                                opcode(5-opcode_cnt) := SOIn;
                                opcode(4-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 4;
                        ELSE
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 1;
                        END IF;
                        IF opcode_cnt = 8 THEN
                            Instruct <= NONE;
                            IF opcode = "00000101" THEN -- 05h
                                Instruct <= RDSR1;
                            ELSIF opcode = "00000111" THEN -- 07h
                                Instruct <= RDSR2;
                            ELSIF opcode = "00110101" THEN -- 35h
                                Instruct <= RDCR1;
                            ELSIF opcode = "00010101" THEN -- 15h
                                Instruct <= RDCR2;
                            ELSIF opcode = "00110011" THEN -- 33h
                                Instruct <= RDCR3;
                            ELSIF opcode = "01100101" THEN -- 65h
                                Instruct <= RDAR;
                            ELSIF opcode = "00110000" THEN -- 30h
                                Instruct <= CLSR;
                            ELSIF opcode = "01100110" THEN -- 66h
                                Instruct <= RSTEN;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) THEN
                        IF opcode_cnt = 8 THEN
                            IF Instruct = CLSR THEN
                                IF E_ERR = '1' THEN
                                    WIP    <= '0';
                                    WEL    <= '0';
                                    WREN_V <= '0';
                                    P_ERR  <= '0';
                                    E_ERR  <= '0';
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(EDONE) THEN
                        EndSECRErasing;
                    END IF;

                WHEN PGMSUS =>
                    IF falling_edge(CSNeg_ipd) THEN
                        Instruct   <= NONE;
                        opcode_cnt := 0;
                        addr_cnt   := 0;
                        dummy_cnt  := 0;
                        mode_cnt   := 0;
                        dlp_act    := FALSE;
                        Address    := 0;
                        mode_byte  := (OTHERS => '0');
                        data_cnt   := 0;
                        bit_cnt    := 0;
                        read_cnt   := 0;
                        byte_cnt   := 0;
                        Latency_code := to_nat(CR3_V(3 DOWNTO 0));
                        IF Latency_code = 0 THEN
                            Latency_code := 8;
                        END IF;
                        IF CR3_V(6 DOWNTO 5) = "00" THEN
                            WrapLength := 8;
                        END IF;
                        IF CR3_V(6 DOWNTO 5) = "01" THEN
                            WrapLength := 16;
                        END IF;
                        IF CR3_V(6 DOWNTO 5) = "10" THEN
                            WrapLength := 32;
                        END IF;
                        IF CR3_V(6 DOWNTO 5) = "11" THEN
                            WrapLength := 64;
                        END IF;
                    END IF;
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := IO3RESETNegIn;
                                opcode(6-opcode_cnt) := WPNegIn;
                                opcode(5-opcode_cnt) := SOIn;
                                opcode(4-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 4;
                        ELSE
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 1;
                        END IF;
                        IF opcode_cnt = 8 THEN
                            CASE opcode IS
                                WHEN "00000011"  =>
                                    Instruct <= READ; -- 03h
                                WHEN "00010011"  =>
                                    Instruct <= READ4; -- 13h
                                WHEN "00001011"  =>
                                    Instruct <= FAST_READ; -- 0Bh
                                WHEN "00001100"  =>
                                    Instruct <= FAST_READ4; -- 0Ch
                                WHEN "00111011"  =>
                                    Instruct <= DOR; -- 3Bh
                                WHEN "00111100"  =>
                                    Instruct <= DOR4; -- 3Ch
                                WHEN "10111011"  =>
                                    Instruct <= DIOR; -- BBh
                                WHEN "10111100"  =>
                                    Instruct <= DIOR4; -- BCh
                                WHEN "01101011"  =>
                                    Instruct <= QOR; -- 6Bh
                                WHEN "01101100"  =>
                                    Instruct <= QOR4; -- 6Ch
                                WHEN "11101011"  =>
                                    Instruct <= QIOR; -- EBh
                                WHEN "11101100"  =>
                                    Instruct <= QIOR4; -- ECh
                                WHEN "11101101"  =>
                                    Instruct <= DDRQIOR; -- EDh
                                WHEN "11101110"  =>
                                    Instruct <= DDRQIOR4; -- EEh
                                WHEN "01000001"  =>
                                    Instruct <= DLPRD; -- 41h
                                    Latency_code := 1;
                                WHEN "00111101"  =>
                                    Instruct <= IBLRD;-- 3Dh
                                WHEN "11100000"  =>
                                    Instruct <= IBLRD4;-- E0h
                                WHEN "01100110"  =>
                                    Instruct <= RSTEN; -- 66h
                                WHEN "01001000"  =>
                                    Instruct <= SECRR; -- 48h
                                WHEN "10011111"  =>
                                    Instruct <= RDID;-- 9Fh
                                WHEN "10101111"  =>
                                    Instruct <= RDQID;-- AFh
                                WHEN "01001011"  =>
                                    Instruct <= RUID; -- 4Bh
                                    Latency_code := 32;
                                WHEN "01011010"  =>
                                    Instruct <= RSFDP;-- 5Ah
                                WHEN "01110111"  =>
                                    Instruct <= SET_BURST; -- 77h
                                WHEN "00000101"  =>
                                    Instruct <= RDSR1; -- 05h
                                WHEN "00000111"  =>
                                    Instruct <= RDSR2; -- 07h
                                WHEN "00110101"  =>
                                    Instruct <= RDCR1; -- 35h
                                WHEN "00010101"  =>
                                    Instruct <= RDCR2; -- 15h
                                WHEN "00110011"  =>
                                    Instruct <= RDCR3; -- 33h
                                WHEN "01100101"  =>
                                    Instruct <= RDAR; -- 65h
                                WHEN "00110110"  =>
                                    Instruct <= IBL; -- 36h
                                WHEN "11100001"  =>
                                    Instruct <= IBL4; -- E1h
                                WHEN "00111001"  =>
                                    Instruct <= IBUL; -- 39h
                                WHEN "11100010"  =>
                                    Instruct <= IBUL4; -- E2h
                                WHEN "00000110"  =>
                                    Instruct <= WREN; -- 06h
                                WHEN "00000100"  =>
                                    Instruct <= WRDI; -- 04h
                                WHEN "00110000"  =>
                                    Instruct <= CLSR; -- 30h
                                WHEN "01111010"  =>
                                    Instruct <= EPR; -- 7Ah
                                WHEN OTHERS =>
                                    NULL;
                            END CASE;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) THEN
                        IF opcode_cnt = 8 THEN
                            IF Instruct = WREN THEN
                                WEL <= '1';
                            ELSIF Instruct = WRDI THEN
                                WEL <= '0';
                                WREN_V <= '0';
                            ELSIF Instruct = CLSR THEN
                                WIP <= '0';
                                WEL <= '0';
                                WREN_V <= '0';
                                P_ERR <= '0';
                                E_ERR <= '0';
                            ELSIF Instruct = EPR THEN
                                PS <= '0';
                                WIP <= '1';
                                PGRES <= '1', '0' AFTER 1 ns;
                                RES_TO_SUSP_TIME <= '1', '0' AFTER tdevice_RNS; -- 100us
                            END IF;
                        END IF;
                    END IF;

                WHEN ERSSUS =>
                    IF falling_edge(CSNeg_ipd) THEN
                        Instruct   <= NONE;
                        opcode_cnt := 0;
                        addr_cnt   := 0;
                        dummy_cnt  := 0;
                        mode_cnt   := 0;
                        dlp_act    := FALSE;
                        Address    := 0;
                        mode_byte  := (OTHERS => '0');
                        data_cnt   := 0;
                        bit_cnt    := 0;
                        read_cnt   := 0;
                        byte_cnt   := 0;
                        Latency_code := to_nat(CR3_V(3 DOWNTO 0));
                        IF Latency_code = 0 THEN
                            Latency_code := 8;
                        END IF;
                        IF CR3_V(6 DOWNTO 5) = "00" THEN
                            WrapLength := 8;
                        END IF;
                        IF CR3_V(6 DOWNTO 5) = "01" THEN
                            WrapLength := 16;
                        END IF;
                        IF CR3_V(6 DOWNTO 5) = "10" THEN
                            WrapLength := 32;
                        END IF;
                        IF CR3_V(6 DOWNTO 5) = "11" THEN
                            WrapLength := 64;
                        END IF;
                    END IF;
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := IO3RESETNegIn;
                                opcode(6-opcode_cnt) := WPNegIn;
                                opcode(5-opcode_cnt) := SOIn;
                                opcode(4-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 4;
                        ELSE
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 1;
                        END IF;
                        IF opcode_cnt = 8 THEN
                            CASE opcode IS
                                WHEN "00000011"  =>
                                    Instruct <= READ; -- 03h
                                WHEN "00010011"  =>
                                    Instruct <= READ4; -- 13h
                                WHEN "00001011"  =>
                                    Instruct <= FAST_READ; -- 0Bh
                                WHEN "00001100"  =>
                                    Instruct <= FAST_READ4; -- 0Ch
                                WHEN "00111011"  =>
                                    Instruct <= DOR; -- 3Bh
                                WHEN "00111100"  =>
                                    Instruct <= DOR4; -- 3Ch
                                WHEN "10111011"  =>
                                    Instruct <= DIOR; -- BBh
                                WHEN "10111100"  =>
                                    Instruct <= DIOR4; -- BCh
                                WHEN "01101011"  =>
                                    Instruct <= QOR; -- 6Bh
                                WHEN "01101100"  =>
                                    Instruct <= QOR4; -- 6Ch
                                WHEN "11101011"  =>
                                    Instruct <= QIOR; -- EBh
                                WHEN "11101100"  =>
                                    Instruct <= QIOR4; -- ECh
                                WHEN "11101101"  =>
                                    Instruct <= DDRQIOR; -- EDh
                                WHEN "11101110"  =>
                                    Instruct <= DDRQIOR4; -- EEh
                                WHEN "01000001"  =>
                                    Instruct <= DLPRD; -- 41h
                                    Latency_code := 1;
                                WHEN "00111101"  =>
                                    Instruct <= IBLRD;-- 3Dh
                                WHEN "11100000"  =>
                                    Instruct <= IBLRD4;-- E0h
                                WHEN "01100110"  =>
                                    Instruct <= RSTEN; -- 66h
                                WHEN "01001000"  =>
                                    Instruct <= SECRR; -- 48h
                                WHEN "10011111"  =>
                                    Instruct <= RDID;-- 9Fh
                                WHEN "10101111"  =>
                                    Instruct <= RDQID;-- AFh
                                WHEN "01001011"  =>
                                    Instruct <= RUID; -- 4Bh
                                    Latency_code := 32;
                                WHEN "01011010"  =>
                                    Instruct <= RSFDP;-- 5Ah
                                WHEN "01110111"  =>
                                    Instruct <= SET_BURST; -- 77h
                                WHEN "00000101"  =>
                                    Instruct <= RDSR1; -- 05h
                                WHEN "00000111"  =>
                                    Instruct <= RDSR2; -- 07h
                                WHEN "00110101"  =>
                                    Instruct <= RDCR1; -- 35h
                                WHEN "00010101"  =>
                                    Instruct <= RDCR2; -- 15h
                                WHEN "00110011"  =>
                                    Instruct <= RDCR3; -- 33h
                                WHEN "01100101"  =>
                                    Instruct <= RDAR; -- 65h
                                WHEN "00110110"  =>
                                    Instruct <= IBL; -- 36h
                                WHEN "11100001"  =>
                                    Instruct <= IBL4; -- E1h
                                WHEN "00111001"  =>
                                    Instruct <= IBUL; -- 39h
                                WHEN "11100010"  =>
                                    Instruct <= IBUL4; -- E2h
                                WHEN "00000110"  =>
                                    Instruct <= WREN; -- 06h
                                WHEN "00000100"  =>
                                    Instruct <= WRDI; -- 04h
                                WHEN "00110000"  =>
                                    Instruct <= CLSR; -- 30h
                                WHEN "00000010"  =>
                                    Instruct <= PP; -- 02h
                                WHEN "00010010"  =>
                                    Instruct <= PP4; -- 12h
                                WHEN "00110010"  =>
                                    Instruct <= QPP; -- 32h
                                WHEN "00110100"  =>
                                    Instruct <= QPP4; -- 34h
                                WHEN "01000010"  =>
                                    Instruct <= SECRP; -- 42h
                                WHEN "01111010"  =>
                                    Instruct <= EPR; -- 7Ah
                                WHEN OTHERS =>
                                    NULL;
                            END CASE;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) THEN
                        IF opcode_cnt = 8 THEN
                            IF Instruct = WREN THEN
                                WEL <= '1';
                            ELSIF Instruct = WRDI THEN
                                WEL <= '0';
                                WREN_V <= '0';
                            ELSIF Instruct = CLSR THEN
                                WIP <= '0';
                                WEL <= '0';
                                WREN_V <= '0';
                                P_ERR <= '0';
                                E_ERR <= '0';
                            ELSIF Instruct = EPR THEN
                                ES <= '0';
                                WIP <= '1';
                                ERES <= '1', '0' AFTER 1 ns;
                                RES_TO_SUSP_TIME <= '1', '0' AFTER tdevice_RNS; -- 100us
                            END IF;
                        END IF;
                    END IF;

                WHEN WRR_DATA_INPUT =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF byte_cnt <= 3 THEN
                                WRR_reg_in(7-data_cnt + 8*byte_cnt) := IO3RESETNegIn;
                                WRR_reg_in(6-data_cnt + 8*byte_cnt) := WPNegIn;
                                WRR_reg_in(5-data_cnt + 8*byte_cnt) := SOIn;
                                WRR_reg_in(4-data_cnt + 8*byte_cnt) := SIIn;
                            END IF;
                            data_cnt := data_cnt + 4;
                        ELSE
                            IF byte_cnt <= 3 THEN
                                WRR_reg_in(7-data_cnt + 8*byte_cnt) := SIIn;
                            END IF;
                            data_cnt := data_cnt + 1;
                        END IF;
                        IF data_cnt = 8 THEN
                            data_cnt := 0;
                            byte_cnt := byte_cnt + 1;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) AND data_cnt = 0 AND
                    byte_cnt > 0 AND byte_cnt <= 4 THEN
                        IF srp1 = '0' AND (srp0 = '0' OR WPNegIn = '1' OR QUAD = '1' OR QPI = '1') THEN
                            WIP <= '1';
                            IF WEL = '1' THEN
                                WSTART_NV <= '1', '0' AFTER 1 ns;
                            ELSIF WREN_V = '1' THEN
                                WSTART_V <= '1', '0' AFTER 1 ns;
                            END IF;
                        END IF;
                        -- CR3_V is not protected by SRP0 and SRP1
                        IF WREN_V = '1' AND byte_cnt = 4 THEN
                            CR3_in            <= WRR_reg_in(31 DOWNTO 24);
                            CR3_V(6 DOWNTO 5) <= CR3_in(6 DOWNTO 5); -- WL
                            CR3_V(4)          <= CR3_in(4);     -- WE
                            CR3_V(3 DOWNTO 0) <= CR3_in(3 DOWNTO 0); -- RL
                        END IF;
                    END IF;

                WHEN WRR_NV =>
                    WRR_NV_ACT <= '1';
                    IF falling_edge(CSNeg_ipd) THEN
                        opcode_cnt := 0;
                    END IF;
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := IO3RESETNegIn;
                                opcode(6-opcode_cnt) := WPNegIn;
                                opcode(5-opcode_cnt) := SOIn;
                                opcode(4-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 4;
                        ELSE
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 1;
                        END IF;
                        IF opcode_cnt = 8 THEN
                            Instruct <= NONE;
                            IF opcode = "00000101" THEN -- 05h
                                Instruct <= RDSR1;
                            ELSIF opcode = "00000111" THEN -- 07h
                                Instruct <= RDSR2;
                            ELSIF opcode = "00110101" THEN -- 35h
                                Instruct <= RDCR1;
                            ELSIF opcode = "00010101" THEN -- 15h
                                Instruct <= RDCR2;
                            ELSIF opcode = "00110011" THEN -- 33h
                                Instruct <= RDCR3;
                            ELSIF opcode = "01100101" THEN -- 65h
                                Instruct <= RDAR;
                            ELSIF opcode = "00110000" THEN -- 30h
                                Instruct <= CLSR;
                            ELSIF opcode = "01100110" THEN -- 66h
                                Instruct <= RSTEN;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) THEN
                        IF opcode_cnt = 8 THEN
                            IF Instruct = CLSR THEN
                                IF P_ERR = '1' THEN
                                    WIP    <= '0';
                                    WEL    <= '0';
                                    WREN_V <= '0';
                                    P_ERR  <= '0';
                                    E_ERR  <= '0';
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(WDONE) THEN
                        EndWRR_NV;
                    END IF;

                WHEN WRR_V =>
                    IF rising_edge(WDONE) THEN
                        EndWRR_V;
                    END IF;

                WHEN WRAR_ADDR =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF ADS = '0' THEN
                                Address_wrar_in(4*addr_cnt)   := IO3RESETNegIn;
                                Address_wrar_in(4*addr_cnt+1) := WPNegIn;
                                Address_wrar_in(4*addr_cnt+2) := SOIn;
                                Address_wrar_in(4*addr_cnt+3) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 6 THEN
                                    FOR I IN 23 DOWNTO 0 LOOP
                                        addr_bytes(23-i) := Address_wrar_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address_wrar := to_nat(addr_bytes);
                                END IF;
                            ELSIF ADS = '1' THEN
                                Address_wrar_in(4*addr_cnt)   := IO3RESETNegIn;
                                Address_wrar_in(4*addr_cnt+1) := WPNegIn;
                                Address_wrar_in(4*addr_cnt+2) := SOIn;
                                Address_wrar_in(4*addr_cnt+3) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 8 THEN
                                    FOR I IN 31 DOWNTO 0 LOOP
                                        addr_bytes(31-i) := Address_wrar_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address_wrar := to_nat(addr_bytes);
                                END IF;
                            END IF;
                        ELSE
                            IF ADS = '0' THEN
                                Address_wrar_in(addr_cnt) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 24 THEN
                                    FOR I IN 23 DOWNTO 0 LOOP
                                        addr_bytes(23-i) := Address_wrar_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address_wrar := to_nat(addr_bytes);
                                END IF;
                            ELSIF ADS = '1' THEN
                                Address_wrar_in(addr_cnt) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 32 THEN
                                    FOR I IN 31 DOWNTO 0 LOOP
                                        addr_bytes(31-i) := Address_wrar_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address_wrar := to_nat(addr_bytes);
                                END IF;
                            END IF;
                        END IF;
                    END IF;

                WHEN WRAR_DATA_INPUT =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF data_cnt <= 7 THEN
                                WRAR_in(7-data_cnt) := IO3RESETNegIn;
                                WRAR_in(6-data_cnt) := WPNegIn;
                                WRAR_in(5-data_cnt) := SOIn;
                                WRAR_in(4-data_cnt) := SIIn;
                            END IF;
                            data_cnt := data_cnt + 4;
                        ELSE
                            IF data_cnt <= 7 THEN
                                WRAR_in(7-data_cnt) := SIIn;
                            END IF;
                            data_cnt := data_cnt + 1;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) AND data_cnt = 8 THEN
                        IF Address_wrar = 0 OR Address_wrar = 2 OR
                        Address_wrar = 3 OR Address_wrar = 4 OR
                        Address_wrar = 5 THEN
                            IF SRP1 = '0' AND (SRP0 = '0' OR WPNegIn = '1' OR QUAD = '1' OR QPI = '1') THEN
                                WIP <= '1';
                                WSTART_NV <= '1', '0' AFTER 1 ns;
                            END IF;
                        END IF;
                        IF Address_wrar >= 16#20# AND Address_wrar <= 16#27# THEN
                            IF PWDMLB = '1' THEN
                                WIP <= '1';
                                WSTART_NV <= '1', '0' AFTER 1 ns;
                            END IF;
                        END IF;
                        IF Address_wrar = 16#30# OR Address_wrar = 16#31# THEN
                            WIP <= '1';
                            IF IRP(2 DOWNTO 0) /= "111" THEN
                                P_ERR <= '1';
                            END IF;
                            IF SECURE_OPN = '0' AND IRP_in(4) = '0' THEN
                                P_ERR <= '1';
                            END IF;
                            IF IRP(2 DOWNTO 0) = "111" AND P_ERR = '0' THEN
                                WSTART_NV <= '1', '0' AFTER 1 ns;
                            END IF;
                        END IF;
                        IF Address_wrar = 16#39# OR Address_wrar = 16#3A#  OR Address_wrar = 16#3B# THEN
                            IF NVLOCK  = '1' THEN
                                WIP <= '1';
                                WSTART_NV <= '1', '0' AFTER 1 ns;
                            END IF;
                        END IF;
                        IF Address_wrar = 16#800000# OR Address_wrar = 16#800002# OR
                        Address_wrar = 16#800003# OR Address_wrar = 16#800004# OR Address_wrar = 16#800005# THEN
                            IF SRP1 = '0' AND (SRP0 = '0' OR WPNegIn = '1' OR QUAD = '1' OR QPI = '1') THEN
                                WIP <= '1';
                                WSTART_V <= '1', '0' AFTER 1 ns;
                            END IF;
                        END IF;
                    END IF;

                WHEN WRAR_NV =>
                    WRAR_NV_ACT <= '1';
                    IF falling_edge(CSNeg_ipd) THEN
                        opcode_cnt := 0;
                    END IF;
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := IO3RESETNegIn;
                                opcode(6-opcode_cnt) := WPNegIn;
                                opcode(5-opcode_cnt) := SOIn;
                                opcode(4-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 4;
                        ELSE
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 1;
                        END IF;
                        IF opcode_cnt = 8 THEN
                            Instruct <= NONE;
                            IF opcode = "00000101" THEN -- 05h
                                Instruct <= RDSR1;
                            ELSIF opcode = "00000111" THEN -- 07h
                                Instruct <= RDSR2;
                            ELSIF opcode = "00110101" THEN -- 35h
                                Instruct <= RDCR1;
                            ELSIF opcode = "00010101" THEN -- 15h
                                Instruct <= RDCR2;
                            ELSIF opcode = "00110011" THEN -- 33h
                                Instruct <= RDCR3;
                            ELSIF opcode = "01100101" THEN -- 65h
                                Instruct <= RDAR;
                            ELSIF opcode = "00110000" THEN -- 30h
                                Instruct <= CLSR;
                            ELSIF opcode = "01100110" THEN -- 66h
                                Instruct <= RSTEN;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) THEN
                        IF opcode_cnt = 8 THEN
                            IF Instruct = CLSR THEN
                                IF P_ERR = '1' THEN
                                    WIP    <= '0';
                                    WEL    <= '0';
                                    WREN_V <= '0';
                                    P_ERR  <= '0';
                                    E_ERR  <= '0';
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(WDONE) THEN
                        EndWRAR_NV;
                    END IF;

                WHEN WRAR_V =>
                    IF rising_edge(WDONE) THEN
                        EndWRAR_V;
                    END IF;

                WHEN IRP_PGM_DATA_INPUT =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF byte_cnt <= 1 THEN
                                IRP_in(7-data_cnt + 8*byte_cnt) <= IO3RESETNegIn;
                                IRP_in(6-data_cnt + 8*byte_cnt) <= WPNegIn;
                                IRP_in(5-data_cnt + 8*byte_cnt) <= SOIn;
                                IRP_in(4-data_cnt + 8*byte_cnt) <= SIIn;
                            END IF;
                            data_cnt := data_cnt + 4;
                        ELSE
                            IF byte_cnt <= 1 THEN
                                IRP_in(7-data_cnt + 8*byte_cnt) <= SIIn;
                            END IF;
                            data_cnt := data_cnt + 1;
                        END IF;
                        IF data_cnt = 8 THEN
                            data_cnt := 0;
                            byte_cnt := byte_cnt + 1;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) AND data_cnt = 0 AND byte_cnt = 2 THEN
                        WIP <= '1';
                        IRP_ACT <= '1';
                        IF IRP(2 DOWNTO 0) /= "111" THEN
                            IF IRP_in(6) = '0' OR IRP_in(4) = '0' OR
                            IRP_in(2) = '0' OR IRP_in(1) = '0' OR IRP_in(0) = '0' THEN
                                P_ERR <= '1';
                            END IF;
                        END IF;
                        IF SECURE_OPN = '0' AND IRP_in(4) = '0' THEN
                            P_ERR <= '1';
                        END IF;
                        IF P_ERR = '0' THEN
                            PSTART <= '1', '0' AFTER 1 ns;
                        END IF;
                    END IF;

                WHEN IRP_PGM =>
                    IF falling_edge(CSNeg_ipd) THEN
                        opcode_cnt := 0;
                    END IF;
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := IO3RESETNegIn;
                                opcode(6-opcode_cnt) := WPNegIn;
                                opcode(5-opcode_cnt) := SOIn;
                                opcode(4-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 4;
                        ELSE
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 1;
                        END IF;
                        IF opcode_cnt = 8 THEN
                            Instruct <= NONE;
                            IF opcode = "00000101" THEN -- 05h
                                Instruct <= RDSR1;
                            ELSIF opcode = "00000111" THEN -- 07h
                                Instruct <= RDSR2;
                            ELSIF opcode = "00110101" THEN -- 35h
                                Instruct <= RDCR1;
                            ELSIF opcode = "00010101" THEN -- 15h
                                Instruct <= RDCR2;
                            ELSIF opcode = "00110011" THEN -- 33h
                                Instruct <= RDCR3;
                            ELSIF opcode = "01100101" THEN -- 65h
                                Instruct <= RDAR;
                            ELSIF opcode = "00110000" THEN -- 30h
                                Instruct <= CLSR;
                            ELSIF opcode = "01100110" THEN -- 66h
                                Instruct <= RSTEN;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) THEN
                        IF opcode_cnt = 8 THEN
                            IF Instruct = CLSR THEN
                                IF P_ERR = '1' THEN
                                    WIP    <= '0';
                                    WEL    <= '0';
                                    WREN_V <= '0';
                                    P_ERR  <= '0';
                                    E_ERR  <= '0';
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(PDONE) THEN
                        EndIRPP;
                    END IF;

                WHEN PGM_NV_DLR_DATA =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF data_cnt <= 7 THEN
                                DLRNV_in(7-data_cnt) <= IO3RESETNegIn;
                                DLRNV_in(6-data_cnt) <= WPNegIn;
                                DLRNV_in(5-data_cnt) <= SOIn;
                                DLRNV_in(4-data_cnt) <= SIIn;
                            END IF;
                            data_cnt := data_cnt + 4;
                        ELSE
                            IF data_cnt <= 7 THEN
                                DLRNV_in(7-data_cnt) <= SIIn;
                            END IF;
                            data_cnt := data_cnt + 1;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) AND data_cnt = 8 THEN
                        WIP <= '1';
                        PSTART <= '1', '0' AFTER 1 ns;
                    END IF;

                WHEN PGM_NV_DLR =>
                    DLRNV_ACT <= '1';
                    IF falling_edge(CSNeg_ipd) THEN
                        opcode_cnt := 0;
                    END IF;
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := IO3RESETNegIn;
                                opcode(6-opcode_cnt) := WPNegIn;
                                opcode(5-opcode_cnt) := SOIn;
                                opcode(4-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 4;
                        ELSE
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 1;
                        END IF;
                        IF opcode_cnt = 8 THEN
                            Instruct <= NONE;
                            IF opcode = "00000101" THEN -- 05h
                                Instruct <= RDSR1;
                            ELSIF opcode = "00000111" THEN -- 07h
                                Instruct <= RDSR2;
                            ELSIF opcode = "00110101" THEN -- 35h
                                Instruct <= RDCR1;
                            ELSIF opcode = "00010101" THEN -- 15h
                                Instruct <= RDCR2;
                            ELSIF opcode = "00110011" THEN -- 33h
                                Instruct <= RDCR3;
                            ELSIF opcode = "01100101" THEN -- 65h
                                Instruct <= RDAR;
                            ELSIF opcode = "00110000" THEN -- 30h
                                Instruct <= CLSR;
                            ELSIF opcode = "01100110" THEN -- 66h
                                Instruct <= RSTEN;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) THEN
                        IF opcode_cnt = 8 THEN
                            IF Instruct = CLSR THEN
                                IF P_ERR = '1' THEN
                                    WIP    <= '0';
                                    WEL    <= '0';
                                    WREN_V <= '0';
                                    P_ERR  <= '0';
                                    E_ERR  <= '0';
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(PDONE) THEN
                        WIP   <= '0';
                        WEL   <= '0';
                        DLRNV := DLRNV_in;
                        DLRV  := DLRNV;
                        DLRNV_ACT <= '0';
                        DLRNV_programmed <= '1';
                    END IF;

                WHEN DLRV_WRITE_DATA =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF data_cnt <= 7 THEN
                                DLRNV_in(7-data_cnt) <= IO3RESETNegIn;
                                DLRNV_in(6-data_cnt) <= WPNegIn;
                                DLRNV_in(5-data_cnt) <= SOIn;
                                DLRNV_in(4-data_cnt) <= SIIn;
                            END IF;
                            data_cnt := data_cnt + 4;
                        ELSE
                            IF data_cnt <= 7 THEN
                                DLRNV_in(7-data_cnt) <= SIIn;
                            END IF;
                            data_cnt := data_cnt + 1;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) AND data_cnt = 8 THEN
                        WEL <= '1';
                        DLRV := DLRV_in;
                    END IF;

                WHEN SET_PNTR_PROT_ADDR =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF (Instruct = SPRP AND ADS = '0') THEN
                                PRPR_in(23-addr_cnt) <= IO3RESETNegIn;
                                PRPR_in(22-addr_cnt) <= WPNegIn;
                                PRPR_in(21-addr_cnt) <= SOIn;
                                PRPR_in(20-addr_cnt) <= SIIn;
                                addr_cnt := addr_cnt + 4;
                            ELSIF Instruct = SPRP4 OR (Instruct = SPRP AND ADS = '1') THEN
                                PRPR_in(31-addr_cnt) <= IO3RESETNegIn;
                                PRPR_in(30-addr_cnt) <= WPNegIn;
                                PRPR_in(29-addr_cnt) <= SOIn;
                                PRPR_in(28-addr_cnt) <= SIIn;
                                addr_cnt := addr_cnt + 4;
                            END IF;
                        ELSE
                            IF (Instruct = SPRP AND ADS = '0') THEN
                                PRPR_in(23-addr_cnt) <= SIIn;
                                addr_cnt := addr_cnt + 1;
                            ELSIF Instruct = SPRP4 OR (Instruct = SPRP AND ADS = '1') THEN
                                PRPR_in(31-addr_cnt) <= SIIn;
                                addr_cnt := addr_cnt + 1;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) THEN
                        IF (QPI = '1' AND
                        ((Instruct = SPRP4 AND addr_cnt = 8) OR
                        (Instruct = SPRP AND ((ADS = '0' AND addr_cnt = 6) OR (ADS = '1' AND addr_cnt = 8))))) OR
                        (QPI = '0' AND
                        ((Instruct = SPRP4 AND addr_cnt = 32) OR
                        (Instruct = SPRP AND ((ADS = '0' AND addr_cnt = 24) OR (ADS = '1' AND addr_cnt = 32))))) THEN
                            WIP <= '1';
                            WSTART_NV <= '1', '0' AFTER 1 ns;
                        END IF;
                    END IF;

                WHEN SET_PNTR_PROT =>
                    SET_PNTR_PROT_ACT <= '1';
                    IF falling_edge(CSNeg_ipd) THEN
                        opcode_cnt := 0;
                    END IF;
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := IO3RESETNegIn;
                                opcode(6-opcode_cnt) := WPNegIn;
                                opcode(5-opcode_cnt) := SOIn;
                                opcode(4-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 4;
                        ELSE
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 1;
                        END IF;
                        IF opcode_cnt = 8 THEN
                            Instruct <= NONE;
                            IF opcode = "00000101" THEN -- 05h
                                Instruct <= RDSR1;
                            ELSIF opcode = "00000111" THEN -- 07h
                                Instruct <= RDSR2;
                            ELSIF opcode = "00110101" THEN -- 35h
                                Instruct <= RDCR1;
                            ELSIF opcode = "00010101" THEN -- 15h
                                Instruct <= RDCR2;
                            ELSIF opcode = "00110011" THEN -- 33h
                                Instruct <= RDCR3;
                            ELSIF opcode = "01100101" THEN -- 65h
                                Instruct <= RDAR;
                            ELSIF opcode = "00110000" THEN -- 30h
                                Instruct <= CLSR;
                            ELSIF opcode = "01100110" THEN -- 66h
                                Instruct <= RSTEN;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) THEN
                        IF opcode_cnt = 8 THEN
                            IF Instruct = CLSR THEN
                                IF P_ERR = '1' OR E_ERR = '1' THEN
                                    WIP    <= '0';
                                    WEL    <= '0';
                                    WREN_V <= '0';
                                    P_ERR  <= '0';
                                    E_ERR  <= '0';
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(WDONE) THEN
                        EndSPRP;
                    END IF;

                WHEN PASSP_DATA_INPUT =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF byte_cnt <= 1 THEN
                                Password_reg_in(7-data_cnt + 8*byte_cnt) <= IO3RESETNegIn;
                                Password_reg_in(6-data_cnt + 8*byte_cnt) <= WPNegIn;
                                Password_reg_in(5-data_cnt + 8*byte_cnt) <= SOIn;
                                Password_reg_in(4-data_cnt + 8*byte_cnt) <= SIIn;
                            END IF;
                            data_cnt := data_cnt + 4;
                        ELSE
                            IF byte_cnt <= 7 THEN
                                Password_reg_in(7-data_cnt + 8*byte_cnt) <= SIIn;
                            END IF;
                            data_cnt := data_cnt + 1;
                        END IF;
                        IF data_cnt = 8 THEN
                            data_cnt := 0;
                            byte_cnt := byte_cnt + 1;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) AND data_cnt = 0 AND byte_cnt = 8 THEN
                        PASS_PGM_ACT <= '1';
                        WIP <= '1';
                        PSTART <= '1', '0' AFTER 1 ns;
                    END IF;

                WHEN PASS_PGM =>
                    IF falling_edge(CSNeg_ipd) THEN
                        opcode_cnt := 0;
                    END IF;
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := IO3RESETNegIn;
                                opcode(6-opcode_cnt) := WPNegIn;
                                opcode(5-opcode_cnt) := SOIn;
                                opcode(4-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 4;
                        ELSE
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 1;
                        END IF;
                        IF opcode_cnt = 8 THEN
                            Instruct <= NONE;
                            IF opcode = "00000101" THEN -- 05h
                                Instruct <= RDSR1;
                            ELSIF opcode = "00000111" THEN -- 07h
                                Instruct <= RDSR2;
                            ELSIF opcode = "00110101" THEN -- 35h
                                Instruct <= RDCR1;
                            ELSIF opcode = "00010101" THEN -- 15h
                                Instruct <= RDCR2;
                            ELSIF opcode = "00110011" THEN -- 33h
                                Instruct <= RDCR3;
                            ELSIF opcode = "01100101" THEN -- 65h
                                Instruct <= RDAR;
                            ELSIF opcode = "00110000" THEN -- 30h
                                Instruct <= CLSR;
                            ELSIF opcode = "01100110" THEN -- 66h
                                Instruct <= RSTEN;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) THEN
                        IF opcode_cnt = 8 THEN
                            IF Instruct = CLSR THEN
                                IF P_ERR = '1' THEN
                                    WIP    <= '0';
                                    WEL    <= '0';
                                    WREN_V <= '0';
                                    P_ERR  <= '0';
                                    E_ERR  <= '0';
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(PDONE) THEN
                        EndPassProgramming;
                    END IF;

                WHEN PASSU_DATA_INPUT =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF byte_cnt <= 1 THEN
                                Password_regU_in(7-data_cnt + 8*byte_cnt) <= IO3RESETNegIn;
                                Password_regU_in(6-data_cnt + 8*byte_cnt) <= WPNegIn;
                                Password_regU_in(5-data_cnt + 8*byte_cnt) <= SOIn;
                                Password_regU_in(4-data_cnt + 8*byte_cnt) <= SIIn;
                            END IF;
                            data_cnt := data_cnt + 4;
                        ELSE
                            IF byte_cnt <= 1 THEN
                                Password_regU_in(7-data_cnt + 8*byte_cnt) <= SIIn;
                            END IF;
                            data_cnt := data_cnt + 1;
                        END IF;
                        IF data_cnt = 8 THEN
                            data_cnt := 0;
                            byte_cnt := byte_cnt + 1;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) AND data_cnt = 0 AND byte_cnt = 8 THEN
                        WIP <= '1';
                        PASSULCK_in <= '1';
                        IF Password_regU_in /= Password_reg THEN
                            TBPROT <= '1';
                        ELSIF PWDMLB = '0' THEN
                            NVLOCK := '1';
                            SECRRP := '1';
                        END IF;
                    END IF;

                WHEN PASS_ULCK =>
                    IF falling_edge(CSNeg_ipd) THEN
                        opcode_cnt := 0;
                    END IF;
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := IO3RESETNegIn;
                                opcode(6-opcode_cnt) := WPNegIn;
                                opcode(5-opcode_cnt) := SOIn;
                                opcode(4-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 4;
                        ELSE
                            IF opcode_cnt < 8 THEN
                                opcode(7-opcode_cnt) := SIIn;
                            END IF;
                            opcode_cnt := opcode_cnt + 1;
                        END IF;
                        IF opcode_cnt = 8 THEN
                            Instruct <= NONE;
                            IF opcode = "00000101" THEN -- 05h
                                Instruct <= RDSR1;
                            ELSIF opcode = "00000111" THEN -- 07h
                                Instruct <= RDSR2;
                            ELSIF opcode = "00110101" THEN -- 35h
                                Instruct <= RDCR1;
                            ELSIF opcode = "00010101" THEN -- 15h
                                Instruct <= RDCR2;
                            ELSIF opcode = "00110011" THEN -- 33h
                                Instruct <= RDCR3;
                            ELSIF opcode = "01100101" THEN -- 65h
                                Instruct <= RDAR;
                            ELSIF opcode = "00110000" THEN -- 30h
                                Instruct <= CLSR;
                            ELSIF opcode = "01100110" THEN -- 66h
                                Instruct <= RSTEN;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) THEN
                        IF opcode_cnt = 8 THEN
                            IF Instruct = CLSR THEN
                                IF P_ERR = '1' THEN
                                    WIP    <= '0';
                                    WEL    <= '0';
                                    WREN_V <= '0';
                                    P_ERR  <= '0';
                                    E_ERR  <= '0';
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(PASSULCK_out) THEN
                        PASSULCK_in <= '0';
                        WIP    <= '0';
                        WEL    <= '0';
                    END IF;

                WHEN IBL_LOCK =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF (Instruct = IBL AND ADS = '0') THEN
                                Address_in(4*addr_cnt)   := IO3RESETNegIn;
                                Address_in(4*addr_cnt+1) := WPNegIn;
                                Address_in(4*addr_cnt+2) := SOIn;
                                Address_in(4*addr_cnt+3) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 6 THEN
                                    FOR I IN 23 DOWNTO 0 LOOP
                                        addr_bytes(23-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            ELSIF Instruct = IBL4 OR (Instruct = IBL AND ADS = '1') THEN
                                Address_in(4*addr_cnt)   := IO3RESETNegIn;
                                Address_in(4*addr_cnt+1) := WPNegIn;
                                Address_in(4*addr_cnt+2) := SOIn;
                                Address_in(4*addr_cnt+3) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 8 THEN
                                    FOR I IN 31 DOWNTO 0 LOOP
                                        addr_bytes(31-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            END IF;
                        ELSE
                            IF (Instruct = IBL AND ADS = '0') THEN
                                Address_in(addr_cnt) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 24 THEN
                                    FOR I IN 23 DOWNTO 0 LOOP
                                        addr_bytes(23-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            ELSIF Instruct = IBL4 OR (Instruct = IBL AND ADS = '1') THEN
                                Address_in(addr_cnt) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 32 THEN
                                    FOR I IN 31 DOWNTO 0 LOOP
                                        addr_bytes(31-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) THEN
                        IF (QPI = '1' AND
                        ((Instruct = IBL4 AND addr_cnt = 8) OR
                        (Instruct = IBL AND ((ADS = '0' AND addr_cnt = 6) OR (ADS = '1' AND addr_cnt = 8))))) OR
                        (QPI = '0' AND
                        ((Instruct = IBL4 AND addr_cnt = 32) OR
                        (Instruct = IBL AND ((ADS = '0' AND addr_cnt = 24) OR (ADS = '1' AND addr_cnt = 32))))) THEN
                            sect := Address/(SecSize+1);
                            blk := sect/16;
                            IF blk = 0 OR blk = BlockNum THEN
                                IBL_Sec_Prot(sect) <= '0';
                            ELSE
                                FOR i IN 0 TO 15 LOOP
                                    IBL_Sec_Prot(blk*16 + i) <= '0';
                                END LOOP;
                            END IF;
                        END IF;
                    END IF;

                WHEN IBL_UNLOCK =>
                    IF rising_edge(SCK_ipd) AND CSNeg_ipd = '0' THEN
                        IF QPI = '1' THEN
                            IF (Instruct = IBUL AND ADS = '0') THEN
                                Address_in(4*addr_cnt)   := IO3RESETNegIn;
                                Address_in(4*addr_cnt+1) := WPNegIn;
                                Address_in(4*addr_cnt+2) := SOIn;
                                Address_in(4*addr_cnt+3) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 6 THEN
                                    FOR I IN 23 DOWNTO 0 LOOP
                                        addr_bytes(23-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            ELSIF Instruct = IBUL4 OR (Instruct = IBUL AND ADS = '1') THEN
                                Address_in(4*addr_cnt)   := IO3RESETNegIn;
                                Address_in(4*addr_cnt+1) := WPNegIn;
                                Address_in(4*addr_cnt+2) := SOIn;
                                Address_in(4*addr_cnt+3) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 8 THEN
                                    FOR I IN 31 DOWNTO 0 LOOP
                                        addr_bytes(31-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            END IF;
                        ELSE
                            IF (Instruct = IBUL AND ADS = '0') THEN
                                Address_in(addr_cnt) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 24 THEN
                                    FOR I IN 23 DOWNTO 0 LOOP
                                        addr_bytes(23-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            ELSIF Instruct = IBUL4 OR (Instruct = IBUL AND ADS = '1') THEN
                                Address_in(addr_cnt) := SIIn;
                                addr_cnt := addr_cnt + 1;
                                IF addr_cnt = 32 THEN
                                    FOR I IN 31 DOWNTO 0 LOOP
                                        addr_bytes(31-i) := Address_in(i);
                                    END LOOP;
                                    addr_bytes(31 DOWNTO 24) := "00000000";
                                    Address := to_nat(addr_bytes);
                                END IF;
                            END IF;
                        END IF;
                    END IF;
                    IF rising_edge(CSNeg_ipd) THEN
                        IF (QPI = '1' AND
                        ((Instruct = IBUL4 AND addr_cnt = 8) OR
                        (Instruct = IBUL AND ((ADS = '0' AND addr_cnt = 6) OR (ADS = '1' AND addr_cnt = 8))))) OR
                        (QPI = '0' AND
                        ((Instruct = IBUL4 AND addr_cnt = 32) OR
                        (Instruct = IBUL AND ((ADS = '0' AND addr_cnt = 24) OR (ADS = '1' AND addr_cnt = 32))))) THEN
                            sect := Address/(SecSize+1);
                            blk := sect/16;
                            IF blk = 0 OR blk = BlockNum THEN
                                IBL_Sec_Prot(sect) <= '1';
                            ELSE
                                FOR i IN 0 TO 15 LOOP
                                    IBL_Sec_Prot(blk*16 + i) <= '1';
                                END LOOP;
                            END IF;
                        END IF;
                    END IF;
            END CASE;

            IF falling_edge(CSNeg_ipd) THEN
                normal_rd <= false;
                fast_rd   <= true;
                ddr_rd    <= false;
                reg_rd    <= false;
                opcode_cnt := 0;
                addr_cnt   := 0;
                dummy_cnt  := 0;
                mode_cnt   := 0;
                data_cnt   := 0;
                bit_cnt    := 0;
                read_cnt   := 0;
            END IF;

            CR1_V(7) <= PS OR ES; -- SUS

            IF rising_edge(QEN_out) THEN
                QEN_in <= '0';
            END IF;
            IF rising_edge(QEXN_out) THEN
                QEXN_in <= '0';
            END IF;
        END IF; -- IF PoweredUp = '1' THEN

        --Output Disable Control
        IF (CSNeg_ipd = '1') THEN
            IF (Instruct /= WRR AND Instruct /= WRENV) AND
            mode_byte(7 DOWNTO 4) /= "1010" THEN
                Instruct <= NONE;
            END IF;

            SIOut_zd        <= 'Z';
            RESETNegOut_zd  <= 'Z';
            WPNegOut_zd     <= 'Z';
            SOut_zd         <= 'Z';
            IO3RESETNegOut_zd <= 'Z';

        END IF;

        address_cnt <= addr_cnt;

    END PROCESS Functional;

    ---------------------------------------------------------------------------
    -- SFDP_CFI Process  ------------------------------------------------------
    SFDPPreload: PROCESS
    BEGIN
        -----------------------------------------------------------------------
        --SFDP Header
        -----------------------------------------------------------------------
        SFDP_array(16#0000#) := 16#53#;
        SFDP_array(16#0001#) := 16#46#;
        SFDP_array(16#0002#) := 16#44#;
        SFDP_array(16#0003#) := 16#50#;
        SFDP_array(16#0004#) := 16#06#;
        SFDP_array(16#0005#) := 16#01#;
        SFDP_array(16#0006#) := 16#01#;
        SFDP_array(16#0007#) := 16#FF#;
        SFDP_array(16#0008#) := 16#00#;
        SFDP_array(16#0009#) := 16#06#;
        SFDP_array(16#000A#) := 16#01#;
        SFDP_array(16#000B#) := 16#10#;
        SFDP_array(16#000C#) := 16#00#;
        SFDP_array(16#000D#) := 16#03#;
        SFDP_array(16#000E#) := 16#00#;
        SFDP_array(16#000F#) := 16#FF#;
        SFDP_array(16#0010#) := 16#84#;
        SFDP_array(16#0011#) := 16#00#;
        SFDP_array(16#0012#) := 16#01#;
        SFDP_array(16#0013#) := 16#02#;
        SFDP_array(16#0014#) := 16#40#;
        SFDP_array(16#0015#) := 16#03#;
        SFDP_array(16#0016#) := 16#00#;
        SFDP_array(16#0017#) := 16#FF#;
        FOR I IN 16#0018# TO 16#2FF# LOOP
           SFDP_array(I) :=16#FF#; -- undefined space
        END LOOP;
        -- Basic SPI Flash Parameter, JEDEC SFDP Rev B
        SFDP_array(16#0300#) := 16#E5#;
        SFDP_array(16#0301#) := 16#20#;
        SFDP_array(16#0302#) := 16#FB#;
        SFDP_array(16#0303#) := 16#FF#;
        SFDP_array(16#0304#) := 16#FF#;
        SFDP_array(16#0305#) := 16#FF#;
        SFDP_array(16#0306#) := 16#FF#;
        SFDP_array(16#0307#) := 16#0F#;
        SFDP_array(16#0308#) := 16#48#;
        SFDP_array(16#0309#) := 16#EB#;
        SFDP_array(16#030A#) := 16#08#;
        SFDP_array(16#030B#) := 16#6B#;
        SFDP_array(16#030C#) := 16#08#;
        SFDP_array(16#030D#) := 16#3B#;
        SFDP_array(16#030E#) := 16#88#;
        SFDP_array(16#030F#) := 16#BB#;
        SFDP_array(16#0310#) := 16#FE#;
        SFDP_array(16#0311#) := 16#FF#;
        SFDP_array(16#0312#) := 16#FF#;
        SFDP_array(16#0313#) := 16#FF#;
        SFDP_array(16#0314#) := 16#FF#;
        SFDP_array(16#0315#) := 16#FF#;
        SFDP_array(16#0316#) := 16#FF#;
        SFDP_array(16#0317#) := 16#FF#;
        SFDP_array(16#0318#) := 16#FF#;
        SFDP_array(16#0319#) := 16#FF#;
        SFDP_array(16#031A#) := 16#48#;
        SFDP_array(16#031B#) := 16#EB#;
        SFDP_array(16#031C#) := 16#0C#;
        SFDP_array(16#031D#) := 16#20#;
        SFDP_array(16#031E#) := 16#0F#;
        SFDP_array(16#031F#) := 16#52#;
        SFDP_array(16#0320#) := 16#10#;
        SFDP_array(16#0321#) := 16#D8#;
        SFDP_array(16#0322#) := 16#00#;
        SFDP_array(16#0323#) := 16#FF#;
        SFDP_array(16#0324#) := 16#21#;
        SFDP_array(16#0325#) := 16#5A#;
        SFDP_array(16#0326#) := 16#C1#;
        SFDP_array(16#0327#) := 16#FE#;
        SFDP_array(16#0328#) := 16#81#;
        SFDP_array(16#0329#) := 16#E4#;
        SFDP_array(16#032A#) := 16#29#;
        SFDP_array(16#032B#) := 16#E2#;
        SFDP_array(16#032C#) := 16#CC#;
        SFDP_array(16#032D#) := 16#83#;
        SFDP_array(16#032E#) := 16#18#;
        SFDP_array(16#032F#) := 16#44#;
        SFDP_array(16#0330#) := 16#7A#;
        SFDP_array(16#0331#) := 16#75#;
        SFDP_array(16#0332#) := 16#7A#;
        SFDP_array(16#0333#) := 16#75#;
        SFDP_array(16#0334#) := 16#F7#;
        SFDP_array(16#0335#) := 16#A2#;
        SFDP_array(16#0336#) := 16#D5#;
        SFDP_array(16#0337#) := 16#5C#;
        SFDP_array(16#0338#) := 16#22#;
        SFDP_array(16#0339#) := 16#F6#;
        SFDP_array(16#033A#) := 16#5D#;
        SFDP_array(16#033B#) := 16#FF#;
        SFDP_array(16#033C#) := 16#E8#;
        SFDP_array(16#033D#) := 16#50#;
        SFDP_array(16#033E#) := 16#F8#;
        SFDP_array(16#033F#) := 16#A1#;
        -- 4-byte Address Instruction, JEDEC SFDP Rev B
        SFDP_array(16#0340#) := 16#FB#;
        SFDP_array(16#0341#) := 16#8E#;
        SFDP_array(16#0342#) := 16#F3#;
        SFDP_array(16#0343#) := 16#FF#;
        SFDP_array(16#0344#) := 16#21#;
        SFDP_array(16#0345#) := 16#52#;
        SFDP_array(16#0346#) := 16#DC#;
        SFDP_array(16#0347#) := 16#FF#;
        --Undefined space
        FOR I IN 16#0348# TO 16#05FF# LOOP
           SFDP_array(I) :=16#FF#;
        END LOOP;

        WAIT;

    END PROCESS SFDPPreload;

    Protect : PROCESS(PoweredUp, TBPROT, CMP)
    BEGIN
        IF CMP = '0' THEN
            Legacy_Sec_Prot <= (OTHERS => '0');
            CASE SR1_V(5 DOWNTO 2) IS
                WHEN "0000" =>

                WHEN "0001" =>
                    IF TBPROT = '0' THEN
                        Legacy_Sec_Prot(SecNum DOWNTO (SecNum-15))
                                                    <= (OTHERS => '1');
                    ELSE
                        Legacy_Sec_Prot(15 DOWNTO 0) <= (OTHERS => '1');
                    END IF;

                WHEN "0010" =>
                    IF TBPROT = '0' THEN
                        Legacy_Sec_Prot(SecNum DOWNTO (SecNum-31))
                                                    <= (OTHERS => '1');
                    ELSE
                        Legacy_Sec_Prot(31 DOWNTO 0) <= (OTHERS => '1');
                    END IF;

                WHEN "0011" =>
                    IF TBPROT = '0' THEN
                        Legacy_Sec_Prot(SecNum DOWNTO (SecNum-63))
                                                    <= (OTHERS => '1');
                    ELSE
                        Legacy_Sec_Prot(63 DOWNTO 0) <= (OTHERS => '1');
                    END IF;

                WHEN "0100" =>
                    IF TBPROT = '0' THEN
                        Legacy_Sec_Prot(SecNum DOWNTO (SecNum-127))
                                                    <= (OTHERS => '1');
                    ELSE
                        Legacy_Sec_Prot(127 DOWNTO 0) <= (OTHERS => '1');
                    END IF;

                WHEN "0101" =>
                    IF TBPROT = '0' THEN
                        Legacy_Sec_Prot(SecNum DOWNTO (SecNum-255))
                                                    <= (OTHERS => '1');
                    ELSE
                        Legacy_Sec_Prot(255 DOWNTO 0) <= (OTHERS => '1');
                    END IF;

                WHEN "0110" =>
                    IF TBPROT = '0' THEN
                        Legacy_Sec_Prot(SecNum DOWNTO (SecNum-511))
                                                    <= (OTHERS => '1');
                    ELSE
                        Legacy_Sec_Prot(511 DOWNTO 0) <= (OTHERS => '1');
                    END IF;

                WHEN "0111" =>
                    IF TBPROT = '0' THEN
                        Legacy_Sec_Prot(SecNum DOWNTO (SecNum-1023))
                                                    <= (OTHERS => '1');
                    ELSE
                        Legacy_Sec_Prot(1023 DOWNTO 0) <= (OTHERS => '1');
                    END IF;

                WHEN "1000" =>
                    IF TBPROT = '0' THEN
                        Legacy_Sec_Prot(SecNum DOWNTO (SecNum-2047))
                                                    <= (OTHERS => '1');
                    ELSE
                        Legacy_Sec_Prot(2047 DOWNTO 0) <= (OTHERS => '1');
                    END IF;

                WHEN "1001" =>
                    IF TBPROT = '0' THEN
                        Legacy_Sec_Prot(SecNum DOWNTO (SecNum-4095))
                                                    <= (OTHERS => '1');
                    ELSE
                        Legacy_Sec_Prot(4095 DOWNTO 0) <= (OTHERS => '1');
                    END IF;

                WHEN OTHERS =>
                    Legacy_Sec_Prot <= (OTHERS => '1');
            END CASE;
        ELSE -- CMP=1
            Legacy_Sec_Prot <= (OTHERS => '1');
            CASE SR1_V(5 DOWNTO 2) IS
                WHEN "0000" =>

                WHEN "0001" =>
                    IF TBPROT = '0' THEN
                        Legacy_Sec_Prot(SecNum DOWNTO (SecNum-15))
                                                    <= (OTHERS => '0');
                    ELSE
                        Legacy_Sec_Prot(15 DOWNTO 0) <= (OTHERS => '0');
                    END IF;

                WHEN "0010" =>
                    IF TBPROT = '0' THEN
                        Legacy_Sec_Prot(SecNum DOWNTO (SecNum-31))
                                                    <= (OTHERS => '0');
                    ELSE
                        Legacy_Sec_Prot(31 DOWNTO 0) <= (OTHERS => '0');
                    END IF;

                WHEN "0011" =>
                    IF TBPROT = '0' THEN
                        Legacy_Sec_Prot(SecNum DOWNTO (SecNum-63))
                                                    <= (OTHERS => '0');
                    ELSE
                        Legacy_Sec_Prot(63 DOWNTO 0) <= (OTHERS => '0');
                    END IF;

                WHEN "0100" =>
                    IF TBPROT = '0' THEN
                        Legacy_Sec_Prot(SecNum DOWNTO (SecNum-127))
                                                    <= (OTHERS => '0');
                    ELSE
                        Legacy_Sec_Prot(127 DOWNTO 0) <= (OTHERS => '0');
                    END IF;

                WHEN "0101" =>
                    IF TBPROT = '0' THEN
                        Legacy_Sec_Prot(SecNum DOWNTO (SecNum-255))
                                                    <= (OTHERS => '0');
                    ELSE
                        Legacy_Sec_Prot(255 DOWNTO 0) <= (OTHERS => '0');
                    END IF;

                WHEN "0110" =>
                    IF TBPROT = '0' THEN
                        Legacy_Sec_Prot(SecNum DOWNTO (SecNum-511))
                                                    <= (OTHERS => '0');
                    ELSE
                        Legacy_Sec_Prot(511 DOWNTO 0) <= (OTHERS => '0');
                    END IF;

                WHEN "0111" =>
                    IF TBPROT = '0' THEN
                        Legacy_Sec_Prot(SecNum DOWNTO (SecNum-1023))
                                                    <= (OTHERS => '0');
                    ELSE
                        Legacy_Sec_Prot(1023 DOWNTO 0) <= (OTHERS => '0');
                    END IF;

                WHEN "1000" =>
                    IF TBPROT = '0' THEN
                        Legacy_Sec_Prot(SecNum DOWNTO (SecNum-2047))
                                                    <= (OTHERS => '0');
                    ELSE
                        Legacy_Sec_Prot(2047 DOWNTO 0) <= (OTHERS => '0');
                    END IF;

                WHEN "1001" =>
                    IF TBPROT = '0' THEN
                        Legacy_Sec_Prot(SecNum DOWNTO (SecNum-4095))
                                                    <= (OTHERS => '0');
                    ELSE
                        Legacy_Sec_Prot(4095 DOWNTO 0) <= (OTHERS => '0');
                    END IF;

                WHEN OTHERS =>
                    Legacy_Sec_Prot <= (OTHERS => '0');
            END CASE;
        END IF;
    END PROCESS Protect;

    PointerProtect : PROCESS(WPS, Legacy_Sec_Prot, PRP_Sec_Prot, IBL_Sec_Prot)
    BEGIN
        Block_Prot := (OTHERS => '0');
        HalfBlock_Prot := (OTHERS => '0');
        IF WPS = '0' THEN -- Legacy block protect active
            IF PRPR(10) = '0' THEN -- Enable Pointer Region Protection
                FOR i IN 0 TO SecNum LOOP
                    Sec_Prot(i) := PRP_Sec_Prot(i) OR Legacy_Sec_Prot(i);
                    IF Sec_Prot(i) = '1' THEN
                        Block_Prot(i/16) := '1';
                        HalfBlock_Prot(i/8) := '1';
                    END IF;
                END LOOP;
            ELSE
                FOR i IN 0 TO SecNum LOOP
                    Sec_Prot(i) := Legacy_Sec_Prot(i);
                    IF Sec_Prot(i) = '1' THEN
                        Block_Prot(i/16) := '1';
                        HalfBlock_Prot(i/8) := '1';
                    END IF;
                END LOOP;
            END IF;
        ELSE -- WPS=1 Individual Block Lock active
            IF PRPR(10) = '0' THEN -- Enable Pointer Region Protection
                FOR i IN 0 TO SecNum LOOP
                    Sec_Prot(i) := PRP_Sec_Prot(i) OR NOT IBL_Sec_Prot(i);
                    IF Sec_Prot(i) = '1' THEN
                        Block_Prot(i/16) := '1';
                        HalfBlock_Prot(i/8) := '1';
                    END IF;
                END LOOP;
            ELSE
                FOR i IN 0 TO SecNum LOOP
                    Sec_Prot(i) := NOT IBL_Sec_Prot(i);
                    IF Sec_Prot(i) = '1' THEN
                        Block_Prot(i/16) := '1';
                        HalfBlock_Prot(i/8) := '1';
                    END IF;
                END LOOP;
            END IF;
        END IF;
    END PROCESS PointerProtect;

    PRPR_Prot : PROCESS(PRPR)
    BEGIN
        IF PRPR(10) = '0' THEN -- Enable Pointer Region Protection
            IF PRPR(11) = '1' THEN -- Protect All Sectors
                PRP_Sec_Prot <= (OTHERS => '1');
            ELSE
                sect := to_nat(PRPR(23 DOWNTO 12));
                IF PRPR(9) = '0' THEN -- Bottom unprotected
                    PRP_Sec_Prot <= (OTHERS => '1');
                    FOR i IN 0 TO SecNum LOOP
                        IF i <= sect THEN
                            PRP_Sec_Prot(i) <= '0';
                        END IF;
                    END LOOP;
                ELSE  -- Bottom protected
                    PRP_Sec_Prot <= (OTHERS => '0');
                    FOR i IN 0 TO SecNum LOOP
                        IF i < sect THEN
                            PRP_Sec_Prot(i) <= '1';
                        END IF;
                    END LOOP;
                END IF;
            END IF;
        END IF;
    END PROCESS PRPR_Prot;

    WP_PULL_UP : PROCESS(WPNegIn)
    BEGIN
        IF (QUAD = '0') THEN
            IF (WPNegIn = 'Z') THEN
                WPNeg_pullup <= '1';
            ELSE
                WPNeg_pullup <= WPNegIn;
            END IF;
        END IF;
    END PROCESS WP_PULL_UP;

    RST_PULL_UP : PROCESS(RESETNeg)
    BEGIN
        IF (RESETNeg = 'Z') THEN
            RESETNeg_pullup <= '1';
        ELSE
            RESETNeg_pullup <= RESETNeg;
        END IF;
    END PROCESS RST_PULL_UP;

    IO3_RST_PULL_UP : PROCESS(IO3RESETNeg)
    BEGIN
        IF (IO3RESETNeg = 'Z') THEN
            IO3RESETNeg_pullup <= '1';
        ELSE
            IO3RESETNeg_pullup <= IO3RESETNeg;
        END IF;
    END PROCESS IO3_RST_PULL_UP;

    ---------------------------------------------------------------------------
    ---- File Read Section - Preload Control
    ---------------------------------------------------------------------------
    MemPreload : PROCESS

        -- text file input variables
        FILE mem_file     : text  is  mem_file_name;
        FILE secr_file    : text  is  secr_file_name;
        VARIABLE ind      : NATURAL RANGE 0 TO AddrRANGE := 0;
        VARIABLE S_ind    : NATURAL RANGE 0 TO SecNum:= 0;
        VARIABLE index    : NATURAL RANGE 0 TO SecSize:=0;
        VARIABLE secr_ind : NATURAL RANGE 16#000# TO 16#3FF# := 16#000#;
        VARIABLE buf      : line;
        VARIABLE reported : NATURAL;

    BEGIN
    ---------------------------------------------------------------------------
    --s25fl256l memory preload file format
    --------------------------------------
    ---------------------------------------------------------------------------
    --   /       - comment
    --   @aaaaaa - <aaaaaa> stands for address
    --   dd      - <dd> is byte to be written at Mem(aaaaaa++)
    --             (aaaaaa is incremented at every load)
    --   only first 1-7 columns are loaded. NO empty lines !!!!!!!!!!!!!!!!
    ---------------------------------------------------------------------------
         -- memory preload
        IF (mem_file_name /= "none" AND UserPreload ) THEN
            ind := 0;
            reported := 0;
            Mem := (OTHERS => MaxData);
            WHILE (not ENDFILE (mem_file)) LOOP
                READLINE (mem_file, buf);
                IF buf(1) = '/' THEN --comment
                    NEXT;
                ELSIF buf(1) = '@' THEN --address
                    ind := h(buf(2 to 7));
                ELSE
                    IF ind <= AddrRANGE THEN
                        Mem(ind) := h(buf(1 to 2));
                        IF ind < AddrRANGE THEN
                            ind := ind + 1;
                        END IF;
                    ELSIF reported = 0 THEN
                        REPORT " Memory address out of range"
                        SEVERITY warning;
                        reported := 1;
                    END IF;
                END IF;
            END LOOP;
        END IF;

    ---------------------------------------------------------------------------
    --s25fl256l_secr memory preload file format
    ---------------------------------------------------------------------------
    --   /       - comment
    --   @aaa - <aaa> stands for address
    --   dd      - <dd> is byte to be written at SECRMem(aaa++)
    --             (aaa is incremented at every load)
    --   only first 1-4 columns are loaded. NO empty lines !!!!!!!!!!!!!!!!
    ---------------------------------------------------------------------------

         -- memory preload
        IF (secr_file_name /= "none" AND UserPreload) THEN
            secr_ind := 16#000#;
            SECRMem := (OTHERS => MaxData);
            WHILE (NOT ENDFILE (secr_file)) LOOP
                READLINE (secr_file, buf);
                IF buf(1) = '/' THEN
                    NEXT;
                ELSIF buf(1) = '@' THEN
                    IF secr_ind > 16#3FF# OR secr_ind < 16#000# THEN
                        ASSERT false
                            REPORT "Given preload address is out of" &
                                   "SECR address range"
                            SEVERITY WARNING;
                    ELSE
                        secr_ind := h(buf(2 to 4)); --address
                    END IF;
                ELSE
                    SECRMem(secr_ind) := h(buf(1 to 2));
                    secr_ind := secr_ind + 1;
                END IF;
            END LOOP;
        END IF;

        WAIT;
    END PROCESS MemPreload;

    ----------------------------------------------------------------------------
    -- Path Delay Section
    ----------------------------------------------------------------------------

    S_Out_PathDelay_Gen : PROCESS(SOut_zd)

            VARIABLE SO_GlitchData : VitalGlitchDataType;
        BEGIN
            VitalPathDelay01Z (
                OutSignal       => SOut,
                OutSignalName   => "SO",
                OutTemp         => SOut_zd,
                Mode            => VitalTransport,
                GlitchData      => SO_GlitchData,
                Paths           => (
                    0 => (InputChangeTime => SCK_ipd'LAST_EVENT,
                        PathDelay   => VitalExtendtofillDelay(tpd_SCK_SO),
                        PathCondition   => true),
                    1 => (InputChangeTime => CSNeg_ipd'LAST_EVENT,
                        PathDelay       => tpd_CSNeg_SO_RST_QUAD_EQ_0,
                        PathCondition   => CSNeg_ipd = '1' AND NOT RST_QUAD),
                    2 => (InputChangeTime => CSNeg_ipd'LAST_EVENT,
                        PathDelay       => tpd_CSNeg_SO_RST_QUAD_EQ_1,
                        PathCondition   => CSNeg_ipd = '1' AND RST_QUAD)
                )
            );
        END PROCESS;

    SI_Out_PathDelay : PROCESS(SIOut_zd)

            VARIABLE SI_GlitchData : VitalGlitchDataType;
        BEGIN
            VitalPathDelay01Z (
                OutSignal       => SIOut,
                OutSignalName   => "SI",
                OutTemp         => SIOut_zd,
                Mode            => VitalTransport,
                GlitchData      => SI_GlitchData,
                Paths           => (
                    0 => (InputChangeTime => SCK_ipd'LAST_EVENT,
                        PathDelay   => VitalExtendtofillDelay(tpd_SCK_SO),
                        PathCondition   => true),
                    1 => (InputChangeTime => CSNeg_ipd'LAST_EVENT,
                        PathDelay       => tpd_CSNeg_SO_RST_QUAD_EQ_0,
                        PathCondition   => CSNeg_ipd = '1' AND NOT RST_QUAD),
                    2 => (InputChangeTime => CSNeg_ipd'LAST_EVENT,
                        PathDelay       => tpd_CSNeg_SO_RST_QUAD_EQ_1,
                        PathCondition   => CSNeg_ipd = '1' AND RST_QUAD)
                )
            );
        END PROCESS;

    RESET_Out_PathDelay : PROCESS(RESETNegOut_zd)

            VARIABLE WP_GlitchData : VitalGlitchDataType;
        BEGIN
            VitalPathDelay01Z (
                OutSignal       => RESETNegOut,
                OutSignalName   => "RESETNeg",
                OutTemp         => RESETNegOut_zd,
                Mode            => VitalTransport,
                GlitchData      => WP_GlitchData,
                Paths           => (
                    0 => (InputChangeTime => SCK_ipd'LAST_EVENT,
                        PathDelay => VitalExtendtofillDelay(tpd_SCK_SO),
                        PathCondition   => true),
                    1 => (InputChangeTime => CSNeg_ipd'LAST_EVENT,
                        PathDelay       => tpd_CSNeg_SO_RST_QUAD_EQ_0,
                        PathCondition   => CSNeg_ipd = '1' AND NOT RST_QUAD),
                    2 => (InputChangeTime => CSNeg_ipd'LAST_EVENT,
                        PathDelay       => tpd_CSNeg_SO_RST_QUAD_EQ_1,
                        PathCondition   => CSNeg_ipd = '1' AND RST_QUAD)
                )
            );
        END PROCESS;

    IO3_RESET_Out_PathDelay : PROCESS(IO3RESETNegOut_zd)

            VARIABLE WP_GlitchData : VitalGlitchDataType;
        BEGIN
            VitalPathDelay01Z (
                OutSignal       => IO3RESETNegOut,
                OutSignalName   => "IO3RESETNeg",
                OutTemp         => IO3RESETNegOut_zd,
                Mode            => VitalTransport,
                GlitchData      => WP_GlitchData,
                Paths           => (
                    0 => (InputChangeTime => SCK_ipd'LAST_EVENT,
                        PathDelay => VitalExtendtofillDelay(tpd_SCK_SO),
                        PathCondition   => true),
                    1 => (InputChangeTime => CSNeg_ipd'LAST_EVENT,
                        PathDelay       => tpd_CSNeg_SO_RST_QUAD_EQ_0,
                        PathCondition   => CSNeg_ipd = '1' AND NOT RST_QUAD),
                    2 => (InputChangeTime => CSNeg_ipd'LAST_EVENT,
                        PathDelay       => tpd_CSNeg_SO_RST_QUAD_EQ_1,
                        PathCondition   => CSNeg_ipd = '1' AND RST_QUAD)
                )
            );
        END PROCESS;

    WP_Out_PathDelay : PROCESS(WPNegOut_zd)

            VARIABLE WP_GlitchData : VitalGlitchDataType;
        BEGIN
            VitalPathDelay01Z (
                OutSignal       => WPNegOut,
                OutSignalName   => "WPNeg",
                OutTemp         => WPNegOut_zd,
                Mode            => VitalTransport,
                GlitchData      => WP_GlitchData,
                Paths           => (
                    0 => (InputChangeTime => SCK_ipd'LAST_EVENT,
                        PathDelay => VitalExtendtofillDelay(tpd_SCK_SO),
                        PathCondition   => true),
                    1 => (InputChangeTime => CSNeg_ipd'LAST_EVENT,
                        PathDelay       => tpd_CSNeg_SO_RST_QUAD_EQ_0,
                        PathCondition   => CSNeg_ipd = '1' AND NOT RST_QUAD),
                    2 => (InputChangeTime => CSNeg_ipd'LAST_EVENT,
                        PathDelay       => tpd_CSNeg_SO_RST_QUAD_EQ_1,
                        PathCondition   => CSNeg_ipd = '1' AND RST_QUAD)
                )
            );
        END PROCESS;

    END BLOCK behavior;
END vhdl_behavioral_static_memory_allocation;