
MACRO(checkQt5)
#        SET(QT5_CHECKED 1)
	IF (NOT QT5_CHECKED)
		OPTION(QT5 "" ON)

		MESSAGE(STATUS "Checking for Qt 5")
		MESSAGE(STATUS "*****************")
                IF(CROSS)
                        MESSAGE(STATUS "Cross compiling override for QT5")
				SET(CROSS5 /usr/lib/x86_64-linux-gnu/cmake/)
				SET(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CROSS5}/Qt5 ${CROSS5}/Qt5Core ${CROSS5}/Qt5Widgets)
				SET(CMAKE_PREFIX_PATH ${CMAKE_PREFIX_PATH} ${CROSS5}/Qt5 ${CROSS5}/Qt5Core ${CROSS5}/Qt5Widgets)
				MESSAGE(STATUS "Search path ${CMAKE_MODULE_PATH}")
                                FIND_PACKAGE(Qt5Core)	
			        FIND_PACKAGE(Qt5Widgets)	
                                SET(QT_QTOPENGL_FOUND 1)
	
                        	#SET(QT_QTOPENGL_LIBRARY ${QT_HOME}//lib/libQt5OpenGL.a)
                        	SET(QT_QTOPENGL_LIBRARY Qt5OpenGL)
                        	SET(QT_QTOPENGL_INCLUDE_DIR ${QT_HOME}/include/QtOpenGL)

                        	SET(QT_HEADERS_DIR   ${QT_HOME}/include/qt5  ${QT_HOME}/include/qt5/QtGui ${QT_HOME}/include/qt5/QtCore ${QT_HOME}/include/qt5/QtWidgets)
                        	SET(QT_INCLUDES    -I${QT_HOME}/include/qt5 -I${QT_HOME}/include/qt5/QtGui -I${QT_HOME}/include/qt5/QtCore -I${QT_HOME}/include/qt5/QtWidgets)
                        	SET(QT_INCLUDE_DIR   ${QT_HEADERS_DIR})
                        	SET(QT_BINARY_DIR    ${QT_HOME}/bin)
                        	SET(QT_LIBRARY_DIR   ${QT_HOME}/lib ${QT_HOME}/bin)
                        	#SET(QT_QTCORE_LIBRARY ${QT_HOME}//lib/libQt5Core.a)
                        	SET(QT_QTCORE_LIBRARY Qt5Core)
                        	#SET(QT_QTGUI_LIBRARY  ${QT_HOME}//lib/libQt5Gui.a ${QT_HOME}//lib/libQt5Widgets.a))
                        	SET(QT_QTGUI_LIBRARY  Qt5Gui Qt5Widgets)
                                SET(QT_EXTENSION qt5)
                                SET(QT_LIBRARY_EXTENSION QT5)
				SET(QT5_FOUND True)
                                SET(ADM_QT_VERSION 5)
				SET(QT5_ROOT_DIR /usr/lib/x86_64-linux-gnu/qt5/bin)
                        	SET(QT_RCC_EXECUTABLE ${QT5_ROOT_DIR}/rcc)
                        	SET(QT_MOC_EXECUTABLE ${QT5_ROOT_DIR}/moc)
                        	SET(QT_UIC_EXECUTABLE ${QT5_ROOT_DIR}/uic)
                                LINK_DIRECTORIES( ${QT_LIBRARY_DIR})
                        	#include(admCrossQt5)

				MACRO(ADM_QT5_WRAP_UI a)
                                        QT5_WRAP_UI(${a} ${ARGN})
                                ENDMACRO(ADM_QT5_WRAP_UI a)
                                MACRO(ADM_QT5_WRAP_CPP a)
                                        QT5_WRAP_CPP(${a} ${ARGN})
                                ENDMACRO(ADM_QT5_WRAP_CPP a)
                                MACRO(ADM_QT5_ADD_RESOURCES a)
                                        QT5_ADD_RESOURCES(${a} ${ARGN})
                                ENDMACRO(ADM_QT5_ADD_RESOURCES a)
                ELSE(CROSS) # WIN32/64 cross
                   IF (QT5)
		        MESSAGE(STATUS "  Checking for Qt5Core")
			FIND_PACKAGE(Qt5Core)	
		        MESSAGE(STATUS "  Checking for Qt5Widgets")
			FIND_PACKAGE(Qt5Widgets)	
                        IF(Qt5Core_FOUND AND Qt5Widgets_FOUND)
		                MESSAGE(STATUS "  Qt5 found ")
                                SET(QT5_FOUND 1)
                                SET(QT_INCLUDES ${Qt5Core_INCLUDE_DIRS} ${Qt5Widgets_INCLUDE_DIRS} ${Qt5Widgets_INCLUDE_DIRS}/QtWidgets)
                                SET(QT_QTCORE_LIBRARY ${Qt5Core_LIBRARIES})
                                SET(QT_QTGUI_LIBRARY  ${Qt5Widgets_LIBRARIES})
                                SET(QT_DEFINITIONS    ${Qt5Core_DEFINITIONS} ${Qt5Widgets_DEFINITIONS})
			        STRING(REGEX REPLACE "[\\]" "/" QT_INCLUDES "${QT_INCLUDES}")	# backslashes aren't taken care of properly on Windows
			        PRINT_LIBRARY_INFO("Qt 5" QT5_FOUND ": ${QT_INCLUDES} : ${QT_DEFINITIONS}" ": ${QT_QTCORE_LIBRARY} : ${QT_QTGUI_LIBRARY}")
			        MARK_AS_ADVANCED(LRELEASE_EXECUTABLE)
			        MARK_AS_ADVANCED(QT_MKSPECS_DIR)
			        MARK_AS_ADVANCED(QT_PLUGINS_DIR)
			        MARK_AS_ADVANCED(QT_QMAKE_EXECUTABLE)
                                # Version independant macros
                                MACRO(ADM_QT_WRAP_UI a)
                                        QT5_WRAP_UI(${a} ${ARGN})
                                ENDMACRO(ADM_QT_WRAP_UI a)
                                MACRO(ADM_QT_WRAP_CPP a)
                                        QT5_WRAP_CPP(${a} ${ARGN})
                                ENDMACRO(ADM_QT_WRAP_CPP a)
                                MACRO(ADM_QT_ADD_RESOURCES a)
                                        QT5_ADD_RESOURCES(${a} ${ARGN})
                                ENDMACRO(ADM_QT_ADD_RESOURCES a)
                                SET(QT_EXTENSION qt5)
                                SET(QT_LIBRARY_EXTENSION QT5)
                                SET(ADM_QT_VERSION 5)
                                if (Qt5_POSITION_INDEPENDENT_CODE)
                                       SET(CMAKE_POSITION_INDEPENDENT_CODE ON)
                                endif (Qt5_POSITION_INDEPENDENT_CODE)
                                # Do we have openGl also ?
                                MESSAGE(STATUS "  Checking for Qt5OpenGL")
			        FIND_PACKAGE(Qt5OpenGL)	
                                IF(Qt5OpenGL_FOUND)
                                        SET(QT_QTOPENGL_FOUND True)
                                        SET(OPENGL_INCLUDE_DIR ${Qt5OpenGL_INCLUDE_DIRS})
                                        SET(OPENGL_LIBRARIES   ${Qt5OpenGL_LIBRARIES})
		                        MESSAGE(STATUS "  Found,include=${OPENGL_INCLUDE_DIR}, libs=${OPENGL_LIBRARIES}")
                                ELSE(Qt5OpenGL_FOUND)
		                        MESSAGE(STATUS "  NOT Found")
                                ENDIF(Qt5OpenGL_FOUND)
       
                                # Do we have qtScript also ?
			        FIND_PACKAGE(Qt5Script)
                                MESSAGE(STATUS "  Checking for Qt5Script")
                                IF(Qt5Script_FOUND)
                                        MESSAGE(STATUS "   Qt5Script found")
                                        SET(QT_QTSCRIPT_FOUND 1)	
                                        SET(QT_QTSCRIPT_LIBRARY ${Qt5Script_LIBRARIES})
                                ELSE(Qt5Script_FOUND)
                                        MESSAGE(STATUS "   Qt5Script NOT found")
                                ENDIF(Qt5Script_FOUND)
                                # ----------------------------------
                         
                        ELSE(Qt5Core_FOUND AND Qt5Widgets_FOUND)
                                MESSAGE(STATUS "Some Qt5 components are missing")
                        ENDIF(Qt5Core_FOUND AND Qt5Widgets_FOUND)
                        
		  ELSE (QT5)
			MESSAGE("${MSG_DISABLE_OPTION}")
		  ENDIF (QT5)
		ENDIF(CROSS) # WIN32/64 cross

		SET(QT5_CHECKED 1)

		MESSAGE("")
	ENDIF (NOT QT5_CHECKED)
ENDMACRO(checkQt5)
