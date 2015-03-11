%module(package="eigen3", directors="1") eigen3

%{
#include <Eigen/Core>
#include <Eigen/Geometry>
#include <Eigen/Dense>
%}

#define __GNUC__
%include <Eigen/src/Core/util/Macros.h>
%include <Eigen/src/Core/util/XprHelper.h>
#undef __GNUC__

#undef EIGEN_ALIGN_TO_BOUNDARY
#define EIGEN_ALIGN_TO_BOUNDARY(n)
#undef EIGEN_STRONG_INLINE
#define EIGEN_STRONG_INLINE

%include <Eigen/src/Core/Functors.h>
%include <Eigen/src/Core/DenseCoeffsBase.h>
%include <Eigen/src/Core/DenseBase.h>
%include <Eigen/src/Core/MatrixBase.h>
%include <Eigen/src/Core/EigenBase.h>

%include <Eigen/src/Geometry/Homogeneous.h>
%include <Eigen/src/Geometry/RotationBase.h>
%include <Eigen/src/Geometry/Rotation2D.h>
%include <Eigen/src/Geometry/Quaternion.h>
%include <Eigen/src/Geometry/AngleAxis.h>
%include <Eigen/src/Geometry/Transform.h>
%include <Eigen/src/Geometry/Translation.h>
%include <Eigen/src/Geometry/Scaling.h>
%include <Eigen/src/Geometry/Hyperplane.h>
%include <Eigen/src/Geometry/ParametrizedLine.h>
%include <Eigen/src/Geometry/AlignedBox.h>
%include <Eigen/src/Geometry/Umeyama.h>
