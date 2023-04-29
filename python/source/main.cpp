#include <mhef-pp/mhef-pp.hpp>
#include <nanobind/nanobind.h>

NB_MODULE(mhef, module)
{
  module.def("add", &mhef::add);
}
