#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
    DESTDIR_ARG="--root=$DESTDIR"
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/***/pepper_ws/src/pepper_robot/pepper_sensors_py"

# snsure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/***/pepper_ws/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/***/pepper_ws/install/lib/python2.7/dist-packages:/home/***/pepper_ws/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/***/pepper_ws/build" \
    "/usr/bin/python" \
    "/home/***/pepper_ws/src/pepper_robot/pepper_sensors_py/setup.py" \
    build --build-base "/home/***/pepper_ws/build/pepper_robot/pepper_sensors_py" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix="/home/***/pepper_ws/install" --install-scripts="/home/***/pepper_ws/install/bin"
