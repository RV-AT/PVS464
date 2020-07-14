-------------------------------------------------------------------------------
--  File name : testbench_s25fl256l_vhdl.vhd
-------------------------------------------------------------------------------
--  Copyright (C) 2014 Spansion, LLC.
--
--  MODIFICATION HISTORY :
--
--  version:   |     author:     |   mod date:  |  changes made:
--    V1.0        M.Stojanovic      16 Feb 19     Initial release
--
-------------------------------------------------------------------------------
--  PART DESCRIPTION:
--
--  Description:
--             Generic test enviroment for verification of flash memory
--             VITAL models.
--
-------------------------------------------------------------------------------
--  Comments :
--      * For correct simulation, simulator resolution should be set to 1ps.
--
-------------------------------------------------------------------------------
--  Known Bugs:
--
-------------------------------------------------------------------------------
--  Notes:
--  Choose value for variable 'Clock_polarity' to select SPI mode
--    Clock_polarity <= '0'; for SPI mode: CPO L= 0, CPHA = 0
--    Clock_polarity <= '1'; for SPI mode: CPO L= 1, CPHA = 1
--  Set test environment - device protection mode
--    MODE <= DEFAULT_PROTECTION;
--    MODE <= PERSISTENT_PROTECTION;
--    MODE <= PASSWORD_PROTECTION;
-------------------------------------------------------------------------------
LIBRARY IEEE;
    USE IEEE.std_logic_1164.ALL;
    USE IEEE.VITAL_timing.ALL;
    USE IEEE.VITAL_primitives.ALL;
    USE STD.textio.ALL;

LIBRARY FMF;
    USE FMF.gen_utils.all;
    USE FMF.conversions.all;

LIBRARY work;
    USE work.spansion_tc_pkg.all;
-------------------------------------------------------------------------------
-- ENTITY DECLARATION
-------------------------------------------------------------------------------
ENTITY testbench_s25fl256l_vhdl IS

END testbench_s25fl256l_vhdl;
-------------------------------------------------------------------------------
-- ARCHITECTURE DECLARATION
-------------------------------------------------------------------------------

ARCHITECTURE vhdl_behavioral of testbench_s25fl256l_vhdl IS
    COMPONENT s25fl256l IS
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
        tdevice_RNS             : VitalDelayType := 100 us;  --tRS
        -- RESET# Low to CS# Low
        tdevice_RPH             : VitalDelayType := 100 us;   --tRPH
        -- CS# High before HW Reset (Quad mode and Reset Feature are enabled)
        -- Volatile registers write time
        tdevice_CS              : VitalDelayType := 50 ns;   --tRPH
        -- VDD (min) to CS# Low
        tdevice_PU              : VitalDelayType := 300 us;  --tPU
        -- Password Unlock to Password Unlock Time
        tdevice_PASSACC         : VitalDelayType := 100 us;
        -- CS# High to Power Down Mode
        -- DPD enter
        tdevice_DPD             : VitalDelayType := 3 us;   -- tDPD
        -- CS# High to StandBy mode without Electronic Signature read
        -- Release DPD
        tdevice_RES             : VitalDelayType := 3 us;  --tRES
        -- QIO, QPI mode enter to the next command
        tdevice_QEN             : VitalDelayType := 1.5 us;
        -- QIO, QPI mode exit to the next command
        tdevice_QEXN            : VitalDelayType := 1 us;

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
            SI              : INOUT std_ulogic := 'U';--serial data input/IO0
            SO              : INOUT std_ulogic := 'U';--serial data output/IO1
            -- Controls
            SCK             : IN    std_ulogic := 'U';--serial clock input
            CSNeg           : IN    std_ulogic := 'U';--chip select input
            RESETNeg        : INOUT std_ulogic := 'U'; --reset input
            WPNeg           : INOUT std_ulogic := 'U';--write protect input/IO2
            IO3RESETNeg     : INOUT std_ulogic := 'U' --reset input/IO3
    );
    END COMPONENT;

    FOR ALL: s25fl256l USE ENTITY work.s25fl256l;
    ---------------------------------------------------------------------------
    --memory configuration
    ---------------------------------------------------------------------------
    CONSTANT MaxData      : NATURAL := 16#FF#; --255;

    CONSTANT SecSize      : NATURAL := 16#FFF#;
    CONSTANT BlockSize    : NATURAL := 16#FFFF#;
    CONSTANT HalfBlockSize: NATURAL := 16#7FFF#;
    CONSTANT SecNum       : NATURAL := 16#1FFF#;
    CONSTANT BlockNum     : NATURAL := 16#1FF#;
    CONSTANT HalfBlockNum : NATURAL := 16#3FF#;

    CONSTANT AddrRANGE    : NATURAL := 16#1FFFFFF#;
    CONSTANT HiAddrBit    : NATURAL := 31;
    CONSTANT SecRegSize   : NATURAL := 16#FF#;
    CONSTANT SECRLoAddr   : NATURAL := 16#000#;
    CONSTANT SECRHiAddr   : NATURAL := 16#3FF#;
    CONSTANT SFDPSize     : NATURAL := 16#5FF#;
    CONSTANT SFDPLoAddr   : NATURAL := 16#0000#;
    CONSTANT SFDPHiAddr   : NATURAL := 16#5FF#;

    ---------------------------------------------------------------------------
    --model configuration
    ---------------------------------------------------------------------------
    CONSTANT mem_file         : string  := "s25fl256l.mem";
    CONSTANT secr_file        : string  := "s25fl256lSECR.mem";
    CONSTANT half_period1_srl : time    := 4.1 ns;--
    CONSTANT half_period2_srl : time    := 4.7 ns;  --1/(2*108MHz)
    CONSTANT half_period3_srl : time    := 10 ns;  --1/(2*50MHz)
    CONSTANT half_period_ddr  : time    := 8.2 ns;--7.6 ns;--1/(2*66MHz)

    CONSTANT UserPreload      : boolean := TRUE;
    CONSTANT LongTimming      : boolean := TRUE;
    CONSTANT TimingModel      : STRING  := "S25FL256LAGMFI000_15pF";
    CONSTANT BootConfig       : boolean := FALSE;
    ---------------------------------------------------------------------------
    --One Byte Instruction Code
    ---------------------------------------------------------------------------
    CONSTANT I_WRR          :std_logic_vector(7 downto 0) := "00000001";-- 01h
    CONSTANT I_PP           :std_logic_vector(7 downto 0) := "00000010";-- 02h
    CONSTANT I_READ         :std_logic_vector(7 downto 0) := "00000011";-- 03h
    CONSTANT I_WRDI         :std_logic_vector(7 downto 0) := "00000100";-- 04h
    CONSTANT I_RDSR1        :std_logic_vector(7 downto 0) := "00000101";-- 05h
    CONSTANT I_WREN         :std_logic_vector(7 downto 0) := "00000110";-- 06h
    CONSTANT I_WRENV        :std_logic_vector(7 downto 0) := "01010000";-- 50h
    CONSTANT I_RDSR2        :std_logic_vector(7 downto 0) := "00000111";-- 07h
    CONSTANT I_4PP          :std_logic_vector(7 downto 0) := "00010010";-- 12h
    CONSTANT I_QPP          :std_logic_vector(7 downto 0) := "00110010";-- 32h
    CONSTANT I_4QPP         :std_logic_vector(7 downto 0) := "00110100";-- 34h
    CONSTANT I_4READ        :std_logic_vector(7 downto 0) := "00010011";-- 13h
    CONSTANT I_SE           :std_logic_vector(7 downto 0) := "00100000";-- 20h
    CONSTANT I_4SE          :std_logic_vector(7 downto 0) := "00100001";-- 21h
    CONSTANT I_CLEAR        :std_logic_vector(7 downto 0) := "00110000";-- 30h
    CONSTANT I_RDCR1        :std_logic_vector(7 downto 0) := "00110101";-- 35h
    CONSTANT I_RDCR2        :std_logic_vector(7 downto 0) := "00010101";-- 15h
    CONSTANT I_RDCR3        :std_logic_vector(7 downto 0) := "00110011";-- 33h
    CONSTANT I_DLPRD        :std_logic_vector(7 downto 0) := "01000001";-- 41h
    CONSTANT I_SECRP        :std_logic_vector(7 downto 0) := "01000010";-- 42h
    CONSTANT I_SECRE        :std_logic_vector(7 downto 0) := "01000100";-- 44h
    CONSTANT I_PDLRNV       :std_logic_vector(7 downto 0) := "01000011";-- 43h
    CONSTANT I_CE           :std_logic_vector(7 downto 0) := "01100000";-- 60h
    CONSTANT I_RDAR         :std_logic_vector(7 downto 0) := "01100101";-- 65h
    CONSTANT I_RSTEN        :std_logic_vector(7 downto 0) := "01100110";-- 66h
    CONSTANT I_WRAR         :std_logic_vector(7 downto 0) := "01110001";-- 71h
    CONSTANT I_EPS          :std_logic_vector(7 downto 0) := "01110101";-- 75h
    CONSTANT I_RST          :std_logic_vector(7 downto 0) := "10011001";-- 99h
    CONSTANT I_FAST_READ    :std_logic_vector(7 downto 0) := "00001011";-- 0Bh
    CONSTANT I_4FAST_READ   :std_logic_vector(7 downto 0) := "00001100";-- 0Ch
    CONSTANT I_IRPRD        :std_logic_vector(7 downto 0) := "00101011";-- 2Bh
    CONSTANT I_IRPP         :std_logic_vector(7 downto 0) := "00101111";-- 2Fh
    CONSTANT I_WDLRV        :std_logic_vector(7 downto 0) := "01001010";-- 4Ah
    CONSTANT I_SECRR        :std_logic_vector(7 downto 0) := "01001000";-- 48h
    CONSTANT I_RSFDP        :std_logic_vector(7 downto 0) := "01011010";-- 5Ah
    CONSTANT I_EPR          :std_logic_vector(7 downto 0) := "01111010";-- 7Ah
    CONSTANT I_RDID         :std_logic_vector(7 downto 0) := "10011111";-- 9Fh
    CONSTANT I_RUID         :std_logic_vector(7 downto 0) := "01001011";-- 4Bh
    CONSTANT I_PRL          :std_logic_vector(7 downto 0) := "10100110";-- A6h
    CONSTANT I_PRRD         :std_logic_vector(7 downto 0) := "10100111";-- A7h
    CONSTANT I_RDQID        :std_logic_vector(7 downto 0) := "10101111";-- AFh
    CONSTANT I_4BEN         :std_logic_vector(7 downto 0) := "10110111";-- B7h
    CONSTANT I_4BEX         :std_logic_vector(7 downto 0) := "11101001";-- E9h
    CONSTANT I_QPIEN        :std_logic_vector(7 downto 0) := "00111000";-- 38h
    CONSTANT I_QPIEX        :std_logic_vector(7 downto 0) := "11110101";-- F5h
    CONSTANT I_DIOR         :std_logic_vector(7 downto 0) := "10111011";-- BBh
    CONSTANT I_4DIOR        :std_logic_vector(7 downto 0) := "10111100";-- BCh
    CONSTANT I_SBL          :std_logic_vector(7 downto 0) := "01110111";-- 77h
    CONSTANT I_BE           :std_logic_vector(7 downto 0) := "11011000";-- D8h
    CONSTANT I_4BE          :std_logic_vector(7 downto 0) := "11011100";-- DCh
    CONSTANT I_HBE          :std_logic_vector(7 downto 0) := "01010010";-- 52h
    CONSTANT I_4HBE         :std_logic_vector(7 downto 0) := "01010011";-- 53h
    CONSTANT I_4IBLRD       :std_logic_vector(7 downto 0) := "11100000";-- E0h
    CONSTANT I_4IBL         :std_logic_vector(7 downto 0) := "11100001";-- E1h
    CONSTANT I_IBLRD        :std_logic_vector(7 downto 0) := "00111101";-- 3Dh
    CONSTANT I_IBL          :std_logic_vector(7 downto 0) := "00110110";-- 36h
    CONSTANT I_IBUL         :std_logic_vector(7 downto 0) := "00111001";-- 39h
    CONSTANT I_4IBUL        :std_logic_vector(7 downto 0) := "11100010";-- E2h
    CONSTANT I_GBL          :std_logic_vector(7 downto 0) := "01111110";-- 7Eh
    CONSTANT I_GBUL         :std_logic_vector(7 downto 0) := "10011000";-- 98h
    CONSTANT I_SPRP         :std_logic_vector(7 downto 0) := "11111011";-- FBh
    CONSTANT I_4SPRP        :std_logic_vector(7 downto 0) := "11100011";-- E3h
    CONSTANT I_PASSRD       :std_logic_vector(7 downto 0) := "11100111";-- E7h
    CONSTANT I_PASSP        :std_logic_vector(7 downto 0) := "11101000";-- E8h
    CONSTANT I_PASSU        :std_logic_vector(7 downto 0) := "11101010";-- EAh
    CONSTANT I_QIOR         :std_logic_vector(7 downto 0) := "11101011";-- EBh
    CONSTANT I_4QIOR        :std_logic_vector(7 downto 0) := "11101100";-- ECh
    CONSTANT I_DDRQIOR      :std_logic_vector(7 downto 0) := "11101101";-- EDh
    CONSTANT I_4DDRQIOR     :std_logic_vector(7 downto 0) := "11101110";-- EEh
    CONSTANT I_DOR          :std_logic_vector(7 downto 0) := "00111011";-- 3Bh
    CONSTANT I_4DOR         :std_logic_vector(7 downto 0) := "00111100";-- 3Ch
    CONSTANT I_QOR          :std_logic_vector(7 downto 0) := "01101011";-- 6Bh
    CONSTANT I_4QOR         :std_logic_vector(7 downto 0) := "01101100";-- 6Ch
    CONSTANT I_MBR          :std_logic_vector(7 downto 0) := "11111111";-- FFh
    CONSTANT I_DPD          :std_logic_vector(7 downto 0) := "10111001";-- B9h
    CONSTANT I_RES          :std_logic_vector(7 downto 0) := "10101011";-- ABh
    CONSTANT I_CLSR         :std_logic_vector(7 downto 0) := "00110000";-- 30h

    ---------------------------------------------------------------------------
    --testbench parameters
    ---------------------------------------------------------------------------
    --Flash Memory Array
    TYPE MemArr IS ARRAY (0 TO AddrRANGE) OF INTEGER RANGE -1 TO MaxData;
    --Security Region Array
    TYPE SECRArr IS ARRAY (SECRLoAddr TO SECRHiAddr) OF INTEGER
                                                            RANGE -1 TO MaxData;
    --Serial Flash Discoverable Parameters Array
    TYPE SFDPArr IS ARRAY (SFDPLoAddr TO SFDPHiAddr) OF INTEGER
                                                            RANGE -1 TO MaxData;
    TYPE ManufDevID_type IS ARRAY (0 TO 2) OF NATURAL;
    TYPE DevID_type IS ARRAY (0 TO 1) OF NATURAL;
    TYPE UID_type IS ARRAY (0 TO 7) OF NATURAL;

    ---------------------------------------------------------------------------
    --  memory declaration
    ---------------------------------------------------------------------------
    --             -- Mem(SecAddr)(Address)....
    SHARED  VARIABLE Mem           : MemArr  := (OTHERS => MaxData);
    SHARED  VARIABLE SECR_array    : SECRArr := (OTHERS => MaxData);
    SHARED  VARIABLE SFDP_array    : SFDPArr;
    SHARED  VARIABLE half_period   : TIME    := half_period1_srl;--4.1 ns
    SHARED  VARIABLE ManufID_DevID : ManufDevID_type := (16#01#, 16#60#, 16#19#);
    SHARED  VARIABLE DevID : DevID_type := (16#19#, 16#60#);
    SHARED  VARIABLE UID   : UID_type := (0,0,0,0,0,0,0,0);

    --command sequence
    SHARED VARIABLE cmd_seq : cmd_seq_type;

    SIGNAL status          : status_type := none;
    SIGNAL cmd             : cmd_type := idle;
    SIGNAL read_num        : NATURAL := 0;

    SIGNAL Clock_polarity  : std_logic;
    SIGNAL PageSize        : NATURAL := 256 ;
    SIGNAL PageNum         : NATURAL := 0 ;

    SIGNAL check_err       : std_logic := '0'; -- Active high on error
    SIGNAL ErrorInTest     : std_logic := '0';
    SIGNAL PoweredUp       : std_logic := '0';

    ---------------------------------------------------------------------------
    --Personality module:
    --
    --  instanciates the DUT module and adapts generic test signals to it
    ---------------------------------------------------------------------------
    --DUT port
    SIGNAL T_SCK                : std_logic := 'U';
    SIGNAL T_SI                 : std_logic := 'U';
    SIGNAL T_SO                 : std_logic := 'U';

    SIGNAL T_CSNeg              : std_logic := 'U';
    SIGNAL T_RESETNeg           : std_logic := '1';
    SIGNAL T_WPNeg              : std_logic := '1';
    SIGNAL T_IO3RESETNeg        : std_logic := '1';
    -----------------------------
    -- Registers
    -----------------------------
    SHARED VARIABLE SR1_NV      : std_logic_vector(7 downto 0) := "00000000";
    SHARED VARIABLE SR1_V       : std_logic_vector(7 downto 0) := "00000000";

    SHARED VARIABLE SR2_V       : std_logic_vector(7 downto 0) := "00000000";

    SHARED VARIABLE CR1_NV      : std_logic_vector(7 downto 0) := "00000000";
    SHARED VARIABLE CR1_V       : std_logic_vector(7 downto 0) := "00000000";

    ALIAS QUAD :std_logic IS CR1_V(1);

    SHARED VARIABLE CR2_NV      : std_logic_vector(7 downto 0) := "01100000";
    SHARED VARIABLE CR2_V       : std_logic_vector(7 downto 0) := "01100000";

    ALIAS QPI :std_logic IS CR2_V(3);
    ALIAS ADS :std_logic IS CR2_V(0);

    SHARED VARIABLE CR3_NV      : std_logic_vector(7 downto 0) := "01111000";
    SHARED VARIABLE CR3_V       : std_logic_vector(7 downto 0) := "01111000";

    SHARED VARIABLE IRP_reg     : std_logic_vector(15 downto 0) :=
                                                          "1111111111111101";
    SHARED VARIABLE Password_reg: std_logic_vector(63 downto 0) := (others => '1');
    SHARED VARIABLE PR_reg      : std_logic_vector(7 downto 0) := "01000001";
    SHARED VARIABLE PRPR_reg    : std_logic_vector(31 downto 0) := (others => '1');
    SHARED VARIABLE DLRNV_reg   : std_logic_vector(7 downto 0) := "00000000";
    SHARED VARIABLE DLRV_reg    : std_logic_vector(7 downto 0) := "00000000";

    SHARED VARIABLE WREN_V      : std_logic;

    SIGNAL Tseries     : NATURAL;
    SIGNAL Tcase       : NATURAL;

    SHARED VARIABLE ts_cnt : NATURAL RANGE 1 TO 33 := 1; -- testseries counter
    SHARED VARIABLE tc_cnt : NATURAL RANGE 0 TO 10 := 0; -- testcase counter

    SHARED VARIABLE Latency_code : NATURAL;
    SHARED VARIABLE tmpA         : std_logic_vector(31 downto 0);
    SHARED VARIABLE tmpPASS      : std_logic_vector(63 downto 0);
    SHARED VARIABLE AddrLow      : NATURAL RANGE 0 TO AddrRANGE;
    SHARED VARIABLE AddrHigh     : NATURAL RANGE 0 TO AddrRANGE;

    BEGIN
        DUT : s25fl256l
        GENERIC MAP (
            tipd_SCK                   => VitalZeroDelay01,
            tipd_SI                    => VitalZeroDelay01,
            tipd_SO                    => VitalZeroDelay01,
            tipd_CSNeg                 => VitalZeroDelay01,
            tipd_RESETNeg              => VitalZeroDelay01,
            tipd_WPNeg                 => VitalZeroDelay01,
            tipd_IO3RESETNeg           => VitalZeroDelay01,

            -- tpd delays: propagation delays (pin-to-pin delay within a component)
            tpd_SCK_SO                 => UnitDelay01Z, -- tV
            tpd_CSNeg_SO_RST_QUAD_EQ_1 => UnitDelay01Z, -- tDIS
            tpd_CSNeg_SO_RST_QUAD_EQ_0 => UnitDelay01Z, -- tDIS

            -- tsetup values: setup times
            --   setup time is minimum time before the referent signal edge the
            --   input should be stable
            tsetup_CSNeg_SCK           => UnitDelay, -- tCSS /
            tsetup_SI_SCK              => UnitDelay, -- tSU:DAT /
            tsetup_WPNeg_CSNeg         => UnitDelay, -- tWPS \

            -- thold values: hold times
            --   hold time is minimum time the input should be present stable
            --   after the referent signal edge
            thold_CSNeg_SCK            => UnitDelay, -- tCSH /
            thold_SI_SCK               => UnitDelay, -- tHD:DAT /
            thold_WPNeg_CSNeg          => UnitDelay, -- tWPH /
            thold_CSNeg_RESETNeg       => UnitDelay, -- tRH
            thold_CSNeg_IO3RESETNeg    => UnitDelay, -- tRH

            --tpw values: pulse width
            tpw_SCK_normal_rd          => UnitDelay,
            tpw_SCK_fast_rd            => UnitDelay,
            tpw_SCK_ddr_rd             => UnitDelay,
            tpw_SCK_reg_rd             => UnitDelay,
            tpw_CSNeg                  => UnitDelay, -- tCS
            tpw_RESETNeg               => UnitDelay, -- tRP
            tpw_IO3RESETNeg            => UnitDelay, -- tRP

            -- tperiod min (calculated as 1/max freq)
            tperiod_SCK_normal_rd      => UnitDelay, --fSCK=50MHz
            tperiod_SCK_fast_rd        => UnitDelay, --fSCK=133MHz
            tperiod_SCK_ddr_rd         => UnitDelay, --fSCK=80MHz
            tperiod_SCK_reg_rd         => UnitDelay, --fSCK=108MHz

            -- tdevice values: values for internal delays
            --timing values that are internal to the model and not associated
            --with any port.
            -- WRR Cycle Time
            tdevice_WRR                => 750 ms,  --tW
            -- Page Program Operation
            tdevice_PP                 => 900 us,  --tPP

            -- Byte Programming
            tdevice_BP1                => 25 us,  --tBP1
            -- Byte Programming
            tdevice_BP2                => 20 us,  --tBP2

            -- 4 KB Sector Erase Operation
            tdevice_SE                 => 200 ms, --tSE
            -- 32 KB Half Block Erase Operation
            tdevice_HBE                => 363 ms, --tHBE
            -- 64 KB Block Erase Operation
            tdevice_BE                 => 725 ms, --tBE

            -- Chip Erase Operation
            tdevice_CE                 => 360 sec, --tCE
            -- Suspend latency
            tdevice_SUSP               => 40 us,   --tSL
            -- Resume to next Suspend Time
            tdevice_RNS                => 100 us,   --tRS
            -- RESET# Low to CS# Low
            tdevice_RPH                => 100 us,   --tRPH
            -- CS# High before HW Reset (Quad mode and Reset Feature are enabled)
            -- Volatile registers write time
            tdevice_CS                 => 50 ns,   --tRPH
            -- VDD (min) to CS# Low
            tdevice_PU                 => 300 us,  --tPU
            -- Password Unlock to Password Unlock Time
            tdevice_PASSACC            => 100 us,  --
            -- CS# High to Power Down Mode
            -- DPD enter
            tdevice_DPD                => 3 us,   -- tDPD
            -- CS# High to StandBy mode without Electronic Signature read
            -- Release DPD
            tdevice_RES                => 3 us,  --tRES
            -- QIO, QPI mode enter to the next command
            tdevice_QEN                => 1.5 us,  --
            -- QIO, QPI mode exit to the next command
            tdevice_QEXN               => 1 us,  --

        ---------------------------------------------------------------------------
        -- CONTROL GENERICS:
        ---------------------------------------------------------------------------
            -- generic control parameters
            InstancePath      => DefaultInstancePath,
            TimingChecksOn    => DefaultTimingChecks,
            MsgOn             => DefaultMsgOn,
            XOn               => DefaultXon,
            -- memory file to be loaded
            mem_file_name     => "s25fl256l.mem",
            secr_file_name    => "s25fl256lSECR.mem",

            UserPreload       => UserPreload,
            LongTimming       => TRUE,

            BootConfig        => BootConfig,

            -- For FMF SDF technology file usage
            TimingModel       => "S25FL256LAGMFI000_15pF"
        )
        PORT MAP(
            SCK        => T_SCK,
            SI         => T_SI,
            SO         => T_SO,
            CSNeg      => T_CSNeg,
            RESETNeg   => T_RESETNeg,
            WPNeg      => T_WPNeg,
            IO3RESETNeg => T_IO3RESETNeg
        );

   Clock_polarity <= '0';--SPI mode: CPO L= 0, CPHA = 0
--     Clock_polarity <= '1';--SPI mode: CPO L= 1, CPHA = 1

    PoweredUp <= '0', '1' AFTER 300 us;

    clk_generation: PROCESS(T_SCK, T_CSNeg)
    BEGIN
        IF T_CSNeg = '1' THEN
            T_SCK <= Clock_polarity;
        ELSE
            T_SCK <= NOT T_SCK AFTER half_period;
        END IF;
    END PROCESS clk_generation;

--At the end of the simulation, if ErrorInTest='0' there were no errors
    err_ctrl : PROCESS ( check_err  )
    BEGIN
        IF check_err = '1' THEN
            ErrorInTest <= '1';
        END IF;
    END PROCESS err_ctrl;

tb  :PROCESS
--------------------------------------------------------------------------
    -- PROCEDURE to select TC
    -- can be modified to read TC list from file, or to generate random list
    --------------------------------------------------------------------------
    PROCEDURE   Pick_TC
        (Model   :  IN  string  := "s25fl256l" )
    IS
    BEGIN
        IF TC_cnt < tc(TS_cnt) THEN
            TC_cnt := TC_cnt+1;
        ELSE
            TC_cnt := 1;
            IF TS_cnt < 18 THEN
                TS_cnt := TS_cnt+1;
            ELSE
                IF ErrorInTest='0' THEN
                    REPORT "Test Ended without errors"
                    SEVERITY note;
                ELSE
                    REPORT "There were errors in test"
                    SEVERITY note;
                END IF;
                WAIT;
            END IF;
        END IF;

    END PROCEDURE Pick_TC;

   ----------------------------------------------------------------------------
    --bus commands, device specific implementation
    ---------------------------------------------------------------------------
    TYPE bus_type IS (bus_idle,
                      bus_select,     --CS# asseretd
                      bus_deselect,   --CS# deasserted after write
                      bus_desel_read, --CS# deasserted after read
                      bus_opcode,
                      bus_reset,
                      bus_reset_io3,
                      bus_address,
                      bus_dummy_byte,
                      bus_dummy_clock,
                      bus_mode_byte,
                      bus_data_read,
                      bus_data_write);

    --bus drive for specific command sequence cycle
    PROCEDURE bus_cycle(
        bus_cmd   :IN   bus_type := bus_idle;
        opcode    :IN   std_logic_vector(7 downto 0) := "00000000";
        data1     :IN   NATURAL                      := 0;
        address   :IN   NATURAL RANGE 0 TO AddrRANGE := 0;
        sector    :IN   INTEGER RANGE 0 TO SecNum    := 0;
        data_num  :IN   INTEGER RANGE 0 TO AddrRANGE := 0;
        protect   :IN   boolean                      := false;
        pulse     :IN   boolean                      := false;
        PowerUp   :IN   boolean                      := false;
        tm        :IN   TIME                         := 0 ns)
    IS
        VARIABLE tmpD         : std_logic_vector(7 downto 0);
        VARIABLE tmpD1        : std_logic_vector(31 downto 0);
        VARIABLE data_tmp     : NATURAL;
    BEGIN
        tmpA := to_slv((sector*(SecSize+1)+address), 32);
        tmpD := to_slv(data1, 8);
        tmpD1:= to_slv(data1, 32);
        data_tmp := data1;

        CASE bus_cmd IS

            WHEN bus_idle =>
                T_CSNeg    <= '1';
                IF protect THEN
                    WAIT FOR 100 ns;
                    T_WPNeg <= not(T_WPNeg);
                END IF;
                WAIT FOR 20 ns;

            WHEN bus_select =>
                WAIT FOR 10 ns;
                T_CSNeg <= '0';
                WAIT FOR tm;

            WHEN bus_reset =>
                T_RESETNeg <= '0', '1' AFTER tm;
                WAIT FOR 30 ns;

            WHEN bus_reset_io3 =>
                T_IO3RESETNeg <=  '1';
                WAIT FOR 30 ns;
                T_IO3RESETNeg <= '0', '1' AFTER tm;
                WAIT FOR 30 ns;

            WHEN bus_opcode =>
                IF Clock_polarity = '1' THEN
                    WAIT UNTIL falling_edge(T_SCK);
                END IF;
                WAIT FOR 0.5 ns;

                IF (QPI = '0') THEN
                    FOR I IN 7 downto 1 LOOP
                        T_SI <= opcode(i);
                        WAIT FOR 2*half_period;
                    END LOOP;
                    T_SI <= opcode(0);
                ELSE
                    T_IO3RESETNeg <= opcode(7);
                    T_WPNeg    <= opcode(6);
                    T_SO       <= opcode(5);
                    T_SI       <= opcode(4);
                    WAIT FOR 2*half_period;
                    T_IO3RESETNeg <= opcode(3);
                    T_WPNeg    <= opcode(2);
                    T_SO       <= opcode(1);
                    T_SI       <= opcode(0);
                END IF;
                -- if number of clock pulses isn't multiple of 8
                IF pulse THEN
                    WAIT FOR 2*half_period;
                END IF;

            WHEN bus_deselect    =>
                WAIT UNTIL rising_edge(T_SCK);
                IF Clock_polarity = '0' THEN
                    WAIT UNTIL falling_edge(T_SCK);
                END IF;
                WAIT FOR 3 ns;
                T_CSNeg <= '1';
                WAIT FOR 30 ns;

            WHEN bus_desel_read    =>
                IF Clock_polarity = '1' THEN
                    WAIT UNTIL rising_edge(T_SCK);
                    IF half_period = half_period1_srl THEN
                        WAIT FOR 3.5 ns;
                    ELSE
                        WAIT FOR 5 ns;
                    END IF;
                ELSE
                    IF half_period = half_period1_srl THEN
                        WAIT UNTIL falling_edge(T_SCK);
                        WAIT FOR 2 ns;
                    ELSE
                        WAIT UNTIL falling_edge(T_SCK);
                        WAIT FOR 3 ns;
                    END IF;
                END IF;
                T_CSNeg <= '1';

                IF QUAD = '1' OR QPI = '1' THEN
                    WAIT FOR 2*half_period;
                    T_WPNeg    <= '1';
                    T_IO3RESETNeg <= '1';
                END IF;

            WHEN bus_address     =>

                IF (opcode = I_DDRQIOR AND ADS = '0') THEN
                    IF status /= rd_cont THEN
                        WAIT UNTIL rising_edge(T_SCK);
                        FOR I IN 5 downto 0 LOOP
                            WAIT UNTIL T_SCK'EVENT;
                            WAIT FOR 3 ns;
                            T_IO3RESETNeg <= tmpA(4*i+3);
                            T_WPNeg    <= tmpA(4*i+2);
                            T_SO       <= tmpA(4*i+1);
                            T_SI       <= tmpA(4*i);
                        END LOOP;
                    ELSE
                        WAIT FOR 1 ns;
                        T_IO3RESETNeg <= tmpA(23);
                        T_WPNeg    <= tmpA(22);
                        T_SO       <= tmpA(21);
                        T_SI       <= tmpA(20);
                        FOR I IN 4 downto 0 LOOP
                            WAIT UNTIL T_SCK'EVENT;
                            WAIT FOR 3 ns;
                            T_IO3RESETNeg <= tmpA(4*i+3);
                            T_WPNeg    <= tmpA(4*i+2);
                            T_SO       <= tmpA(4*i+1);
                            T_SI       <= tmpA(4*i);
                        END LOOP;
                    END IF;
                ELSIF (opcode = I_4DDRQIOR OR
                (opcode = I_DDRQIOR AND ADS = '1')) THEN
                    IF status /= rd_cont THEN
                        WAIT UNTIL rising_edge(T_SCK);
                        FOR I IN 7 downto 0 LOOP
                            WAIT UNTIL T_SCK'EVENT;
                            WAIT FOR 3 ns;
                            T_IO3RESETNeg <= tmpA(4*i+3);
                            T_WPNeg    <= tmpA(4*i+2);
                            T_SO       <= tmpA(4*i+1);
                            T_SI       <= tmpA(4*i);
                        END LOOP;
                    ELSE
                        WAIT FOR 1 ns;
                        T_IO3RESETNeg <= tmpA(31);
                        T_WPNeg    <= tmpA(30);
                        T_SO       <= tmpA(29);
                        T_SI       <= tmpA(28);
                        FOR I IN 6 downto 0 LOOP
                            WAIT UNTIL T_SCK'EVENT;
                            WAIT FOR 3 ns;
                            T_IO3RESETNeg <= tmpA(4*i+3);
                            T_WPNeg    <= tmpA(4*i+2);
                            T_SO       <= tmpA(4*i+1);
                            T_SI       <= tmpA(4*i);
                        END LOOP;
                    END IF;
                ELSIF ADS='0' AND opcode = I_QIOR THEN
                    IF status /= rd_cont THEN
                        WAIT UNTIL falling_edge(T_SCK);
                    END IF;
                    WAIT FOR 1 ns;
                    FOR I IN 0 TO 5 LOOP
                        T_IO3RESETNeg <= tmpA(23-4*i);
                        T_WPNeg    <= tmpA(22-4*i);
                        T_SO       <= tmpA(21-4*i);
                        T_SI       <= tmpA(20-4*i);
                        IF I < 5 THEN
                            WAIT FOR 2*half_period;
                        END IF;
                    END LOOP;
                ELSIF (ADS='1' AND opcode=I_QIOR) OR opcode=I_4QIOR THEN
                    IF status /= rd_cont THEN
                        WAIT UNTIL falling_edge(T_SCK);
                    END IF;
                    WAIT FOR 1 ns;
                    FOR I IN 0 TO 7 LOOP
                        T_IO3RESETNeg <= tmpA(31-4*i);
                        T_WPNeg    <= tmpA(30-4*i);
                        T_SO       <= tmpA(29-4*i);
                        T_SI       <= tmpA(28-4*i);
                        IF I < 7 THEN
                            WAIT FOR 2*half_period;
                        END IF;
                    END LOOP;
                ELSIF (opcode=I_4PP OR  opcode=I_4QPP OR
                opcode=I_4SE OR opcode=I_4HBE OR opcode=I_4BE OR
                opcode=I_4IBLRD OR opcode=I_4IBL OR opcode=I_4IBUL OR
                opcode=I_4SPRP) OR (ADS='1' AND (
                opcode=I_RSFDP OR opcode=I_RDAR OR opcode=I_WRAR OR 
                opcode=I_PP OR opcode=I_QPP OR opcode=I_SE OR opcode=I_BE OR
                opcode=I_HBE
                OR opcode=I_CE OR opcode=I_SECRR OR opcode=I_SECRP OR
                opcode=I_SECRE OR opcode=I_IBLRD OR opcode=I_IBL OR
                opcode=I_IBUL OR opcode=I_SPRP)) THEN
                    IF QPI='1' THEN
                        WAIT UNTIL falling_edge(T_SCK);
                        WAIT FOR 1 ns;
                        FOR I IN 0 TO 7 LOOP
                            T_IO3RESETNeg <= tmpA(31-4*i);
                            T_WPNeg    <= tmpA(30-4*i);
                            T_SO       <= tmpA(29-4*i);
                            T_SI       <= tmpA(28-4*i);
                            IF I < 7 THEN
                                WAIT FOR 2*half_period;
                            END IF;
                        END LOOP;
                    ELSIF QPI='0' THEN
                        WAIT UNTIL falling_edge(T_SCK);
                        WAIT FOR 1 ns;
                        FOR I IN 0 TO 31 LOOP
                            T_SI       <= tmpA(31-i);
                            IF I < 31 THEN
                                WAIT FOR 2*half_period;
                            END IF;
                        END LOOP;
                    END IF;
                ELSIF ADS='0' AND (
                opcode=I_RSFDP OR opcode=I_RDAR OR opcode=I_WRAR OR
                opcode=I_PP OR opcode=I_QPP OR opcode=I_SE OR opcode=I_BE
                OR opcode=I_HBE
                OR opcode=I_CE OR opcode=I_SECRR OR opcode=I_SECRP OR
                opcode=I_SECRE OR opcode=I_IBLRD OR opcode=I_IBL OR
                opcode=I_IBUL OR opcode=I_SPRP) THEN
                    IF QPI='1' THEN
                        WAIT UNTIL falling_edge(T_SCK);
                        WAIT FOR 1 ns;
                        FOR I IN 0 TO 5 LOOP
                            T_IO3RESETNeg <= tmpA(23-4*i);
                            T_WPNeg    <= tmpA(22-4*i);
                            T_SO       <= tmpA(21-4*i);
                            T_SI       <= tmpA(20-4*i);
                            IF I < 5 THEN
                                WAIT FOR 2*half_period;
                            END IF;
                        END LOOP;
                    ELSIF QPI='0' THEN
                        WAIT UNTIL falling_edge(T_SCK);
                        WAIT FOR 1 ns;
                        FOR I IN 0 TO 23 LOOP
                            T_SI       <= tmpA(23-i);
                            IF I < 23 THEN
                                WAIT FOR 2*half_period;
                            END IF;
                        END LOOP;
                    END IF;
                ELSIF (opcode=I_DIOR) AND (ADS = '0') THEN
                    IF status /= rd_cont THEN
                        WAIT UNTIL falling_edge(T_SCK);
                    END IF;
                    WAIT FOR 1 ns;
                    FOR I IN 0 TO 11 LOOP
                        T_SO <= tmpA(23-2*i);
                        T_SI <= tmpA(22-2*i);
                        IF I < 11 THEN
                            WAIT FOR 2*half_period;
                        END IF;
                    END LOOP;
                ELSIF (opcode = I_DIOR AND ADS = '1') OR
                (opcode = I_4DIOR) THEN
                    IF status /= rd_cont THEN
                        WAIT UNTIL falling_edge(T_SCK);
                    END IF;
                    WAIT FOR 1 ns;
                    FOR I IN 0 TO 15 LOOP
                        T_SO <= tmpA(31-2*i);
                        T_SI <= tmpA(30-2*i);
                        IF I < 15 THEN
                            WAIT FOR 2*half_period;
                        END IF;
                    END LOOP;
                ELSE
                    IF (ADS = '1') OR (opcode=I_4READ) OR
                    (opcode=I_4FAST_READ) OR (opcode=I_4DOR)
                    OR (opcode=I_4QOR) OR (opcode=I_4QPP)
                    THEN
                        WAIT UNTIL falling_edge(T_SCK);
                        WAIT FOR 1 ns;
                        FOR I IN 31 downto 0 LOOP
                            T_SI <= tmpA(i);
                            IF I > 0 THEN
                                WAIT FOR 2*half_period;
                            END IF;
                        END LOOP;
                    ELSIF ADS = '0' THEN
                        WAIT UNTIL falling_edge(T_SCK);
                        WAIT FOR 1 ns;
                        FOR I IN 23 downto 0 LOOP
                            T_SI <= tmpA(i);
                            IF I > 0 THEN
                                WAIT FOR 2*half_period;
                            END IF;
                        END LOOP;
                    END IF;
                END IF;

            WHEN bus_mode_byte  =>
                IF opcode = I_DDRQIOR OR opcode = I_4DDRQIOR THEN
                    WAIT UNTIL T_SCK'EVENT;
                    WAIT FOR 3 ns;
                    T_IO3RESETNeg <= tmpD(7);
                    T_WPNeg    <= tmpD(6);
                    T_SO       <= tmpD(5);
                    T_SI       <= tmpD(4);
                    WAIT FOR half_period;
                    T_IO3RESETNeg <= tmpD(3);
                    T_WPNeg    <= tmpD(2);
                    T_SO       <= tmpD(1);
                    T_SI       <= tmpD(0);
                ELSIF opcode = I_DIOR OR opcode = I_4DIOR THEN
                    WAIT UNTIL falling_edge(T_SCK);
                    WAIT FOR 1 ns;
                    FOR I IN 0 to 3 LOOP
                        T_SO <= tmpD(7-2*i);
                        T_SI <= tmpD(6-2*i);
                        IF I < 3 THEN
                            WAIT FOR 2*half_period;
                        END IF;
                    END LOOP;
                ELSIF opcode = I_QIOR OR opcode = I_4QIOR THEN
                    WAIT UNTIL falling_edge(T_SCK);
                    WAIT FOR 1 ns;
                    T_IO3RESETNeg <= tmpD(7);
                    T_WPNeg    <= tmpD(6);
                    T_SO       <= tmpD(5);
                    T_SI       <= tmpD(4);
                    WAIT FOR 2*half_period;
                    T_IO3RESETNeg <= tmpD(3);
                    T_WPNeg    <= tmpD(2);
                    T_SO       <= tmpD(1);
                    T_SI       <= tmpD(0);
                END IF;

            WHEN bus_dummy_byte  =>
                IF QPI = '1' OR QUAD = '1' THEN
                    WAIT UNTIL falling_edge(T_SCK);
                    WAIT FOR 3 ns;
                    FOR I IN 7 downto 0 LOOP
                        T_IO3RESETNeg <= 'Z';
                        T_WPNeg    <= 'Z';
                        T_SI       <= 'Z';
                        T_SO       <= 'Z';
                        IF I > 0 THEN
                            WAIT FOR 2*half_period;
                        END IF;
                    END LOOP;
                ELSE
                    WAIT UNTIL falling_edge(T_SCK);
                    WAIT FOR 0.5 ns;
                    FOR I IN 7 downto 0 LOOP
                        T_SI <= 'Z';
                        IF I > 0 THEN
                            WAIT FOR 2*half_period;
                        END IF;
                    END LOOP;
                END IF;

            WHEN bus_dummy_clock  =>
                Latency_code := to_nat(CR3_V(3 DOWNTO 0));
                IF Latency_code = 0 THEN
                    Latency_code := 8;
                END IF;
                IF opcode=I_DLPRD OR opcode=I_IRPRD OR opcode=I_PASSRD
                OR opcode=I_PRRD THEN
                    Latency_code := 1;
                ELSIF opcode=I_RUID THEN
                    Latency_code := 32;
                ELSIF opcode=I_RES THEN
                    Latency_code := 24;
                END IF;

                IF cmd = secr_read THEN
                    WAIT UNTIL falling_edge(T_SCK);
                    WAIT FOR 0.5 ns;
                    IF Latency_code = 1 THEN
                        IF QPI = '1' THEN
                            T_IO3RESETNeg <= 'Z';
                            T_WPNeg    <= 'Z';
                            T_SI       <= 'Z';
                            T_SO       <= 'Z';
                        ELSE
                            T_SO       <= 'Z';
                        END IF;
                    ELSIF Latency_code > 1 THEN
                        FOR I IN (Latency_code-1) DOWNTO 0 LOOP
                            IF QPI = '1' THEN
                                T_IO3RESETNeg <= 'Z';
                                T_WPNeg    <= 'Z';
                                T_SI       <= 'Z';
                                T_SO       <= 'Z';
                            ELSE
                                T_SO       <= 'Z';
                            END IF;
                            IF I > 0 THEN
                                WAIT FOR 2*half_period;
                            END IF;
                        END LOOP;
                    END IF;
                ELSIF QPI = '1' OR QUAD = '1' THEN
                    WAIT UNTIL falling_edge(T_SCK);
                    IF half_period = half_period1_srl THEN
                        WAIT FOR 0.5 ns;
                    ELSE
                        WAIT FOR 3 ns;
                    END IF;
                    IF Latency_code = 1 THEN
                        T_IO3RESETNeg <= 'Z';
                        T_WPNeg    <= 'Z';
                        T_SI       <= 'Z';
                        T_SO       <= 'Z';
                    ELSIF Latency_code > 1 THEN
                        FOR I IN (Latency_code-1) DOWNTO 0 LOOP
                            T_IO3RESETNeg <= 'Z';
                            T_WPNeg    <= 'Z';
                            T_SI       <= 'Z';
                            T_SO       <= 'Z';
                            IF I > 0 THEN
                                WAIT FOR 2*half_period;
                            END IF;
                        END LOOP;

                    END IF;
                ELSIF (opcode = I_DIOR OR opcode = I_4DIOR) THEN
                    IF Latency_code = 1 THEN
                        WAIT UNTIL falling_edge(T_SCK);
                        WAIT FOR 0.5 ns;
                        T_SI       <= 'Z';
                        T_SO       <= 'Z';
                    ELSIF Latency_code > 1 THEN
                        WAIT UNTIL falling_edge(T_SCK);
                        WAIT FOR 0.5 ns;
                        FOR I IN (Latency_code-1) DOWNTO 0 LOOP
                            T_SI       <= 'Z';
                            T_SO       <= 'Z';
                            IF I > 0 THEN
                                WAIT FOR 2*half_period;
                            END IF;
                        END LOOP;
                    END IF;
                ELSE
                    IF Latency_code = 1 THEN
                        WAIT UNTIL falling_edge(T_SCK);
                        WAIT FOR 0.5 ns;
                        T_SI       <= 'Z';
                    ELSIF Latency_code > 1 THEN
                        WAIT UNTIL falling_edge(T_SCK);
                        WAIT FOR 0.5 ns;
                        FOR I IN (Latency_code-1) DOWNTO 0 LOOP
                            T_SI       <= 'Z';
                            IF I > 0 THEN
                                WAIT FOR 2*half_period;
                            END IF;
                        END LOOP;
                    END IF;
                END IF;

            WHEN bus_data_read   =>

                IF QPI = '1' OR opcode = I_QOR OR opcode = I_4QOR
                OR opcode = I_QIOR OR opcode = I_4QIOR OR
                opcode = I_DDRQIOR OR opcode = I_4DDRQIOR OR
                opcode = I_RDQID THEN
                    WAIT UNTIL rising_edge(T_SCK);
                    WAIT FOR 2.5 ns;
                    T_SO       <= 'Z';
                    T_SI       <= 'Z';
                    T_WPNeg    <= 'Z';
                    T_IO3RESETNeg <= 'Z';
                ELSIF opcode = I_DIOR OR opcode = I_4DIOR THEN
                    WAIT UNTIL rising_edge(T_SCK);
                    WAIT FOR 2.5 ns;
                    T_SO       <= 'Z';
                    T_SI       <= 'Z';
                ELSE
                    WAIT UNTIL rising_edge(T_SCK);
                    WAIT FOR 2.5 ns;
                    T_SO       <= 'Z';
                END IF;
                IF opcode = I_DDRQIOR OR opcode = I_4DDRQIOR THEN
                    WAIT UNTIL rising_edge(T_SCK);
                    FOR I IN data_num-1 DOWNTO 0 LOOP
                        FOR I IN 1 downto 0 LOOP
                            WAIT UNTIL T_SCK'EVENT;
                            WAIT FOR 4 ns;
                        END LOOP;
                    END LOOP;
                ELSIF QPI = '1' OR opcode = I_QOR OR opcode = I_4QOR
                OR opcode = I_QIOR OR opcode = I_4QIOR OR
                opcode = I_RDQID THEN
                    FOR I IN data_num-1 DOWNTO 0 LOOP
                        FOR I IN 1 downto 0 LOOP
                            WAIT UNTIL falling_edge(T_SCK);
                            WAIT FOR 3 ns;
                        END LOOP;
                    END LOOP;
                ELSIF opcode = I_DIOR OR opcode = I_4DIOR OR
                opcode = I_DOR OR opcode = I_4DOR THEN
                    FOR I IN data_num-1 DOWNTO 0 LOOP
                        FOR I IN 3 downto 0 LOOP
                            WAIT UNTIL falling_edge(T_SCK);
                            WAIT FOR 3 ns;
                        END LOOP;
                    END LOOP;
                ELSIF opcode = I_IRPRD THEN
                    FOR I IN data_num-1 DOWNTO 0 LOOP
                        FOR I IN 15 downto 0 LOOP
                            WAIT UNTIL falling_edge(T_SCK);
                            WAIT FOR 3 ns;
                        END LOOP;
                    END LOOP;
                ELSIF opcode = I_PASSRD THEN
                    FOR I IN data_num-1 DOWNTO 0 LOOP
                        FOR I IN 63 downto 0 LOOP
                            WAIT UNTIL falling_edge(T_SCK);
                            WAIT FOR 3 ns;
                        END LOOP;
                    END LOOP;
                ELSE
                    FOR I IN data_num-1 DOWNTO 0 LOOP
                        FOR I IN 7 downto 0 LOOP
                            WAIT UNTIL falling_edge(T_SCK);
                            IF half_period = half_period1_srl THEN
                                WAIT FOR 3 ns;
                            ELSE
                                WAIT FOR 8 ns;
                            END IF;
                        END LOOP;
                    END LOOP;
                END IF;
                --two more bit of data-out sequence
                IF pulse THEN
                    WAIT FOR 4*half_period;
                ELSIF QUAD = '1' OR QPI = '1' THEN
                   WAIT FOR half_period;
                END IF;

            WHEN bus_data_write  =>
                IF cmd = w_irpp THEN
                    WAIT UNTIL falling_edge(T_SCK);
                    WAIT FOR 0.5 ns;
                    IF QPI = '1' THEN
                        FOR I IN 0 TO 1 LOOP
                            T_IO3RESETNeg <= tmpD1(8*i + 7);
                            T_WPNeg    <= tmpD1(8*i + 6);
                            T_SO       <= tmpD1(8*i + 5);
                            T_SI       <= tmpD1(8*i + 4);
                            WAIT FOR 2*half_period;
                            T_IO3RESETNeg <= tmpD1(8*i + 3);
                            T_WPNeg    <= tmpD1(8*i + 2);
                            T_SO       <= tmpD1(8*i + 1);
                            T_SI       <= tmpD1(8*i + 0);
                            IF I = 0 THEN
                                WAIT FOR 2*half_period;
                            END IF;
                        END LOOP;
                    ELSE 
                        FOR J IN 7 DOWNTO 0 LOOP
                            T_SI <= tmpD1(J);
                            WAIT FOR 2*half_period;
                        END LOOP;
                        FOR J IN 7 DOWNTO 0 LOOP
                            T_SI <= tmpD1(8 + J);
                            IF  J > 0 THEN
                                WAIT FOR 2*half_period;
                            END IF;
                        END LOOP;
                    END IF;
                ELSIF cmd = w_password OR cmd = psw_unlock THEN
                    WAIT UNTIL falling_edge(T_SCK);
                    WAIT FOR 0.5 ns;
                    IF QPI = '1' THEN
                        FOR I IN 0 TO 7 LOOP
                            T_IO3RESETNeg <= tmpPASS(8*i + 7);
                            T_WPNeg    <= tmpPASS(8*i + 6);
                            T_SO       <= tmpPASS(8*i + 5);
                            T_SI       <= tmpPASS(8*i + 4);
                            WAIT FOR 2*half_period;
                            T_IO3RESETNeg <= tmpPASS(8*i + 3);
                            T_WPNeg    <= tmpPASS(8*i + 2);
                            T_SO       <= tmpPASS(8*i + 1);
                            T_SI       <= tmpPASS(8*i + 0);
                            IF I < 7 THEN
                                WAIT FOR 2*half_period;
                            END IF;
                        END LOOP;
                    ELSE
                        FOR I IN 0 TO 7 LOOP
                            FOR J IN 7 DOWNTO 0 LOOP
                                T_SI <= tmpPASS(I*8 + J);
                                IF NOT (I = 7 AND J= 0) THEN
                                    WAIT FOR 2*half_period;
                                END IF;
                            END LOOP;
                        END LOOP;
                    END IF;

                ELSIF cmd = w_wrr THEN
                    WAIT UNTIL falling_edge(T_SCK);
                    WAIT FOR 0.5 ns;
                    IF QPI = '1' THEN
                        FOR I IN 0 TO data_num-1 LOOP
                            T_IO3RESETNeg <= tmpD1(8*i + 7);
                            T_WPNeg    <= tmpD1(8*i + 6);
                            T_SO       <= tmpD1(8*i + 5);
                            T_SI       <= tmpD1(8*i + 4);
                            WAIT FOR 2*half_period;
                            T_IO3RESETNeg <= tmpD1(8*i + 3);
                            T_WPNeg    <= tmpD1(8*i + 2);
                            T_SO       <= tmpD1(8*i + 1);
                            T_SI       <= tmpD1(8*i + 0);
                            IF I < (data_num-1) THEN
                                WAIT FOR 2*half_period;
                            END IF;
                        END LOOP;
                    ELSE
                        FOR I IN 0 TO data_num-1 LOOP
                            FOR J IN 7 DOWNTO 0 LOOP
                                T_SI <= tmpD1(I*8 + J);
                                IF NOT (I = (data_num-1) AND J= 0) THEN
                                    WAIT FOR 2*half_period;
                                END IF;
                            END LOOP;
                        END LOOP;
                    END IF;

                ELSIF cmd = set_bl THEN
                    WAIT UNTIL falling_edge(T_SCK);
                    WAIT FOR 0.5 ns;
                    FOR I IN 0 TO 5 LOOP
                        T_IO3RESETNeg <= '0';
                        T_WPNeg    <= '0';
                        T_SO       <= '0';
                        T_SI       <= '0';
                        WAIT FOR 2*half_period;
                    END LOOP;
                    T_IO3RESETNeg <= '0';
                    T_WPNeg    <= tmpD1(6);
                    T_SO       <= tmpD1(5);
                    T_SI       <= tmpD1(4);
                    WAIT FOR 2*half_period;
                    T_IO3RESETNeg <= '0';
                    T_WPNeg    <= '0';
                    T_SO       <= '0';
                    T_SI       <= '0';

                ELSIF cmd = qpg_prog OR cmd = qpg_prog4 THEN
                    WAIT UNTIL falling_edge(T_SCK);
                    WAIT FOR 0.5 ns;
                    FOR I IN data_num-1 DOWNTO 0 LOOP
                        T_IO3RESETNeg <= tmpD(7);
                        T_WPNeg    <= tmpD(6);
                        T_SO       <= tmpD(5);
                        T_SI       <= tmpD(4);
                        WAIT FOR 2*half_period;
                        T_IO3RESETNeg <= tmpD(3);
                        T_WPNeg    <= tmpD(2);
                        T_SO       <= tmpD(1);
                        T_SI       <= tmpD(0);
                        data_tmp   := data_tmp + 1;
                        tmpD := to_slv(data_tmp, 8);
                        IF I > 0 THEN
                            WAIT FOR 2*half_period;
                        END IF;
                    END LOOP;
                ELSE
                    WAIT UNTIL falling_edge(T_SCK);
                    WAIT FOR 0.5 ns;
                    IF QPI = '1' THEN
                        FOR I IN data_num-1 DOWNTO 0 LOOP
                            T_IO3RESETNeg <= tmpD(7);
                            T_WPNeg    <= tmpD(6);
                            T_SO       <= tmpD(5);
                            T_SI       <= tmpD(4);
                            WAIT FOR 2*half_period;
                            T_IO3RESETNeg <= tmpD(3);
                            T_WPNeg    <= tmpD(2);
                            T_SO       <= tmpD(1);
                            T_SI       <= tmpD(0);
                            data_tmp   := data_tmp + 1;
                            tmpD := to_slv(data_tmp, 8);
                            IF I > 0 THEN
                                WAIT FOR 2*half_period;
                            END IF;
                        END LOOP;
                    ELSE
                        FOR J IN data_num-1 DOWNTO 0 LOOP
                            FOR I IN 7 downto 0 LOOP
                                T_SI <= tmpD(i);
                                IF NOT (I = 0 and J = 0) THEN
                                    WAIT FOR 2*half_period;
                                END IF;
                            END LOOP;
                            data_tmp := data_tmp + 1;
                            tmpD := to_slv(data_tmp, 8);
                        END LOOP;
                    END IF;
                END IF;
        END CASE;

    END PROCEDURE;

   ----------------------------------------------------------------------------
    --procedure to decode commands into specific bus command sequence
    ---------------------------------------------------------------------------
    PROCEDURE cmd_dc
        (   command  :   IN  cmd_rec   )
    IS
        VARIABLE slv_1, slv_2 : std_logic_vector(7 downto 0);
        VARIABLE slv_3        : std_logic_vector(15 downto 0);
        VARIABLE slv_4        : std_logic_vector(31 downto 0);
        VARIABLE opcode_tmp   : std_logic_vector(7 downto 0);
        VARIABLE Data_byte    : INTEGER := 0;
        VARIABLE Byte_number  : NATURAL RANGE 0 TO 600;
        VARIABLE cnt          : NATURAL RANGE 0 TO 512;
        VARIABLE pgm_page     : NATURAL;
        VARIABLE ByteAddress  : NATURAL RANGE 0 TO AddrRANGE;
        VARIABLE ADDR         : NATURAL RANGE 0 TO AddrRANGE;
        VARIABLE addr_tmp     : NATURAL RANGE 0 TO AddrRANGE;
        VARIABLE SECTOR       : NATURAL RANGE 0 TO SecNum;
        VARIABLE BLCK         : NATURAL RANGE 0 TO BlockNum;
        VARIABLE HALFBLCK     : NATURAL RANGE 0 TO HalfBlockNum;
        VARIABLE tmp          : NATURAL;
        VARIABLE sec_tmp      : NATURAL RANGE 0 TO 541;
    BEGIN

        half_period := half_period1_srl;

        CASE command.cmd IS

            WHEN    idle        =>

                bus_cycle(bus_cmd => bus_idle,
                          PowerUp => command.aux=PowerUp,
                          protect => command.aux=violate);

            WHEN    w_enable    =>

                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => I_WREN,
                          pulse   => command.aux=clock_num);

                bus_cycle(bus_cmd => bus_deselect);

                IF status /= err  THEN
                    SR1_V(1) := '1';
                    WREN_V := '0';
                END IF;

                WAIT FOR 9*half_period;

            WHEN    w_enablev    =>

                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => I_WRENV,
                          pulse   => command.aux=clock_num);

                bus_cycle(bus_cmd => bus_deselect);

                IF status /= err  THEN
                    WREN_V := '1';
                    SR1_V(1) := '0';
                END IF;

                WAIT FOR 9*half_period;

            WHEN    w_disable    =>

                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => I_WRDI,
                          pulse   => command.aux=clock_num);

                bus_cycle(bus_cmd => bus_deselect);

                IF status /= err  THEN
                    SR1_V(1) := '0';
                    WREN_V := '0';
                END IF;

                WAIT FOR 9*half_period;

            WHEN    w_qpien    =>

                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => I_QPIEN,
                          pulse   => command.aux=clock_num);

                bus_cycle(bus_cmd => bus_deselect);

                IF status /= err  THEN
                    CR2_V(3) := '1';
                END IF;

                WAIT FOR 9*half_period;

            WHEN    w_qpiex    =>

                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => I_QPIEX,
                          pulse   => command.aux=clock_num);

                bus_cycle(bus_cmd => bus_deselect);

                IF status /= err  THEN
                    CR2_V(3) := '0';
                END IF;

                WAIT FOR 9*half_period;

            WHEN    mbr    =>

                half_period := half_period_ddr;

                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => I_MBR);

                bus_cycle(bus_cmd => bus_deselect);

                WAIT FOR 9*half_period;

            WHEN    reset_en    =>

                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => I_RSTEN);

                bus_cycle(bus_cmd => bus_deselect);

                WAIT FOR 9*half_period;

            WHEN    rst    =>

                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => I_RST);

                bus_cycle(bus_cmd => bus_deselect);

                IF status /= err  THEN
                    CR1_V(7 DOWNTO 1) := CR1_NV(7 DOWNTO 1);
                    CR2_V(7 DOWNTO 1) := CR2_NV(7 DOWNTO 1);
                    CR2_V(0) := CR2_NV(1);
                    CR3_V := CR3_NV;
                    DLRV_reg  := DLRNV_reg;
                    WREN_V := '0';
                END IF;
                WAIT for 50 ns;

            WHEN    bam4   =>

                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => I_4BEN);

                bus_cycle(bus_cmd => bus_deselect);

                IF status /= err THEN
                    CR2_V(0) := '1';
                END IF;

                WAIT FOR 9*half_period;

            WHEN    set_bl   =>

                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd  => bus_opcode,
                          opcode   => I_SBL);

                bus_cycle(bus_cmd  => bus_data_write,
                          opcode   => I_SBL,
                          data_num => command.byte_num,
                          data1     => command.data1);

                bus_cycle(bus_cmd => bus_deselect);

                IF status /= err THEN
                    Data_byte :=  command.data1;
                    slv_1 := to_slv(Data_byte,8);
                    CR3_V(6 DOWNTO 4) := slv_1(6 DOWNTO 4);
                END IF;

                WAIT FOR 9*half_period;

            WHEN    h_reset         =>

                bus_cycle(bus_cmd => bus_reset,
                          data_num=> 1,
                          tm      => command.wtime);

                SR1_V := SR1_NV;
                CR1_V := CR1_NV;
                CR2_V(7 DOWNTO 1) := CR2_NV(7 DOWNTO 1);
                CR2_V(0) := CR2_NV(1);
                CR3_V := CR3_NV;
                DLRV_reg  := DLRNV_reg;
                WREN_V := '0';
                PR_reg(0) := '1';
                WAIT for 50 ns;

            WHEN    h_reset_io3        =>

                bus_cycle(bus_cmd => bus_reset_io3,
                          data_num=> 1,
                          tm      => command.wtime);

                SR1_V := SR1_NV;
                CR1_V := CR1_NV;
                CR2_V(7 DOWNTO 1) := CR2_NV(7 DOWNTO 1);
                CR2_V(0) := CR2_NV(1);
                CR3_V := CR3_NV;
                DLRV_reg  := DLRNV_reg;
                WREN_V := '0';
                PR_reg(0) := '1';
                WAIT for 50 ns;

            WHEN    wrar         =>

                bus_cycle(bus_cmd  => bus_select);

                bus_cycle(bus_cmd  => bus_opcode,
                          opcode   => I_WRAR);

                bus_cycle(bus_cmd => bus_address,
                          opcode  => I_WRAR,
                          address => command.addr,
                          sector  => command.sect);

                bus_cycle(bus_cmd  => bus_data_write,
                          data1    => command.data1,
                          data_num => 1);

                bus_cycle(bus_cmd  => bus_deselect);

                SECTOR := command.sect;
                ADDR   := command.addr;
                addr_tmp := SECTOR*(SecSize+1) + ADDR;

                Data_byte :=  command.data1;
                slv_1     := to_slv(Data_byte,8);

                IF status /= err THEN
                    SR1_V(1)    := '0';
                    IF addr_tmp = 16#00000000# THEN
                        SR1_NV(7 DOWNTO 2)   := slv_1(7 DOWNTO 2);
                        SR1_V(7 DOWNTO 2)    := slv_1(7 DOWNTO 2);
                    ELSIF addr_tmp = 16#00000002# THEN
                        CR1_NV(6 DOWNTO 1)   := slv_1(6 DOWNTO 1);
                        CR1_V(6 DOWNTO 0)   := slv_1(6 DOWNTO 0);
                    ELSIF addr_tmp = 16#00000003# THEN
                        CR2_NV(7 DOWNTO 1) := slv_1(7 DOWNTO 1);
                        CR2_V(7 DOWNTO 2)  := slv_1(7 DOWNTO 2);
                        CR2_V(0)  := slv_1(1);
                    ELSIF addr_tmp = 16#00000004# THEN
                        CR3_NV := slv_1;
                        CR3_V  := slv_1;
                    ELSIF addr_tmp = 16#00000005# THEN
                        DLRNV_reg := slv_1;
                        DLRV_reg  := slv_1;
                    ELSIF addr_tmp = 16#00000020# THEN
                        Password_reg(7 DOWNTO 0) := slv_1;
                    ELSIF addr_tmp = 16#00000021# THEN
                        Password_reg(15 DOWNTO 8) := slv_1;
                    ELSIF addr_tmp = 16#00000022# THEN
                        Password_reg(23 DOWNTO 16) := slv_1;
                    ELSIF addr_tmp = 16#00000023# THEN
                        Password_reg(31 DOWNTO 24) := slv_1;
                    ELSIF addr_tmp = 16#00000024# THEN
                        Password_reg(39 DOWNTO 32) := slv_1;
                    ELSIF addr_tmp = 16#00000025# THEN
                        Password_reg(47 DOWNTO 40) := slv_1;
                    ELSIF addr_tmp = 16#00000026# THEN
                        Password_reg(55 DOWNTO 48) := slv_1;
                    ELSIF addr_tmp = 16#00000027# THEN
                        Password_reg(63 DOWNTO 56) := slv_1;
                    ELSIF addr_tmp = 16#00000030# THEN
                        IF IRP_reg(2 DOWNTO 0) /= "111" THEN
                            SR2_V(5) := '1';
                        ELSE
                            IRP_reg(7 DOWNTO 0) := slv_1;
                        END IF;
                    ELSIF addr_tmp = 16#00000039# THEN
                        PRPR_reg(15 DOWNTO 8)    := slv_1;
                    ELSIF addr_tmp = 16#0000003A# THEN
                        PRPR_reg(23 DOWNTO 16)    := slv_1;
                    ELSIF addr_tmp = 16#0000003B# THEN
                        PRPR_reg(31 DOWNTO 24)    := slv_1;
                    ELSIF addr_tmp = 16#00800000# THEN
                        SR1_V(7 DOWNTO 2)    := slv_1(7 DOWNTO 2);
                    ELSIF addr_tmp = 16#00800002# THEN
                        CR1_V(6 DOWNTO 0)   := slv_1(6 DOWNTO 0);
                    ELSIF addr_tmp = 16#00800003# THEN
                        CR2_V(7 DOWNTO 2)  := slv_1(7 DOWNTO 2);
                        CR2_V(0)  := slv_1(0);
                    ELSIF addr_tmp = 16#00800004# THEN
                        CR3_V  := slv_1;
                    ELSIF addr_tmp = 16#00800005# THEN
                        DLRV_reg  := slv_1;
                    END IF;
                END IF;

            WHEN    rdar       =>

                bus_cycle(bus_cmd  => bus_select);

                bus_cycle(bus_cmd  => bus_opcode,
                          opcode   => I_RDAR);

                bus_cycle(bus_cmd  => bus_address,
                          opcode   => I_RDAR,
                          address  => command.addr,
                          sector   => command.sect);

                bus_cycle(bus_cmd => bus_dummy_clock,
                          opcode  => I_RDAR);

                bus_cycle(bus_cmd  => bus_data_read,
                          opcode   => I_RDAR,
                          data_num => command.byte_num,
                          pulse    => command.aux=clock_num);

                bus_cycle(bus_cmd => bus_desel_read);

                WAIT FOR 22*half_period;

            WHEN    w_wrr         =>

                bus_cycle(bus_cmd  => bus_select);

                bus_cycle(bus_cmd  => bus_opcode,
                          opcode   => I_WRR);

                bus_cycle(bus_cmd  => bus_data_write,
                          data1    => command.data1,
                          data_num => command.byte_num);

                bus_cycle(bus_cmd  => bus_deselect);


                Byte_number := command.byte_num;
                Data_byte :=  command.data1;
                slv_4     := to_slv(Data_byte,32);

                IF status /= err THEN
                    IF WREN_V = '1' THEN
                        SR1_V(7 downto 2) := slv_4(7 downto 2);
                    ELSIF SR1_V(1) = '1' THEN
                        SR1_NV(7 downto 2) := slv_4(7 downto 2);
                        SR1_V(7 downto 2) := slv_4(7 downto 2);
                    END IF;
                    IF Byte_number=2 OR Byte_number=3 OR Byte_number=4 THEN
                        IF WREN_V = '1' THEN
                            CR1_V(6 DOWNTO 0)   := slv_4(14 DOWNTO 8);
                        ELSIF SR1_V(1) = '1' THEN
                            CR1_NV(6 DOWNTO 1)   := slv_4(14 DOWNTO 9);
                            IF IRP_reg(2 downto 0) = "111" THEN
                                CR1_NV(0)   := slv_4(8);
                            END IF;
                            CR1_V(6 DOWNTO 0)   := slv_4(14 DOWNTO 8);
                        END IF;
                    END IF;
                    IF Byte_number=3 OR Byte_number=4 THEN
                        IF WREN_V = '1' THEN
                            CR2_V(7 DOWNTO 2)   := slv_4(23 DOWNTO 18);
                            CR2_V(0)   := slv_4(16);
                        ELSIF SR1_V(1) = '1' THEN
                            CR2_NV(7 DOWNTO 1)   := slv_4(23 DOWNTO 17);
                            CR2_V(7 DOWNTO 1)   := CR2_NV(7 DOWNTO 1);
                            CR2_V(0)   := CR2_NV(1);
                        END IF;
                    END IF;
                    IF Byte_number=4 THEN
                        IF WREN_V = '1' THEN
                            CR3_V   := slv_4(31 DOWNTO 24);
                        ELSIF SR1_V(1) = '1' THEN
                            CR3_NV   := slv_4(31 DOWNTO 24);
                            CR3_V   := CR3_NV;
                        END IF;
                    END IF;
                    WREN_V    := '0';
                    SR1_V(1)  := '0';
                END IF;

            WHEN    clr_sr       =>

                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => I_CLSR);

                bus_cycle(bus_cmd => bus_deselect);

                SR1_V(1 DOWNTO 0)    := "00";
                WREN_V := '0';

                WAIT FOR 22*half_period;

            WHEN    rd_dlp       =>

                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => I_DLPRD);

                bus_cycle(bus_cmd => bus_dummy_clock,
                          opcode  => I_DLPRD);

                bus_cycle(bus_cmd => bus_data_read,
                          opcode  => I_DLPRD,
                          data_num=> command.byte_num,
                          pulse   => command.aux=clock_num,
                          tm      => command.wtime);

                bus_cycle(bus_cmd => bus_desel_read);

                WAIT FOR 22*half_period;

            WHEN    rd | rd_4          =>
                IF command.cmd = rd THEN
                    opcode_tmp := I_READ;
                ELSIF command.cmd = rd_4 THEN
                    opcode_tmp := I_4READ;
                END IF;
                half_period := half_period3_srl;

                bus_cycle(bus_cmd => bus_select);
                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => opcode_tmp);

                bus_cycle(bus_cmd => bus_address,
                          opcode  => opcode_tmp,
                          address => command.addr,
                          sector  => command.sect);

                bus_cycle(bus_cmd => bus_data_read,
                          opcode  => opcode_tmp,
                          data_num=> command.byte_num,
                          pulse   => command.aux=clock_num);

                bus_cycle(bus_cmd => bus_desel_read);

                WAIT FOR 9*half_period;

            WHEN    fast_rd | fast_rd4 |
                    dual_output_rd | dual_output_rd4 |
                    quad_output_rd | quad_output_rd4    =>

                IF command.cmd = fast_rd THEN
                    opcode_tmp := I_FAST_READ;
                ELSIF command.cmd = fast_rd4 THEN
                    opcode_tmp := I_4FAST_READ;
                ELSIF command.cmd = dual_output_rd THEN
                    opcode_tmp := I_DOR;
                ELSIF command.cmd = dual_output_rd4 THEN
                    opcode_tmp := I_4DOR;
                ELSIF command.cmd = quad_output_rd THEN
                    opcode_tmp := I_QOR;
                ELSIF command.cmd = quad_output_rd4 THEN
                    opcode_tmp := I_4QOR;
                END IF;

                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => opcode_tmp);

                bus_cycle(bus_cmd => bus_address,
                          opcode  => opcode_tmp,
                          address => command.addr,
                          sector  => command.sect,
                          tm      => command.wtime);

                bus_cycle(bus_cmd => bus_dummy_clock,
                          opcode  => opcode_tmp,
                          tm      => command.wtime);

                bus_cycle(bus_cmd => bus_data_read,
                          opcode  => opcode_tmp,
                          data_num=> command.byte_num,
                          pulse   => command.aux=clock_num);

                bus_cycle(bus_cmd => bus_desel_read);

                WAIT FOR 22*half_period;

            WHEN    dual_IO_rd  | dual_IO_rd4 | quad_IO_rd |
                    quad_IO_rd4 | ddr_quad_IO_rd | ddr_quad_IO_rd4 =>

                IF command.cmd = dual_IO_rd THEN
                    opcode_tmp := I_DIOR;
                ELSIF command.cmd = dual_IO_rd4 THEN
                    opcode_tmp := I_4DIOR;
                ELSIF command.cmd = quad_IO_rd THEN
                    opcode_tmp := I_QIOR;
                ELSIF command.cmd = quad_IO_rd4 THEN
                    opcode_tmp := I_4QIOR;
                ELSIF command.cmd = ddr_quad_IO_rd THEN
                    opcode_tmp := I_DDRQIOR;
                    half_period := half_period_ddr;
                ELSIF command.cmd = ddr_quad_IO_rd4 THEN
                    opcode_tmp := I_4DDRQIOR;
                    half_period := half_period_ddr;
                END IF;

                bus_cycle(bus_cmd => bus_select);

                IF command.status /= rd_cont THEN
                    bus_cycle(bus_cmd => bus_opcode,
                            opcode  => opcode_tmp);
                END IF;

                bus_cycle(bus_cmd => bus_address,
                          opcode  => opcode_tmp,
                          address => command.addr,
                          sector  => command.sect);

                bus_cycle(bus_cmd => bus_mode_byte,
                          opcode  => opcode_tmp,
                          data1   => command.data1);

                bus_cycle(bus_cmd => bus_dummy_clock,
                          opcode  => opcode_tmp);

                bus_cycle(bus_cmd => bus_data_read,
                          opcode  => opcode_tmp,
                          data_num=> command.byte_num,
                          pulse   => command.aux=clock_num);

                bus_cycle(bus_cmd => bus_desel_read);

                WAIT FOR 22*half_period;

            WHEN    read_JID | read_JQID     =>

                IF command.cmd = read_JID THEN
                    opcode_tmp := I_RDID;
                ELSIF command.cmd = read_JQID THEN
                    opcode_tmp := I_RDQID;
                END IF;

                half_period := half_period2_srl;

                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => opcode_tmp);

                bus_cycle(bus_cmd => bus_data_read,
                          opcode  => opcode_tmp,
                          data_num=> command.byte_num);

                bus_cycle(bus_cmd => bus_desel_read);

                WAIT FOR 9*half_period;

            WHEN    read_SFDP      =>

                IF QPI = '1' THEN
                    half_period := half_period3_srl;
                END IF;

                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => I_RSFDP);

                bus_cycle(bus_cmd => bus_address,
                          opcode  => I_RSFDP,
                          address => command.addr,
                          sector  => command.sect);

                bus_cycle(bus_cmd => bus_dummy_clock,
                          opcode  => I_RSFDP,
                          tm      => command.wtime);

                bus_cycle(bus_cmd => bus_data_read,
                          opcode  => I_RSFDP,
                          data_num=> command.byte_num,
                          pulse   => command.aux=clock_num);

                bus_cycle(bus_cmd => bus_desel_read);

                WAIT FOR 22*half_period;

            WHEN    read_UID      =>

                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => I_RUID);

                bus_cycle(bus_cmd => bus_dummy_clock,
                          opcode  => I_RUID,
                          tm      => command.wtime);

                bus_cycle(bus_cmd => bus_data_read,
                          opcode  => I_RUID,
                          data_num=> command.byte_num,
                          pulse   => command.aux=clock_num);

                bus_cycle(bus_cmd => bus_desel_read);

                WAIT FOR 22*half_period;

            WHEN    read_SR1 | read_SR2 | read_CR1 | read_CR2 | read_CR3 =>

                half_period := half_period2_srl;

                IF command.cmd = read_SR1 THEN
                    opcode_tmp      := I_RDSR1;
                ELSIF command.cmd = read_SR2 THEN
                    opcode_tmp      := I_RDSR2;
                ELSIF command.cmd = read_CR1 THEN
                    opcode_tmp      := I_RDCR1;
                ELSIF command.cmd = read_CR2 THEN
                    opcode_tmp      := I_RDCR2;
                ELSIF command.cmd = read_CR3 THEN
                    opcode_tmp      := I_RDCR3;
                END IF;

                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => opcode_tmp);

                bus_cycle(bus_cmd => bus_data_read,
                          opcode  => opcode_tmp,
                          data_num=> command.byte_num,
                          pulse   => command.aux=clock_num);

                bus_cycle(bus_cmd => bus_desel_read);

                WAIT FOR 22*half_period;

            WHEN    sector_erase | sector_erase4 | block_erase |
            block_erase4 | halfblock_erase | halfblock_erase4 =>

                SECTOR := command.sect;
                ADDR   := command.addr;
                BLCK   := (SECTOR*(SecSize+1))/(BlockSize+1);
                HALFBLCK   := (SECTOR*(SecSize+1))/(HalfBlockSize+1);

                IF command.cmd = sector_erase OR
                command.cmd = sector_erase4 THEN
                    opcode_tmp      := I_SE;
                    AddrLow := SECTOR*(SecSize+1);
                    AddrHigh := AddrLow + SecSize;
                    IF command.cmd = sector_erase4 THEN
                        opcode_tmp      := I_4SE;
                    END IF;
                ELSIF command.cmd = block_erase OR
                command.cmd = block_erase4 THEN
                    opcode_tmp      := I_BE;
                    AddrLow := BLCK*(BlockSize+1);
                    AddrHigh := AddrLow + BlockSize;
                    IF command.cmd = sector_erase4 THEN
                        opcode_tmp      := I_4BE;
                    END IF;
                ELSIF command.cmd = halfblock_erase OR
                command.cmd = halfblock_erase4 THEN
                    opcode_tmp      := I_HBE;
                    AddrLow := HALFBLCK*(HalfBlockSize+1);
                    AddrHigh := AddrLow + HalfBlockSize;
                    IF command.cmd = halfblock_erase4 THEN
                        opcode_tmp      := I_4HBE;
                    END IF;
                END IF;

                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => opcode_tmp);

                bus_cycle(bus_cmd => bus_address,
                          opcode  => opcode_tmp,
                          address => command.addr,
                          sector  => command.sect);

                bus_cycle(bus_cmd => bus_deselect);

                IF status /= err THEN
                    FOR i IN AddrLow TO AddrHigh LOOP
                        mem(i) := 16#FF#;
                    END LOOP;
                    SR1_V(1)    := '0';
                END IF;

            WHEN    chip_erase =>

                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => I_CE);

                bus_cycle(bus_cmd => bus_deselect);

                IF status /= err THEN
                    FOR i IN 0 TO ADDRRange LOOP
                        mem(i) := 16#FF#;
                    END LOOP;
                    SR1_V(1)    := '0';
                END IF;
                WAIT FOR 22*half_period;

            WHEN     ers_susp        =>
                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => I_EPS,
                          pulse   => command.aux=clock_num,
                          tm      => command.wtime);

                bus_cycle(bus_cmd => bus_deselect);

                WAIT FOR 22*half_period;

            WHEN     ers_resume      =>
                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => I_EPR,
                          pulse   => command.aux=clock_num,
                          tm      => command.wtime);

                bus_cycle(bus_cmd => bus_deselect);

            WHEN    pg_prog | pg_prog4 |
                    qpg_prog | qpg_prog4  =>

                SECTOR := command.sect;
                ADDR   := command.addr;
                AddrLow := ((SECTOR*(SecSize+1) + ADDR)/PageSize)*PageSize;
                AddrHigh := AddrLow + PageSize-1;
                Byte_number := command.byte_num;
                Data_byte   := command.data1;
                IF command.cmd = pg_prog THEN
                    opcode_tmp      := I_PP;
                ELSIF command.cmd = pg_prog4 THEN
                    opcode_tmp      := I_4PP;
                ELSIF command.cmd = qpg_prog THEN
                    opcode_tmp      := I_QPP;
                ELSIF command.cmd = qpg_prog4 THEN
                    opcode_tmp      := I_4QPP;
                END IF;
                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => opcode_tmp);

                bus_cycle(bus_cmd => bus_address,
                          opcode  => opcode_tmp,
                          address => command.addr,
                          sector  => command.sect);

                bus_cycle(bus_cmd => bus_data_write,
                          opcode  => opcode_tmp,
                          data_num=> command.byte_num,
                          data1   => command.data1);

                bus_cycle(bus_cmd => bus_deselect);

                IF status /= err THEN
                    --if more than PageSize are sent to the device
                    IF Byte_number > PageSize THEN
                        Data_byte := Data_byte + (Byte_number-PageSize);
                        Byte_number := PageSize;
                    END IF;
                    ByteAddress := (SECTOR*(SecSize+1) + ADDR);
                    cnt := 0;

                    FOR i IN 0 TO  Byte_number - 1 LOOP
                        --page program
                        slv_1 := to_slv(Data_byte,8);

                        IF mem(ByteAddress+i-cnt)>-1 THEN
                            slv_2 := to_slv(mem(ByteAddress+i-cnt),8);
                        ELSE
                            slv_2 := (OTHERS=>'X');
                        END IF;

                        FOR j IN 0 to 7 LOOP
                            --changing bits from 1 to 0
                            IF slv_2(j)='0' THEN
                                slv_1(j):='0';
                            END IF;
                        END LOOP;

                        mem(ByteAddress + i - cnt) := to_nat(slv_1);

                        IF ByteAddress + i - cnt = AddrHigh THEN
                            cnt := i+1;
                            ByteAddress := AddrLow;
                        END IF;
                        IF Data_byte = 255 THEN
                            Data_byte := 0;
                        ELSE
                            Data_byte := Data_byte + 1;
                        END IF;
                    END LOOP;
                    SR1_V(1)    := '0';
                END IF;

            WHEN     prg_susp        =>
                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => I_EPS);

                bus_cycle(bus_cmd => bus_deselect);

                WAIT FOR 22*half_period;

            WHEN     prg_resume      =>
                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => I_EPR);

                bus_cycle(bus_cmd => bus_deselect);

            WHEN    secr_prog      =>

                ADDR        := command.addr;
                Data_byte   := command.data1;
                Byte_number := command.byte_num;

                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => I_SECRP);

                bus_cycle(bus_cmd => bus_address,
                          opcode  => I_SECRP,
                          address => command.addr,
                          sector  => 0,
                          tm      => command.wtime);

                bus_cycle(bus_cmd => bus_data_write,
                          opcode  => I_SECRP,
                          data_num=> command.byte_num,
                          data1   => command.data1);

                bus_cycle(bus_cmd => bus_deselect);

                IF status /= err THEN
                    FOR i IN 0 TO  Byte_number - 1 LOOP
                        slv_1 := to_slv(Data_byte,8);

                        IF SECR_array(ADDR + i)>-1 THEN
                            slv_2 := to_slv(SECR_array(ADDR + i),8);
                        ELSE
                            slv_2 := (OTHERS=>'X');
                        END IF;

                        FOR j IN 0 to 7 LOOP
                            --changing bits from 1 to 0
                            IF slv_2(j)='0' THEN
                                slv_1(j):='0';
                            END IF;
                        END LOOP;

                        SECR_array(ADDR + i) := to_nat(slv_1);

                        Data_byte := Data_byte + 1;

                    END LOOP;
                    SR1_V(1)    := '0';
                END IF;

            WHEN    secr_erase =>
                AddrLow := (command.addr / (SecRegSize+1)) * (SecRegSize+1);
                AddrHigh := AddrLow + SecRegSize;

                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => I_SECRE);

                bus_cycle(bus_cmd => bus_address,
                          opcode  => I_SECRE,
                          address => command.addr,
                          sector  => command.sect);

                bus_cycle(bus_cmd => bus_deselect);

                IF status /= err THEN
                    FOR i IN AddrLow TO AddrHigh LOOP
                        SECR_array(i) := 16#FF#;
                    END LOOP;
                    SR1_V(1)    := '0';
                END IF;

            WHEN    secr_read      =>
                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => I_SECRR);

                bus_cycle(bus_cmd => bus_address,
                          opcode  => I_SECRR,
                          address => command.addr,
                          sector  => command.sect);

                bus_cycle(bus_cmd => bus_dummy_clock,
                          opcode  => I_SECRR);

                bus_cycle(bus_cmd => bus_data_read,
                          opcode  => I_SECRR,
                          data_num=> command.byte_num,
                          pulse   => command.aux=clock_num);

                bus_cycle(bus_cmd => bus_desel_read);

                WAIT FOR 22*half_period;

            WHEN    w_vdlr      =>
                Byte_number := command.byte_num;
                Data_byte   := command.data1;

                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                            opcode  => I_WDLRV);

                bus_cycle(bus_cmd => bus_data_write,
                            opcode  => I_WDLRV,
                            data_num=> command.byte_num,
                            data1   => command.data1);

                bus_cycle(bus_cmd => bus_deselect);

                IF status /= err THEN
                    slv_1 := to_slv(Data_byte,8);
                    DLRV_reg  := slv_1;
                    SR1_V(1)  := '0';
                END IF;

            WHEN    w_nvdlr      =>
                Byte_number := command.byte_num;
                Data_byte   := command.data1;

                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                            opcode  => I_PDLRNV);

                bus_cycle(bus_cmd => bus_data_write,
                            opcode  => I_PDLRNV,
                            data_num=> command.byte_num,
                            data1   => command.data1);

                bus_cycle(bus_cmd => bus_deselect);

                IF status /= err THEN
                    slv_1 := to_slv(Data_byte,8);
                    DLRNV_reg  := slv_1;
                    DLRV_reg   := DLRNV_reg;
                    SR1_V(1)   := '0';
                END IF;

            WHEN    irp_reg_rd      =>
                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => I_IRPRD);

                bus_cycle(bus_cmd => bus_dummy_clock,
                          opcode  => I_IRPRD,
                          tm      => command.wtime);

                bus_cycle(bus_cmd => bus_data_read,
                          opcode  => I_IRPRD,
                          data_num=> command.byte_num,
                          pulse   => command.aux=clock_num);

                bus_cycle(bus_cmd => bus_desel_read);

                WAIT FOR 22*half_period;

            WHEN    w_irpp      =>

                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => I_IRPP);

                bus_cycle(bus_cmd => bus_data_write,
                          opcode  => I_IRPP,
                          data_num=> command.byte_num,
                          data1   => command.data1);

                bus_cycle(bus_cmd => bus_deselect);

                IF status /= err THEN
                    slv_3 := to_slv(command.data1, 16);
                    IRP_reg(7 downto 0) := slv_3(7 downto 0);
                    SR1_V(1)    := '0';
                END IF;

                WAIT FOR 22*half_period;

            WHEN    pass_reg_rd      =>
                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => I_PASSRD);

                bus_cycle(bus_cmd => bus_dummy_clock,
                          opcode  => I_PASSRD,
                          tm      => command.wtime);

                bus_cycle(bus_cmd => bus_data_read,
                          opcode  => I_PASSRD,
                          data_num=> command.byte_num,
                          pulse   => command.aux=clock_num);

                bus_cycle(bus_cmd => bus_desel_read);

                WAIT FOR 22*half_period;

            WHEN    w_password      =>

                IF command.wtime = 0 ns THEN
                    IF status /= err THEN
                        Password_reg(15 DOWNTO 0) := to_slv(command.data1, 16);
                        tmpPASS(15 DOWNTO 0) := to_slv(command.data1, 16);
                    END IF;
                ELSIF command.wtime = 1 ns THEN
                    IF status /= err THEN
                        Password_reg(31 DOWNTO 16) := to_slv(command.data1, 16);
                        tmpPASS(31 DOWNTO 16) := to_slv(command.data1, 16);
                    END IF;
                ELSIF command.wtime = 2 ns THEN
                    IF status /= err THEN
                        Password_reg(47 DOWNTO 32) := to_slv(command.data1, 16);
                        tmpPASS(47 DOWNTO 32) := to_slv(command.data1, 16);
                    END IF;
                ELSIF command.wtime = 3 ns THEN
                    IF status /= err THEN
                        Password_reg(63 DOWNTO 48) := to_slv(command.data1, 16);
                        tmpPASS(63 DOWNTO 48) := to_slv(command.data1, 16);
                        SR1_V(1)    := '0';
                    END IF;

                    bus_cycle(bus_cmd => bus_select);

                    bus_cycle(bus_cmd => bus_opcode,
                            opcode  => I_PASSP);

                    bus_cycle(bus_cmd => bus_data_write,
                            opcode  => I_PASSP,
                            data_num=> command.byte_num,
                            data1   => command.data1);

                    bus_cycle(bus_cmd => bus_deselect);

                END IF;

                WAIT FOR 22*half_period;

            WHEN    psw_unlock      =>

                IF command.wtime = 1 ns THEN

                    bus_cycle(bus_cmd => bus_select);

                    bus_cycle(bus_cmd => bus_opcode,
                            opcode  => I_PASSU,
                            pulse   => false,
                            tm      => command.wtime);

                    bus_cycle(bus_cmd => bus_data_write,
                            opcode  => I_PASSU,
                            data_num=> command.byte_num,
                            data1   => command.data1);

                    bus_cycle(bus_cmd => bus_deselect);
                END IF;

                SR1_V(1)    := '0';

                WAIT FOR 22*half_period;

            WHEN    pr_rd       =>

                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => I_PRRD);

                bus_cycle(bus_cmd => bus_data_read,
                          opcode  => I_PRRD,
                          data_num=> command.byte_num,
                          pulse   => command.aux=clock_num);

                bus_cycle(bus_cmd => bus_dummy_clock,
                          opcode  => I_PRRD,
                          tm      => command.wtime);

                bus_cycle(bus_cmd => bus_desel_read);

                WAIT FOR 22*half_period;

            WHEN    w_pr       =>

                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => I_PRL);

                bus_cycle(bus_cmd => bus_deselect);

                IF status /= err THEN
                    PR_reg(0) := '0';
                    PR_reg(6) := IRP_reg(6);
                END IF;
                SR1_V(1)    := '0';
                WAIT FOR 22*half_period;

            WHEN    ibl_rd | ibl_rd4    =>

                IF command.cmd = ibl_rd THEN
                    opcode_tmp      := I_IBLRD;
                ELSIF command.cmd = ibl_rd4 THEN
                    opcode_tmp      := I_4IBLRD;
                END IF;

                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => opcode_tmp);

                bus_cycle(bus_cmd => bus_address,
                          opcode  => opcode_tmp,
                          address => command.addr,
                          sector  => command.sect);

                bus_cycle(bus_cmd => bus_data_read,
                          opcode  => opcode_tmp,
                          data_num=> command.byte_num,
                          pulse   => command.aux=clock_num);

                bus_cycle(bus_cmd => bus_desel_read);

            WHEN    w_ibl | w_ibl4 |
                    w_ibul | w_ibul4 =>

                IF command.cmd = w_ibl THEN
                    opcode_tmp      := I_IBL;
                ELSIF command.cmd = w_ibl4 THEN
                    opcode_tmp      := I_4IBL;
                ELSIF command.cmd = w_ibul THEN
                    opcode_tmp      := I_IBUL;
                ELSIF command.cmd = w_ibul4 THEN
                    opcode_tmp      := I_4IBUL;
                END IF;

                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => opcode_tmp);

                bus_cycle(bus_cmd => bus_address,
                          opcode  => opcode_tmp,
                          address => command.addr,
                          sector  => command.sect);

                bus_cycle(bus_cmd => bus_deselect);

            WHEN    w_gbl | w_gbul =>

                IF command.cmd = w_gbl THEN
                    opcode_tmp      := I_GBL;
                ELSIF command.cmd = w_gbul THEN
                    opcode_tmp      := I_GBUL;
                END IF;

                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => opcode_tmp);

                bus_cycle(bus_cmd => bus_deselect);

            WHEN    w_sprp | w_sprp4      =>

                IF command.cmd = w_sprp THEN
                    opcode_tmp      := I_SPRP;
                ELSIF command.cmd = w_sprp4 THEN
                    opcode_tmp      := I_4SPRP;
                END IF;

                bus_cycle(bus_cmd => bus_select);

                bus_cycle(bus_cmd => bus_opcode,
                          opcode  => opcode_tmp);

                bus_cycle(bus_cmd => bus_address,
                          opcode  => opcode_tmp,
                          address => command.addr,
                          sector  => command.sect);

                bus_cycle(bus_cmd => bus_deselect);
                SR1_V(1)    := '0';
                PRPR_reg(23 downto 0) := to_slv(command.addr, 24);
                WAIT FOR 22*half_period;

            WHEN    wt          =>
                WAIT FOR command.wtime;
                WAIT for 50 ns;

            WHEN    w_dpd =>
            bus_cycle(bus_cmd => bus_select);

            bus_cycle(bus_cmd => bus_opcode,
                        opcode  => I_DPD);

            bus_cycle(bus_cmd => bus_deselect);

            WHEN    w_res =>
            bus_cycle(bus_cmd => bus_select);

            bus_cycle(bus_cmd => bus_opcode,
                        opcode  => I_RES);

            bus_cycle(bus_cmd => bus_deselect);

            WHEN    res_rd =>
            bus_cycle(bus_cmd => bus_select);

            bus_cycle(bus_cmd => bus_opcode,
                        opcode  => I_RES);

            bus_cycle(bus_cmd => bus_dummy_clock,
                        opcode  => I_RES,
                        tm      => command.wtime);

                bus_cycle(bus_cmd => bus_data_read,
                          opcode  => I_RES,
                          data_num=> command.byte_num,
                          pulse   => command.aux=clock_num);

            bus_cycle(bus_cmd => bus_deselect);

            WHEN    OTHERS  =>  null;
        END CASE;

    END PROCEDURE;

    VARIABLE cmd_cnt    :   NATURAL;
    VARIABLE command    :   cmd_rec;

BEGIN
    TestInit(TimingModel, LongTimming);
    Pick_TC (Model   =>  "s25fl256l");

    Tseries <=  ts_cnt;
    Tcase   <=  tc_cnt;

    Generate_TC
        (Model       => TimingModel,
         Series      => ts_cnt,
         TestCase    => tc_cnt,
         command_seq => cmd_seq);

    cmd_cnt := 1;
    WHILE cmd_seq(cmd_cnt).cmd /= done LOOP
        command  := cmd_seq(cmd_cnt);
        status   <=  command.status;
        cmd      <=  command.cmd;
        read_num <= command.byte_num;
        cmd_dc(command);
        cmd_cnt :=cmd_cnt +1;
    END LOOP;

END PROCESS tb;

-------------------------------------------------------------------------------
-- Checker process,
-------------------------------------------------------------------------------
checker: PROCESS
    VARIABLE Addr_reg    : std_logic_vector(31 downto 0) := (OTHERS =>'0');
    VARIABLE RDAR_reg    : std_logic_vector(7 downto 0);
    VARIABLE Data_reg    : std_logic_vector(63 downto 0);
    VARIABLE DLP0_reg    : std_logic_vector(7 downto 0);
    VARIABLE DLP_EN      : std_logic;
    VARIABLE Pass_out    : std_logic_vector(63 downto 0);
    VARIABLE address     : NATURAL;
    VARIABLE byte        : NATURAL;
    VARIABLE CFIaddress  : NATURAL RANGE 16#1000# TO 16#1115#;
    VARIABLE SFDPaddress : NATURAL RANGE 16#0000# TO 16#1115#;
    VARIABLE tmp1        : NATURAL;
    VARIABLE tmp2        : NATURAL RANGE 0 TO 4;
    VARIABLE Lat_cnt     : NATURAL;
    VARIABLE SecAddr     : NATURAL RANGE 0 TO AddrRANGE;

BEGIN

    IF (T_CSNeg='0') THEN
        --Opcode
        IF (status /= rd_cont AND status /= none) THEN
            IF QPI='1' THEN
                FOR I IN 1 DOWNTO 0 LOOP
                    WAIT UNTIL (rising_edge(T_SCK));
                END LOOP;
            ELSE
                FOR I IN 7 DOWNTO 0 LOOP
                    WAIT UNTIL (rising_edge(T_SCK));
                END LOOP;
            END IF;
        END IF;

        --Address
        Addr_reg(31 downto 25) := "0000000";
        IF (cmd=ddr_quad_IO_rd) AND (ADS='0') THEN
            WAIT UNTIL rising_edge(T_SCK);
            Addr_reg(23)   := T_IO3RESETNeg;
            Addr_reg(22)   := T_WPNeg;
            Addr_reg(21)   := T_SO;
            Addr_reg(20)   := T_SI;
            FOR I IN 1 TO 5 LOOP
                WAIT UNTIL T_SCK'EVENT;
                Addr_reg(23-4*i)   := T_IO3RESETNeg;
                Addr_reg(22-4*i)   := T_WPNeg;
                Addr_reg(21-4*i)   := T_SO;
                Addr_reg(20-4*i)   := T_SI;
            END LOOP;
            address := to_nat(Addr_reg);
        END IF;

        IF (cmd=ddr_quad_IO_rd4) OR
        (cmd=ddr_quad_IO_rd AND ADS='1') THEN
            WAIT UNTIL rising_edge(T_SCK);
            Addr_reg(31)   := T_IO3RESETNeg;
            Addr_reg(30)   := T_WPNeg;
            Addr_reg(29)   := T_SO;
            Addr_reg(28)   := T_SI;
            FOR I IN 1 TO 7 LOOP
                WAIT UNTIL T_SCK'EVENT;
                Addr_reg(31-4*i)   := T_IO3RESETNeg;
                Addr_reg(30-4*i)   := T_WPNeg;
                Addr_reg(29-4*i)   := T_SO;
                Addr_reg(28-4*i)   := T_SI;
            END LOOP;
            address := to_nat(Addr_reg);
        END IF;

        IF (cmd=quad_IO_rd) AND (ADS='0') THEN
            FOR I IN 0 TO 5 LOOP
                WAIT UNTIL rising_edge(T_SCK);
                Addr_reg(23-4*i)   := T_IO3RESETNeg;
                Addr_reg(22-4*i)   := T_WPNeg;
                Addr_reg(21-4*i)   := T_SO;
                Addr_reg(20-4*i)   := T_SI;
            END LOOP;
            address := to_nat(Addr_reg);
        END IF;

        IF (cmd=quad_IO_rd4) OR
        (cmd=quad_IO_rd AND ADS='1') THEN
            FOR I IN 0 TO 7 LOOP
                WAIT UNTIL rising_edge(T_SCK);
                Addr_reg(31-4*i)   := T_IO3RESETNeg;
                Addr_reg(30-4*i)   := T_WPNeg;
                Addr_reg(29-4*i)   := T_SO;
                Addr_reg(28-4*i)   := T_SI;
            END LOOP;
            address := to_nat(Addr_reg);
        END IF;

        IF  cmd=ibl_rd4 OR (ADS='1' AND
        (cmd=read_SFDP OR cmd=rdar OR
        cmd=secr_read OR cmd=ibl_rd)) THEN
            IF QPI='1' THEN
                FOR I IN 0 TO 7 LOOP
                    WAIT UNTIL rising_edge(T_SCK);
                    Addr_reg(31-4*i)   := T_IO3RESETNeg;
                    Addr_reg(30-4*i)   := T_WPNeg;
                    Addr_reg(29-4*i)   := T_SO;
                    Addr_reg(28-4*i)   := T_SI;
                END LOOP;
                address := to_nat(Addr_reg);
            ELSE
                FOR I IN 31 DOWNTO 0 LOOP
                    WAIT UNTIL (rising_edge(T_SCK));
                    Addr_reg(i) := T_SI;
                END LOOP;
                address := to_nat(Addr_reg);
            END IF;
        END IF;

        IF  ADS='0' AND (cmd=read_SFDP OR cmd=rdar
         OR cmd=secr_read OR cmd=ibl_rd) THEN
            IF QPI='1' THEN
                FOR I IN 0 TO 5 LOOP
                    WAIT UNTIL rising_edge(T_SCK);
                    Addr_reg(23-4*i)   := T_IO3RESETNeg;
                    Addr_reg(22-4*i)   := T_WPNeg;
                    Addr_reg(21-4*i)   := T_SO;
                    Addr_reg(20-4*i)   := T_SI;
                END LOOP;
                address := to_nat(Addr_reg);
            ELSE
                FOR I IN 23 DOWNTO 0 LOOP
                    WAIT UNTIL (rising_edge(T_SCK));
                    Addr_reg(i) := T_SI;
                END LOOP;
                address := to_nat(Addr_reg);
            END IF;
        END IF;

        IF ADS = '0' AND cmd=dual_IO_rd THEN
            FOR I IN 0 TO 11 LOOP
                WAIT UNTIL (rising_edge(T_SCK));
                Addr_reg(23-2*i) := T_SO;
                Addr_reg(22-2*i) := T_SI;
            END LOOP;
            address := to_nat(Addr_reg);
        END IF;

        IF (ADS='1' AND cmd=dual_IO_rd) OR (cmd=dual_IO_rd4) THEN
            FOR I IN 0 TO 15 LOOP
                WAIT UNTIL (rising_edge(T_SCK));
                Addr_reg(31-2*i) := T_SO;
                Addr_reg(30-2*i) := T_SI;
            END LOOP;
            address := to_nat(Addr_reg);
        END IF;

        IF ADS='0' AND (cmd=rd OR cmd=fast_rd OR cmd=dual_output_rd
        OR cmd=quad_output_rd) THEN
            FOR I IN 0 TO 23 LOOP
                WAIT UNTIL (rising_edge(T_SCK));
                Addr_reg(23-i) := T_SI;
            END LOOP;
            address := to_nat(Addr_reg);
        END IF;

        IF ADS='1' OR cmd=fast_rd4 OR cmd=dual_output_rd4
        OR cmd=quad_output_rd4 THEN
            FOR I IN 0 TO 31 LOOP
                WAIT UNTIL (rising_edge(T_SCK));
                Addr_reg(31-i) := T_SI;
            END LOOP;
            address := to_nat(Addr_reg);
        END IF;

        --Mode Byte
        IF cmd = dual_IO_rd OR cmd = dual_IO_rd4 THEN
            FOR I IN 3 DOWNTO 0 LOOP
                WAIT UNTIL rising_edge(T_SCK);
            END LOOP;
        ELSIF cmd = quad_IO_rd OR cmd = quad_IO_rd4 THEN
            FOR I IN 1 DOWNTO 0 LOOP
                WAIT UNTIL rising_edge(T_SCK);
            END LOOP;
        ELSIF cmd = ddr_quad_IO_rd OR cmd = ddr_quad_IO_rd4 THEN
            FOR I IN 1 DOWNTO 0 LOOP
                WAIT UNTIL T_SCK'EVENT;
            END LOOP;
        END IF;

        -- Dummy Bytes
        Lat_cnt := to_nat(CR3_V(3 DOWNTO 0));
        IF Lat_cnt = 0 THEN
            Lat_cnt := 8;
        END IF;
        IF cmd=rd_dlp OR cmd=irp_reg_rd OR cmd=pass_reg_rd
        OR cmd=pr_rd THEN
            Lat_cnt := 1;
        ELSIF cmd=read_UID THEN
            Lat_cnt := 32;
        ELSIF cmd=res_rd THEN
            Lat_cnt := 24;
        END IF;

        IF cmd=fast_rd OR cmd=fast_rd4 OR cmd=dual_output_rd OR
        cmd=dual_output_rd4 OR cmd=quad_output_rd OR cmd=quad_output_rd4
        OR cmd=dual_IO_rd OR cmd=dual_IO_rd4
        OR cmd=quad_IO_rd OR cmd=quad_IO_rd4 OR
        cmd=secr_read OR cmd=rdar OR cmd=read_SFDP OR cmd=rd_dlp OR
        cmd=irp_reg_rd OR cmd=pass_reg_rd OR cmd=pr_rd OR cmd=read_UID
        OR cmd=res_rd THEN
            FOR I IN Lat_cnt-1 DOWNTO 0 LOOP
                WAIT UNTIL rising_edge(T_SCK);
            END LOOP;
        ELSIF cmd = ddr_quad_IO_rd OR cmd = ddr_quad_IO_rd4 THEN
            IF Lat_cnt < 4 THEN
                FOR I IN Lat_cnt-1 DOWNTO 0 LOOP
                    WAIT UNTIL rising_edge(T_SCK);
                END LOOP;
            ELSIF Lat_cnt >= 4 THEN
                IF Lat_cnt = 4 THEN
                    WAIT FOR 8.1 ns;
                    IF (DLRV_reg /= "00000000") THEN
                        DLP0_reg(7) := T_SO;
                    END IF;
                    FOR I IN 6 DOWNTO 0 LOOP
                        WAIT UNTIL T_SCK'EVENT;
                        WAIT FOR 8.1 ns;
                        IF (DLRV_reg /= "00000000") THEN
                            DLP0_reg(I) := T_SO;
                        END IF;
                    END LOOP;
                ELSE
                    FOR I IN (Lat_cnt-5) DOWNTO 0 LOOP
                        WAIT UNTIL rising_edge(T_SCK);
                    END LOOP;
                    FOR I IN 7 DOWNTO 0 LOOP
                        WAIT UNTIL T_SCK'EVENT;
                        WAIT FOR 8.1 ns;
                        IF (DLRV_reg /= "00000000") THEN
                            DLP0_reg(I) := T_SO;
                        END IF;
                    END LOOP;
                END IF;
                IF (DLRV_reg /= "00000000") THEN
                    DLP_EN := '1';
                END IF;
            END IF;
        END IF;

        --Data Bytes
        byte        := 0;

        IF (status /= none AND status /= err) THEN
            FOR I IN read_num-1 DOWNTO 0 LOOP
                Data_reg(7 downto 0) := (OTHERS => '0');
                IF (cmd = dual_IO_rd OR cmd = dual_IO_rd4
                OR cmd = dual_output_rd OR cmd = dual_output_rd4) THEN
                    FOR J IN 0 TO 3 LOOP
                        WAIT UNTIL (falling_edge(T_SCK));
                        WAIT FOR 8.1 ns;
                        Data_reg(7-2*J) := T_SO;
                        Data_reg(6-2*J) := T_SI;
                    END LOOP;
                ELSIF cmd = quad_IO_rd OR cmd = quad_IO_rd4  OR
                cmd = quad_output_rd OR cmd = quad_output_rd4 OR
                cmd = read_JQID THEN
                    FOR J IN 0 TO 1 LOOP
                        WAIT UNTIL falling_edge(T_SCK);
                        WAIT FOR 8.1 ns;
                        Data_reg(7-4*J) := T_IO3RESETNeg;
                        Data_reg(6-4*J) := T_WPNeg;
                        Data_reg(5-4*J) := T_SO;
                        Data_reg(4-4*J) := T_SI;
                    END LOOP;
                ELSIF cmd = ddr_quad_IO_rd OR cmd = ddr_quad_IO_rd4 THEN
                    FOR J IN 0 TO 1 LOOP
                        WAIT UNTIL T_SCK'EVENT;
                        WAIT FOR 8.1 ns;
                        Data_reg(7-4*J) := T_IO3RESETNeg;
                        Data_reg(6-4*J) := T_WPNeg;
                        Data_reg(5-4*J) := T_SO;
                        Data_reg(4-4*J) := T_SI;
                    END LOOP;
                ELSIF cmd = irp_reg_rd  THEN
                    IF QPI = '0' THEN
                        FOR J IN 0 TO 1 LOOP
                            FOR I IN 7 DOWNTO 0 LOOP
                                WAIT UNTIL (falling_edge(T_SCK));
                                WAIT FOR 8.1 ns;
                                Data_reg(8*J + I) := T_SO;
                            END LOOP;
                        END LOOP;
                    ELSIF QPI = '1' THEN
                        FOR J IN 0 TO 1 LOOP
                            FOR I IN 0 TO 1 LOOP
                                WAIT UNTIL (falling_edge(T_SCK));
                                WAIT FOR 8.1 ns;
                                Data_reg(8*J+4*I+3) := T_IO3RESETNeg;
                                Data_reg(8*J+4*I+2) := T_WPNeg;
                                Data_reg(8*J+4*I+1) := T_SO;
                                Data_reg(8*J+4*I+0) := T_SI;
                            END LOOP;
                        END LOOP;
                    END IF;

                ELSIF cmd = pass_reg_rd THEN
                    IF QPI = '0' THEN
                        FOR J IN 0 TO 7 LOOP
                            FOR I IN 7 DOWNTO 0 LOOP
                                WAIT UNTIL (falling_edge(T_SCK));
                                WAIT FOR 8.1 ns;
                                Data_reg(8*J + I) := T_SO;
                            END LOOP;
                        END LOOP;
                    ELSIF QPI = '1' THEN
                        FOR J IN 0 TO 7 LOOP
                            FOR I IN 1 DOWNTO 0 LOOP
                                WAIT UNTIL (falling_edge(T_SCK));
                                WAIT FOR 8.1 ns;
                                Data_reg(8*J+4*I+3) := T_IO3RESETNeg;
                                Data_reg(8*J+4*I+2) := T_WPNeg;
                                Data_reg(8*J+4*I+1) := T_SO;
                                Data_reg(8*J+4*I+0) := T_SI;
                            END LOOP;
                        END LOOP;
                    END IF;

                ELSE
                    IF QPI = '0' THEN
                        FOR J IN 7 DOWNTO 0 LOOP
                            WAIT UNTIL (falling_edge(T_SCK));
                            WAIT FOR 8.1 ns;
                            Data_reg(J) := T_SO;
                        END LOOP;
                    ELSE
                        FOR J IN 0 TO 1 LOOP
                            WAIT UNTIL falling_edge(T_SCK);
                            WAIT FOR 8.1 ns;
                            Data_reg(7-4*J) := T_IO3RESETNeg;
                            Data_reg(6-4*J) := T_WPNeg;
                            Data_reg(5-4*J) := T_SO;
                            Data_reg(4-4*J) := T_SI;
                        END LOOP;
                    END IF;
                END IF;

                CASE status IS
                    WHEN read | read_4 | read_fast | read_fast_4 |
                         read_dual_O | read_dual_O4 |read_quad_O | read_quad_O4 |
                         read_dual_IO | read_dual_IO4| read_quad_IO |
                         read_quad_IO4 | read_ddr_quad_IO |
                         read_ddr_quad_IO4 | rd_cont =>
                        --read memory array data and dlp if enabled
                        Check_read (
                            DQ        => Data_reg(7 downto 0),
                            DQ_reg0   => DLP0_reg(7 downto 0),
                            D_mem     => mem(address),
                            DLP_reg   => to_nat(DLRV_reg),
                            DLP_EN    => DLP_EN,
                            check_err => check_err);

                        IF CR3_V(4) = '0'         --Burst Wrap Enabled
                        AND ((status=read_quad_IO  OR
                        status=read_quad_IO4 OR status=read_ddr_quad_IO OR
                        status=read_ddr_quad_IO4) OR
                        (status=rd_cont AND cmd /= dual_IO_rd AND cmd /= dual_IO_rd4)) THEN
                            address := address + 1;
                            IF CR3_V(6 DOWNTO 5)= "01" AND
                            address MOD 16 = 0 THEN
                                address:= address - 16;
                            ELSIF CR3_V(6 DOWNTO 5) = "10" AND
                            address MOD 32 = 0 THEN
                                address:= address - 32;
                            ELSIF CR3_V(6 DOWNTO 5) = "11" AND
                            address MOD 64 = 0 THEN
                                address:= address - 64;
                            ELSIF CR3_V(6 DOWNTO 5) = "00" AND
                            address MOD 8 = 0 THEN
                                address:= address - 8;
                            END IF;
                        ELSE
                            IF address = AddrRange THEN
                                address := 0;
                            ELSE
                                address := address + 1;
                            END IF;
                        END IF;
                        DLP_EN := '0';

                    WHEN rd_HiZ =>
                        --read memory array data
                        Check_Z (
                            DQ        => Data_reg(0),
                            check_err => check_err);

                    WHEN rd_U =>
                        --read memory array data
                        Check_X (
                            DQ        => Data_reg(0),
                            check_err => check_err);

                    WHEN read_secr =>
                        --read Security Region array data
                        IF address >= SECRLoAddr AND address <= SECRHiAddr THEN
                            Check_secr_read (
                                DQ         => Data_reg(7 downto 0),
                                otp_mem    => SECR_array(address),
                                check_err  => check_err);

                            address := address +1;
                        END IF;

                    WHEN rd_JID | rd_JQID =>

                        IF (byte <= 2) THEN
                            -- read ID
                            Check_read_JID (
                                DQ          => Data_reg(7 downto 0),
                                VDATA       => ManufID_DevID(byte),
                                check_err   => check_err);
                         END IF;

                         byte := byte + 1;

                    WHEN rd_SFDP =>

                        IF (address <= SFDPHiAddr) THEN
                            -- read ID
                            Check_read_SFDP (
                                DQ          => Data_reg(7 downto 0),
                                VDATA       => SFDP_array(address),
                                check_err   => check_err);
                         END IF;
                         address := address + 1;

                    WHEN rd_UID =>

                        IF (byte < 8) THEN
                            -- read ID
                            Check_read_UID (
                                DQ          => Data_reg(7 downto 0),
                                VDATA       => UID(byte),
                                check_err   => check_err);
                         END IF;
                         byte := byte + 1;

                    WHEN rd_SR1 | rd_SR2 | rd_CR1 | rd_CR2 | rd_CR3 =>

                        IF status = rd_SR1 THEN
                            tmp1 := to_nat(SR1_V);
                            tmp2 := 0;
                        ELSIF status = rd_SR2 THEN
                            tmp1 := to_nat(SR2_V);
                            tmp2 := 1;
                        ELSIF status = rd_CR1 THEN
                            tmp1 := to_nat(CR1_V);
                            tmp2 := 2;
                        ELSIF status = rd_CR2 THEN
                            tmp1 := to_nat(CR2_V);
                            tmp2 := 3;
                        ELSIF status = rd_CR3 THEN
                            tmp1 := to_nat(CR3_V);
                            tmp2 := 4;
                        END IF;
                        -- read Status/Configuration registers
                        Check_read_reg (
                            DQ          => Data_reg(7 downto 0),
                            VDATA       => tmp1,
                            sts         => tmp2,
                            check_err   => check_err);

                    WHEN read_rdar =>
                        --read all registers
                        IF address = 16#00000000# THEN
                            RDAR_reg := SR1_NV;
                        ELSIF address = 16#00000002# THEN
                            RDAR_reg := CR1_NV;
                        ELSIF address = 16#00000003# THEN
                            RDAR_reg := CR2_NV;
                        ELSIF address = 16#00000004# THEN
                            RDAR_reg := CR3_NV;
                        ELSIF address = 16#00000005# THEN
                            RDAR_reg := DLRNV_reg;
                        ELSIF address = 16#00000020# THEN
                            IF IRP_reg(2) = '1' THEN
                                RDAR_reg := Password_reg(7 DOWNTO 0);
                            ELSE
                                RDAR_reg := "XXXXXXXX";
                            END IF;
                        ELSIF address = 16#00000021# THEN
                            IF IRP_reg(2) = '1' THEN
                                RDAR_reg := Password_reg(15 DOWNTO 8);
                            ELSE
                                RDAR_reg := "XXXXXXXX";
                            END IF;
                        ELSIF address = 16#00000022# THEN
                            IF IRP_reg(2) = '1' THEN
                                RDAR_reg := Password_reg(23 DOWNTO 16);
                            ELSE
                                RDAR_reg := "XXXXXXXX";
                            END IF;
                        ELSIF address = 16#00000023# THEN
                            IF IRP_reg(2) = '1' THEN
                                RDAR_reg := Password_reg(31 DOWNTO 24);
                            ELSE
                                RDAR_reg := "XXXXXXXX";
                            END IF;
                        ELSIF address = 16#00000024# THEN
                            IF IRP_reg(2) = '1' THEN
                                RDAR_reg := Password_reg(39 DOWNTO 32);
                            ELSE
                                RDAR_reg := "XXXXXXXX";
                            END IF;
                        ELSIF address = 16#00000025# THEN
                            IF IRP_reg(2) = '1' THEN
                                RDAR_reg := Password_reg(47 DOWNTO 40);
                            ELSE
                                RDAR_reg := "XXXXXXXX";
                            END IF;
                        ELSIF address = 16#00000026# THEN
                            IF IRP_reg(2) = '1' THEN
                                RDAR_reg := Password_reg(55 DOWNTO 48);
                            ELSE
                                RDAR_reg := "XXXXXXXX";
                            END IF;
                        ELSIF address = 16#00000027# THEN
                            IF IRP_reg(2) = '1' THEN
                                RDAR_reg := Password_reg(63 DOWNTO 56);
                            ELSE
                                RDAR_reg := "XXXXXXXX";
                            END IF;
                        ELSIF address = 16#00000030# THEN
                            RDAR_reg := IRP_reg(7 DOWNTO 0);
                        ELSIF address = 16#00000031# THEN
                            RDAR_reg := IRP_reg(15 DOWNTO 8);
                        ELSIF address = 16#00000039# THEN
                            RDAR_reg := PRPR_reg(15 DOWNTO 8);
                        ELSIF address = 16#0000003A# THEN
                            RDAR_reg := PRPR_reg(23 DOWNTO 16);
                        ELSIF address = 16#0000003B# THEN
                            RDAR_reg := PRPR_reg(31 DOWNTO 24);
                        ELSIF address = 16#00800000# THEN
                            RDAR_reg := SR1_V;
                        ELSIF address = 16#00800001# THEN
                            RDAR_reg := SR2_V;
                        ELSIF address = 16#00800002# THEN
                            RDAR_reg := CR1_V;
                        ELSIF address = 16#00800003# THEN
                            RDAR_reg := CR2_V;
                        ELSIF address = 16#00800004# THEN
                            RDAR_reg := CR3_V;
                        ELSIF address = 16#00800005# THEN
                            RDAR_reg := DLRV_reg;
                        ELSIF address = 16#00800040# THEN
                            RDAR_reg := PR_reg;
                        ELSE
                            RDAR_reg := "XXXXXXXX";
                        END IF;

                        IF RDAR_reg /= "XXXXXXXX" THEN
                            Check_rdar (
                                DQ       => Data_reg(7 downto 0),
                                D_mem    => to_nat(RDAR_reg),
                                check_err=> check_err);
                        ELSE
                            Check_X (
                                DQ        => Data_reg(0),
                                check_err => check_err);
                        END IF;

                    WHEN read_dlp =>
                        --read dlp register
                        Check_read_dlp (
                            DQ       => Data_reg(7 downto 0),
                            DLP_reg  => to_nat(DLRV_reg),
                            check_err=> check_err);

                    WHEN read_irp =>
                        --read asp register
                        Check_read_irp (
                            DQ       => Data_reg(15 downto 0),
                            D_mem    => to_nat(IRP_reg),
                            check_err=> check_err);

                    WHEN read_pr =>
                        --read PR register
                        Check_read_pr (
                            DQ       => Data_reg(7 downto 0),
                            D_mem    => to_nat(PR_reg),
                            check_err=> check_err);

                    WHEN read_pass_reg =>
                        --read password register
                        Check_read_pass_reg (
                            DQ       => Data_reg(63 downto 0),
                            D_mem    => to_nat(Password_reg),
                            check_err=> check_err);

                    WHEN rd_res =>
                        --check DeviceID
                        IF (byte <= 1) THEN
                            -- read ID
                            Check_read_DevID (
                                DQ          => Data_reg(7 downto 0),
                                VDATA       => DevID(byte),
                                check_err   => check_err);
                         END IF;
                         byte := byte + 1;

                    WHEN rd_wip_0 | rd_wip_1 =>
                        Check_WIP_bit (
                            DQ       => Data_reg(0),
                            sts      => status,
                            check_err=> check_err);

                    WHEN rd_wel_0 | rd_wel_1 =>
                        Check_WEL_bit (
                            DQ       => Data_reg(1),
                            sts      => status,
                            check_err=> check_err);

                    WHEN erase_succ | erase_nosucc =>
                        Check_eers_bit (
                            DQ       => Data_reg(6),
                            sts      => status,
                            check_err=> check_err);

                    WHEN pgm_succ | pgm_nosucc =>
                        IF cmd = read_SR1 THEN
                        Check_epgm_bit (
                            DQ       => Data_reg(6),
                            sts      => status,
                            check_err=> check_err);
                        ELSE
                        Check_epgm_bit (
                            DQ       => Data_reg(5),
                            sts      => status,
                            check_err=> check_err);
                        END IF;

                    WHEN rd_ps_0 | rd_ps_1 =>
                        Check_PS_bit (
                            DQ       => Data_reg(0),
                            sts      => status,
                            check_err=> check_err);

                    WHEN rd_es_0 | rd_es_1 =>
                        Check_ES_bit (
                            DQ       => Data_reg(1),
                            sts      => status,
                            check_err=> check_err);

                    WHEN read_ibl_0 | read_ibl_1 =>
                        Check_IBL_reg (
                            DQ       => Data_reg(7 downto 0),
                            sts      => status,
                            check_err=> check_err);

                    WHEN others =>
                        null;

                END CASE;
            END LOOP;
        END IF;
    END IF;

    WAIT ON T_CSNeg;

END PROCESS checker;

    ---------------------------------------------------------------------------
    ---- SFDP Preload Process
    ---- CFI Preload Process
    ---------------------------------------------------------------------------
    SFDPPreload : PROCESS

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

    ---------------------------------------------------------------------------
    ---- File Read Section - Preload Control
    ---------------------------------------------------------------------------

    default: PROCESS
    -- text file input variables
        FILE mem_f            : text  is  mem_file;
        FILE secr_f           : text  is  secr_file;
        VARIABLE ind          : NATURAL RANGE 0 TO AddrRANGE := 0;
        VARIABLE secr_ind     : NATURAL RANGE 16#000# TO 16#3FF# := 16#000#;
        VARIABLE buf          : line;

    BEGIN
    --Preload Control
    ---------------------------------------------------------------------------
    -- File Read Section
    ---------------------------------------------------------------------------
         -- memory preload
        IF (mem_file(1 to 4) /= "none" AND UserPreload) THEN
            ind := 0;
            Mem := (OTHERS => MaxData);
            WHILE (not ENDFILE (mem_f)) LOOP
                READLINE (mem_f, buf);
                IF buf(1) = '/' THEN
                    NEXT;
                ELSIF buf(1) = '@' THEN
                    IF ind > AddrRANGE THEN
                        ASSERT false
                            REPORT "Given preload address is out of" &
                                   "memory address range"
                            SEVERITY warning;
                    ELSE
                        ind := h(buf(2 to 7)); --address
                    END IF;
                ELSE
                    Mem(ind) := h(buf(1 to 2));
                    IF ind < AddrRANGE THEN
                        ind := ind + 1;
                    END IF;
                END IF;
            END LOOP;
        END IF;
         -- memory preload
        IF (secr_file(1 to 4) /= "none" AND UserPreload) THEN
            secr_ind := 16#000#;
            SECR_array := (OTHERS => MaxData);
            WHILE (not ENDFILE (secr_f)) LOOP
                READLINE (secr_f, buf);
                IF buf(1) = '/' THEN
                    NEXT;
                ELSIF buf(1) = '@' THEN
                    IF secr_ind > 16#3FF# OR secr_ind < 16#000# THEN
                        ASSERT false
                            REPORT "Given preload address is out of" &
                                   "SECR address range"
                            SEVERITY warning;
                    ELSE
                        secr_ind := h(buf(2 to 4)); --address
                    END IF;
                ELSE
                    SECR_array(secr_ind) := h(buf(1 to 2));
                    secr_ind := secr_ind + 1;
                END IF;
            END LOOP;
        END IF;
        WAIT;
    END PROCESS default;
END vhdl_behavioral;