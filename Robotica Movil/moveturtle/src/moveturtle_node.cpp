#include "ros/ros.h"
#include "geometry_msgs/Twist.h"
#include "turtlesim/Pose.h"

#include <iostream>

using namespace std;
using namespace ros;

class ROSobj{
   private:
      NodeHandle *n;
      Publisher t_pub;
      Subscriber s;
   public:
      void set_n(NodeHandle *n){
         this->n = n;
      }
      void crear_publicador(std::string cadena){
         t_pub = n->advertise<geometry_msgs::Twist>(cadena, 1);
      }
      void poseCallback(const turtlesim::Pose::ConstPtr& msgpose);
      void crear_suscriptor(std::string cadena){
         s = n->subscribe<turtlesim::Pose>(cadena, 1, &ROSobj::poseCallback, this);
      }
      void enviar_consigna(float v, float w);
      
};

void ROSobj::poseCallback(const turtlesim::Pose::ConstPtr& msgpose)
{
   cout << "Pose: " << msgpose->x << ", " << msgpose->y << ", " << msgpose->theta << endl;
  
}

void ROSobj::enviar_consigna(float v, float w){
    geometry_msgs::Twist msg;
    msg.linear.y = msg.linear.z = 0;
    msg.angular.x = msg.angular.y = 0;
    msg.linear.x = v;
    msg.angular.z = w;
    cout << "Enviando: " << msg.linear.x << ", " << msg.angular.z << endl;   
    t_pub.publish(msg);
}


int main(int argc, char **argv)
{
  ros::init(argc, argv, "moveturtle_node");
  ros::NodeHandle n;
  ROSobj robj;
  robj.set_n(&n);
  robj.crear_publicador("/turtle1/cmd_vel");
  robj.crear_suscriptor("/turtle1/pose");
  
  ros::Rate loop_rate(4);
  while (ros::ok()){
    ros::spinOnce();
    robj.enviar_consigna(0.2, 0.1);
    loop_rate.sleep();
  }
  return 0;
}
