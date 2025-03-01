(module
  (import "console" "log" (func $log (param externref)))
  (import "__proto__" "constructor" (func $fromFunc(param funcref)(result externref)))
  (import "__proto__" "constructor" (func $toNum(param externref)(result f64)))
  (import "__proto__" "constructor" (func $new (result externref)))
  (import "constructor" "defineProperty" (func $dp (param externref externref externref)(result externref)))
  (import "constructor" "defineProperty" (func $di (param externref i32 externref)(result externref)))
  (import "constructor" "getOwnPropertyDescriptor" (func $gd (param externref externref)(result externref)))
  (import "constructor" "getOwnPropertyDescriptor" (func $gi (param externref i32)(result externref)))
  (import "constructor" "getPrototypeOf" (func $gp (param externref)(result externref)))
  (import "constructor" "getOwnPropertyNames" (func $ns (param externref)(result externref)))
  (import "constructor" "values" (func $vs (param externref)(result externref)))
  (import "constructor" "is" (func $is (param externref externref)(result i32)))
  (import "constructor" "is" (func $yes (result externref)))
  (import "valueOf" "constructor" (func $newf (param externref externref)(result externref)))
  (global $temp(mut externref)(ref.null extern))
  (elem 0 $callback)
  (func $console_log (param externref)
    local.get 0 call $console_log
  )
  (func $callback(param externref)
    local.get 0 global.set $temp
  )(func $moveAttr (param externref i32)(result externref)
    call $new i32.const 0
      local.get 0 local.get 1 call $gi
      call $di
  )
  (func $main
    (local $o externref);;{}
    (local $a externref);;['length']
    (local $u externref);;undefined
    (local $p externref);;Object.prototype
    (local $f externref);;function anonymous(
    (local $fp externref);;function anonymous(
    (local $d externref);;{value:1,writable:true,enumerable:false,configurable:false}
    (local $desValKeys externref);;['value','writable','enumerable','configurable']
    (local $valueIndex i32)
    (local $valueKey externref);;['value']
    (local $protoKeys externref);;['constructor','__defineGetter__','__defineSetter__','hasOwnProperty','__lookupGetter__','__lookupSetter__','isPrototypeOf','propertyIsEnumerable','toString','valueOf','__proto__','toLocaleString']
    (local $desSetGet externref);;{enumerable:false,configurable:true,get:ƒ,set:ƒ}
    (local $desSetGetKeys externref);;['get','set','enumerable','configurable']
    (local $valueOfKey externref);;['valueOf']
    (local $getKey externref);;['get']
    (local $setKey externref);;['set']
    (local $t1 externref)(local $t2 externref)(local $t3 externref)(local $t4 externref)
    (local $i i32)
    (local $num f64)
    call $new 
    local.tee $o call $ns call $ns
    local.tee $a local.get $a call $gd
    local.tee $d call $ns
    ;;获得value模式的配置对象
    local.set $desValKeys local.get $o i32.const 0 call $gi
    local.set $u local.get $o call $gp
    local.set $p local.get $o call $ns local.tee $t1 local.get $t1 call $newf 
    local.tee $f call $gp
    local.set $fp
    local.get $desValKeys local.set $t2
    i32.const 0 local.set $i
    loop $l1 ;;扫描配置对象中找到value键的位置
      local.get $t2 local.get $i
      call $moveAttr call $vs call $toNum local.tee $num local.get $num f64.eq if
        local.get $i local.set $valueIndex
      end
      
      local.get $t2
        local.get $i i32.const 1 i32.add local.tee $i
        call $gi local.get $u call $is i32.eqz
      br_if $l1
    end
    local.get $desValKeys local.get $valueIndex call $moveAttr call $vs local.set $valueKey

    local.get $p local.tee $t3 call $ns local.set $t2
    i32.const 0 local.set $i
    loop $l2 ;;扫描对象原型找到特殊属性__proto__的位置
      local.get $t3
        local.get $t2 local.get $i call $moveAttr call $vs call $gd
        local.tee $t1 local.get $valueKey call $gd
        local.get $u call $is if
        local.get $t1 local.set $desSetGet
      end
      local.get $t2
        local.get $i i32.const 1 i32.add local.tee $i
        call $gi local.get $u call $is i32.eqz
      br_if $l2
    end
    local.get $desSetGet call $ns local.set $desSetGetKeys
    ;;获得get/set模式的配置对象
    
    call $yes call $gp call $ns local.set $t2
    local.get $fp local.set $t3
    i32.const 0 local.set $i
    loop $l3 ;;扫描Boolean中的valueOf键,另外两个键定义在Function.prototype中
      local.get $t3
        local.get $t2 local.get $i call $moveAttr call $vs
        local.tee $t1 call $gd local.get $u call $is if
        local.get $t1 local.set $valueOfKey
      end
      local.get $t2
        local.get $i i32.const 1 i32.add local.tee $i
        call $gi local.get $u call $is i32.eqz
      br_if $l3
    end
    
    local.get $desSetGetKeys local.set $t2
    local.get $d local.set $t3
    i32.const 0 local.set $i
    loop $l4 ;;扫描__proto__属性的配置对象，借助Array强转的valueOf调用返回值区分出setter
      local.get $t3
        local.get $t2 local.get $i call $moveAttr call $vs
        local.tee $t1 call $gd local.get $u call $is if
        local.get $o call $ns local.get $valueOfKey
          local.get $desSetGet local.get $t1 call $gd
          call $dp call $toNum local.tee $num local.get $num f64.eq if
          local.get $t1 local.set $getKey
        else
          local.get $t1 local.set $setKey
        end
      end
      local.get $t2
        local.get $i i32.const 1 i32.add local.tee $i
        call $gi local.get $u call $is i32.eqz
      br_if $l4
    end
    local.get $setKey call $log
    local.get $getKey call $log
  )(start $main)
)
