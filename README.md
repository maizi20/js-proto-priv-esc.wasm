# js-proto-priv-esc.wasm
利用入口对象原型访问提权到JavaScript的WebAssembly

以下代码加载并运行了一个wasm文件并传入了一个没定义属性的普通对象，但这就足够在WebAssembly中完成JavaScript提权了
```js
WebAssembly.instantiateStreaming(fetch(wasmSource),{})
```

