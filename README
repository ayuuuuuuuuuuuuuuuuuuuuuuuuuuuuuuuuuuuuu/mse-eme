Example using Media Source Extensions to play fragmented MP4 file,
and decrypting using Encrypted Media Extensions API with ClearKey encryption.

* index.html：模拟内容服务商视频播放网页，获取 EME 通信模块（本例中 eme.js），通过调用 MSE 模块（本例中 mse.js） 逐块加载视频片段并控制播放。
* resources.js：模拟 License（Key） server，与 CDM 模块交互并提供解密媒体资源所需的 key；
* media：模拟Key System 和 Packaging service。主要功能是提供一种内容保护（DRM）机制，实际应用中常见的 Key System 有 Clear Key、Playready、Widevine 等；另外，作为 Packaging Service，提供编码并加密媒体资源以供发布和播放使用。
* eme.js：模拟 EME (加密媒体扩展) 通信模块。主要包括监听 MediaKeys 的 message 和 keystatuseschange 变化；发起证书请求；最后，通过 License（key） 解密 video/audio 流；
* mse.js：模拟 MSE (媒体源扩展) 模块，通过调用浏览器提供的 MSE API，来控制视频流播放逻辑。


参考阅读 https://github.com/dt-fe/weekly - https://github.com/dt-fe/weekly/issues/37
