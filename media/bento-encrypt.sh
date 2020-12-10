# Note: Video track has track id 1, audio has track id 2.
# 注意：视频轨道的轨道ID为1，音频轨道的ID为2

# Extract audio/video tracks into separate fragmented files.
# 将音频/视频轨道提取到单独的碎片文件中

# --track <track-id or type> only include media from one track (pass a track ID, 'audio', 'video' or 'subtitles')
# --track <track-id or type> 仅包含媒体中的一个轨道 (通过一个轨道 ID, 或 'audio', 'video' or 'subtitles' 类型)
mp4fragment --track video sintel_trailer-720p.mp4 sintel_trailer-720p-video-fragmented.mp4
mp4fragment --track audio sintel_trailer-720p.mp4 sintel_trailer-720p-audio-fragmented.mp4

# Encrypt each track with a different key.
# 加密每个轨道 (用不同的密钥)
mp4encrypt --method MPEG-CENC --key 1:7f412f0575f44f718259beef56ec7771:0a8d9e58502141c3 --property 1:KID:2fef8ad812df429783e9bf6e5e493e53 --global-option mpeg-cenc.eme-pssh:true sintel_trailer-720p-video-fragmented.mp4 sintel_trailer-720p-video-fragmented-cenc.mp4
 
mp4encrypt --method MPEG-CENC --key 2:624db3d757bb496fb93e51f341d11716:bf07e864e27643a0 --property 2:KID:7eaa636ee7d142fd945d1f764877d8db --global-option mpeg-cenc.eme-pssh:true sintel_trailer-720p-audio-fragmented.mp4 sintel_trailer-720p-audio-fragmented-cenc.mp4

# Split fragmented files into chunks.
# 将碎片化的文件分割成块
# Note: This produces files that work in Firefox but not Chrome, so don't use it.
# 注意：这会生成可在 Firefox 中运行但不能在 Chrome 中运行的文件，因此请不要使用它
#mp4split.exe --start-number 1 --media-segment audio-%02llu.mp4 --init-segment audio-00-init.mp4 --track-id 2 --pattern-parameters N sintel_trailer-720p-audio-fragmented-cenc.mp4
#mp4split.exe --start-number 1 --media-segment video-%02llu.mp4 --init-segment video-00-init.mp4 --track-id 1 --pattern-parameters N sintel_trailer-720p-video-fragmented-cenc.mp4

# use mp4-dash.py from Bento; it outputs fragments that are decodable by Chrome.
# 使用 Bento 的 mp4-dash.py; 它输出可由Chrome解码的片段 (-f 允许输出到已存在目录, -o 指定输出目录为 fragments)
python .../utils/mp4-dash.py -f -o fragments sintel_trailer-720p-audio-fragmented-cenc.mp4
python .../utils/mp4-dash.py -f -o fragments sintel_trailer-720p-video-fragmented-cenc.mp4

# 删除 mv fragments/audio/und/mp4a audio 和 mv fragments/video/avc1 video 建立的文件夹
rm -rf audio
rm -rf video
# 重命名 fragments/audio/und/mp4a 目录为 audio
mv fragments/audio/und/mp4a audio
# 重命名 fragments/video/avc1 目录为 video
mv fragments/video/avc1 video
# 删除 Bento4 生成的输出目录
rm -rf fragments/

# 重命名文件名后缀 m4f 为 mp4
for f in audio/*.m4f; do mv "$f" "`echo $f | sed s/m4f/mp4/`"; done
for f in video/*.m4f; do mv "$f" "`echo $f | sed s/m4f/mp4/`"; done
