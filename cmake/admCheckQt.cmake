MACRO(checkQt)
	IF (NOT QT_CHECKED)
                INCLUDE(admCheckQt5)
                checkQt5()
                IF(QT5_FOUND)
                        SET(QT_FOUND 1)
                ELSE(QT5_FOUND)
                        INCLUDE(admCheckQt4)
                        checkQt4()
                        IF(QT4_FOUND)
                                SET(QT_FOUND 1)
                        ENDIF(QT4_FOUND)
                ENDIF(QT5_FOUND)
		SET(QT_CHECKED 1)
		MESSAGE("")
	ENDIF (NOT QT_CHECKED)
        include(admQtMacro)
ENDMACRO(checkQt)
