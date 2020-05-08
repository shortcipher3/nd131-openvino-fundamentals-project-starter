#!/bin/bash
source /opt/intel/openvino/bin/setupvars.sh
cd /workspace/webservice/server/node-server
node ./server.js &
cd /workspace/webservice/ui
npm run dev &
cd /workspace
ffserver -f ./ffmpeg/server.conf &
sleep 30 # give the servers time to set up
python3 main.py -i resources/Pedestrian_Detect_2_1_1.mp4 -m FP32/frozen_inference_graph.xml -l /opt/intel/openvino/deployment_tools/inference_engine/lib/intel64/libcpu_extension_sse4.so -d CPU -pt 0.3 | ffmpeg -v warning -f rawvideo -pixel_format bgr24 -video_size 768x432 -framerate 24 -i - http://0.0.0.0:3004/fac.ffm
