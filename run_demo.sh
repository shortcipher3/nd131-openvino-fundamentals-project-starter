#!/bin/bash
docker run --rm -ti -p 3000-3004 shortcipher3/people_counter /bin/bash
cd /workspace/webservice/server/node-server
node ./server.js &
cd /workspace/webservice/ui
npm run dev &
cd /workspace
ffserver -f ./ffmpeg/server.conf &
python3 main.py -i resources/Pedestrian_Detect_2_1_1.mp4 -m FP32/frozen_inference_graph.xml -l /opt/intel/openvino/deployment_tools/inference_engine/lib/intel64/libcpu_extension_sse4.so -d CPU -pt 0.3 | ffmpeg -v warning -f rawvideo -pixel_format bgr24 -video_size 768x432 -framerate 24 -i - http://0.0.0.0:3004/fac.ffm
