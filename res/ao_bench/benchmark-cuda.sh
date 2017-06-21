#!/bin/bash

#------------------------------------------------------------------------------
#
#

CUDADIR=/usr/local/cuda
CUDAARCH="sm_35"
JOBS=1
BASEDIR=$PWD
BENCHMARK=$BASEDIR/build/src/examples/ao_gpu/ao_gpu

if [ "$1" = "-j" ]; then
    JOBS=$2
fi


#------------------------------------------------------------------------------
# Remove directories from previous runs
#

rm -rf $BASEDIR/build
rm -rf $BASEDIR/results
rm -rf $BASEDIR/visionaray


#------------------------------------------------------------------------------
# Check if CUDA is installed
#

$CUDADIR/bin/nvcc --version
if [ $? -ne 0 ]; then
    echo "CUDA not installed!"
    exit 1
fi


#------------------------------------------------------------------------------
# Clone visionaray,
# checkout commit with working ao examples,
# apply patch with benchmark code
# build
#

git clone https://github.com/szellmann/visionaray.git --recursive
cd $BASEDIR/visionaray
git checkout 1441d342250b92b965e51feeb982997c4a0f7695
git apply $BASEDIR/patches/0001-Benchmark-CUDA.patch
git apply $BASEDIR/patches/0001-Assert-window-size-is-1024x1024-CUDA.patch
cd $BASEDIR
mkdir -p build
cd build
cmake $BASEDIR/visionaray -DVSNRAY_ENABLE_EXAMPLES=ON -DVSNRAY_ENABLE_CUDA=ON -DVSNRAY_ENABLE_COMPILE_FAILURE_TESTS=OFF -DVSNRAY_ENABLE_UNITTESTS=OFF -DVSNRAY_ENABLE_VIEWER=OFF -DCMAKE_BUILD_TYPE="Release" -DCMAKE_CXX_FLAGS="-march=native -std=c++11" -DCUDA_NVCC_FLAGS="-arch=$CUDAARCH -std=c++11"
if [ $? -ne 0 ]; then
    echo "Please check for cmake errors"
    echo "Missing dependencies?"
    echo "Ubuntu: sudo apt-get install git build-essential cmake libboost-all-dev libglew-dev libxi-dev libxmu-dev freeglut3-dev"
    echo "Mac OS X: brew install git cmake boost glew"
    exit 1
fi
make -j $JOBS ao_gpu
if [ $? -ne 0 ]; then
    echo "Build failure"
    exit 1
fi


#------------------------------------------------------------------------------
# Run bechmarks
#

mkdir -p $BASEDIR/results
echo "Conference benchmark, no spatial splits..."
$BENCHMARK $BASEDIR/models/conference.obj -radius=100 -camera=$BASEDIR/cameras/conference-camera.txt -width=1024 -height=1024 -bgcolor 1 1 1 > $BASEDIR/results/conference_binned.txt

echo "Fairy benchmark, no spatial splits..."
$BENCHMARK $BASEDIR/models/f000.obj -radius=0.5 -camera=$BASEDIR/cameras/fairy-camera.txt -width=1024 -height=1024 -bgcolor 1 1 1 > $BASEDIR/results/fairy_binned.txt

echo "Sibenik benchmark, no spatial splits..."
$BENCHMARK $BASEDIR/models/sibenik.obj -radius=0.5 -camera=$BASEDIR/cameras/sibenik-camera.txt -width=1024 -height=1024 -bgcolor 1 1 1 > $BASEDIR/results/sibenik_binned.txt


mkdir -p $BASEDIR/results
echo "Conference benchmark, spatial splits activated..."
$BENCHMARK $BASEDIR/models/conference.obj -radius=100 -camera=$BASEDIR/cameras/conference-camera.txt -width=1024 -height=1024 -bgcolor 1 1 1 -bvh=split > $BASEDIR/results/conference_split.txt

echo "Fairy benchmark, spatial splits activated..."
$BENCHMARK $BASEDIR/models/f000.obj -radius=0.5 -camera=$BASEDIR/cameras/fairy-camera.txt -width=1024 -height=1024 -bgcolor 1 1 1 -bvh=split > $BASEDIR/results/fairy_split.txt

echo "Sibenik benchmark, spatial splits activated..."
$BENCHMARK $BASEDIR/models/sibenik.obj -radius=0.5 -camera=$BASEDIR/cameras/sibenik-camera.txt -width=1024 -height=1024 -bgcolor 1 1 1 -bvh=split > $BASEDIR/results/sibenik_split.txt
