cmake_minimum_required(VERSION 3.0.2)
project(moveturtle)

find_package(catkin REQUIRED COMPONENTS
  geometry_msgs
  roscpp
  turtlesim
)
catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES moveturtle
#  CATKIN_DEPENDS geometry_msgs roscpp
#  DEPENDS system_lib
)
include_directories(
# include
  ${catkin_INCLUDE_DIRS}
)
add_executable(${PROJECT_NAME}_node src/moveturtle_node.cpp)
target_link_libraries(${PROJECT_NAME}_node
   ${catkin_LIBRARIES}
)

