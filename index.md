## Ambient Occlusion Benchmark

For our paper [Visionaray: A Cross-Platform Ray Tracing Template Library](https://vis.uni-koeln.de/13925.html), we reported results gathered with our simple AO benchmark program implemented with [Visionaray](https://github.com/szellmann/visionaray). Going to update the results from time to time here for new hardware platforms.

<table border="0">
  <tr>
    <td>
      <img src="img/fill.png" alt="Fill" width="200" class="inline" />
    </td>
    <td>
      <img src="img/conference_ao.png" alt="Conference Room" width="200" class="inline" />
    </td>
    <td>
      <img src="img/fairy_ao.png" alt="Fairy Forest" width="200" class="inline" />
    </td>
    <td>
      <img src="img/sibenik_ao.png" alt="Sibenik Cathedral" width="200" class="inline" />
    </td>
  </tr>
  <tr>
    <td>Platform</td>
    <td>Conference Room</td>
    <td>Fairy Forest</td>
    <td>Sibenik Cathedral</td>
  </tr>
  <tr>
    <td>Raspberry PI3 with ARM NEON</td>
    <td>2.0 (2.3)</td>
    <td>1.2 (1.3)</td>
    <td>1.7 (1.9)</td>
  </tr>
  <tr>
    <td>16-core dual socket Xeon E5-2690</td>
    <td>102.0 (117.0)</td>
    <td>55.0 (57.1)</td>
    <td>94.2 (105.6)</td>
  </tr>
  <tr>
    <td>NVIDIA Quadro K6000</td>
    <td>142.4.0 (189.1)</td>
    <td>63.1 (71.1)</td>
    <td>113.2 (142.9)</td>
  </tr>
  <tr>
    <td>Intel KNL with 64 cores and 256 threads</td>
    <td>254.0 (273.2)</td>
    <td>130.0 (130.4)</td>
    <td>247.7 (268.2)</td>
  </tr>
</table>

Results in million rays per second, [binned BVH builder](http://www.sci.utah.edu/~wald/Publications/2007/ParallelBVHBuild/fastbuild.pdf), and [SBVH builder](http://www.nvidia.ca/docs/IO/77714/sbvh.pdf) in parentheses.
