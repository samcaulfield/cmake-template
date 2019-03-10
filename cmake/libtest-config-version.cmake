set(PACKAGE_VERSION @PROJECT_VERSION@)

if("${PACKAGE_FIND_VERSION_MAJOR}" EQUAL "@PROJECT_VERSION_MAJOR@")
    if ("${PACKAGE_FIND_VERSION_MINOR}" EQUAL "@PROJECT_VERSION_MINOR@")
        set(PACKAGE_VERSION_EXACT TRUE)
    elseif("${PACKAGE_FIND_VERSION_MINOR}" LESS "@PROJECT_VERSION_MINOR@")
        set(PACKAGE_VERSION_COMPATIBLE TRUE)
    else()
        set(PACKAGE_VERSION_UNSUITABLE TRUE)
    endif()
else()
    set(PACKAGE_VERSION_UNSUITABLE TRUE)
endif()

