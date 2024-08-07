;;-------------------------------------
;; Nikita Makarevich (DDRDmakar) 2021-2024
;; dedrtos@gmail.com
;; Distributed under MIT license
;;-------------------------------------

;; https://www.veripool.org/verilog-mode/help/
(use-package verilog-mode
  :custom
    (verilog-indent-level             4)
    (verilog-indent-level-module      4)
    (verilog-indent-level-declaration 4)
    (verilog-indent-level-behavioral  4)
    (verilog-indent-level-directive   4)
    (verilog-case-indent              4)
    (verilog-cexp-indent              4)
    
    (verilog-auto-lineup                     nil)
    (verilog-auto-newline                    nil)
    (verilog-auto-indent-on-newline          t)
    (verilog-auto-delete-trailing-whitespace t)
    (verilog-auto-endcomments                nil)
    
    (verilog-tab-always-indent        t)
    (verilog-indent-begin-after-if    t)
    (verilog-align-ifelse t)
    
    (verilog-highlight-grouping-keywords t)
    (verilog-highlight-modules           t)
  )

(use-package fpga
  :if ded/advanced-config) ;; FPGA languages and scripts support
