PRV464SX-R处理器

一波操作猛如虎，一看占用一万五

file tree:
prv464_top{
    biu{
        biu_cell{
            l1{
                TLB_line_select     //要被替换掉的表项选择器，通过比较访问参数选择出幸运的页表
                byte_select         //根据size和address给出字节选择
                cache_entry         //cache表项，包含一个PA-L1映射及访问参数
                cache               //L1缓存，同步SRAM
            }
            TLB{
                TLB_entry           //TLB表项，包含一个VA-PA映射及访问参数
                TLB_line_select     //
                page_check          //页面检查
            }
        TLB_bus_unit{               //TLB总线单元，每次当TLB需要更新时，都需要向TLB bus unit发出请求信号，TLB bus unit再进行一次转换
            page_check              //页面检查
        }
        cache_bus_unit              //cache总线单元，每次当cache需要更新行或者写穿时，都会向cache_bus_unit发出请求
        bu_mux                      //TLB_bus_unit和cache_bus_unit及外部设备访问总线的选择器，用于协调多个主机需要访问AHB总线的请求
        bu_req_mux                  //选择L1I和L1D对总线的访问信号，如果L1I和L1D同时请求使用TLB bus unit，则优先处理L1D的请求

        }
    
    }
    ins_fetch                       //取指令单元
    ins_dec                         //指令解码单元
    exu{        
        alu_au{                     //算术逻辑和地址计算器
            barrel_shifter
        }
        lsu                         //数据存取接口，提供移位和符号补全
    }
    pip_ctrl                        //流水线控制器
    cr_ru{                          //控制及寄存器单元
        Anlogic_GPR_Sample          //GPRs
        csr_satp
        m_cycle_event
        m_s_cause
        m_s_epc
        m_s_ie
        m_s_ip
        m_s_scratch
        m_s_status
        m_s_tval
        m_s_tvec
        medeleg_exc_ctrl
        mideleg_int_ctrl
        mro_csr
    }
}