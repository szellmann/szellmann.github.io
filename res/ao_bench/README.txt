Running the benchmarks
======================

You need a Unix/Linux system with bash!

Please follow the instructions from here to *INSTALL THE PREREQUISITES* for
building Visionaray:
https://github.com/szellmann/visionaray/wiki/Getting-started

Ubuntu:
```sudo apt-get install git build-essential cmake libboost-all-dev libglew-dev libxi-dev libxmu-dev freeglut3-dev```

Mac OS X with homebrew:
Xcode installed, and
```brew install git cmake boost glew```

Similar command lines apply for other Unix or Linux systems.

For the CUDA benchmark, please have a CUDA installation up and running in the
default location (/usr/local).

Then please execute one of the benchmark-xxx.sh scripts.

Please ensure that your windowing system lets you create a window of size
1024 x 1024 px, the benchmark will fail otherwise.

After running the benchmark, textfiles containing the benchmark results can be
found under results/. When sending over the results, please include information
that can e.g. be obtained from /proc/cpuinfo or similar.


Which benchmark to run
======================

The benchmark-sse.sh script should in theory be runnable on any CPU system with
four-wide SIMD vector units. I tried this on common Intel and AMD systems that
support at least SSE2, and on a system that supports ARM NEON-FP. You may have
to slightly alter the cmake command line (line 40, -DCMAKE_CXX_FLAGS) to meet
your needs.

The benchmark-avx.sh and benchmark-cuda.sh scripts will only work on systems
supporting either AVX or CUDA.


What the benchmark does
=======================

The benchmark scripts will try to clone a (known working) version of Visionaray
(https://github.com/szellmann/visionaray), will apply some patches (can be
found under patches/), and will then try to build a minimal release
configuration so that the ambient occlusion example program can be executed. On
success, it will perform some benchmark runs to collect performance results
that can then be found under results/.

For the CUDA benchmark, the ao_gpu branch will be checked out and patched - the
standard Visionaray AO example does not work with CUDA.

The patches will alter Visionaray's console output behavior so that common
status messages are no longer reported. Rather than that, benchmark results
will be reported to stdout. After the benchmark was executed, the application
will exit(0).

The benchmark will render 30 dry run frames in windowed mode to warm up caches,
and 250 frames to average results.


3D models
=========

The 3D models used for this script were made publicly available thanks to
Morgan McGuire and Ingo Wald:

McGuire Graphics Data
http://graphics.cs.williams.edu/data/meshes.xml

@misc{McGuire2011Data,
  title = {Computer Graphics Archive},
  author = {Morgan McGuire},
  year = {2011},
  month = {August},
  note = {\small \texttt{http://graphics.cs.williams.edu/data}},
  url = {http://graphics.cs.williams.edu/data}
}

The Utah 3D Animation Repository:
http://www.sci.utah.edu/~wald/animrep/s_en_index.html
