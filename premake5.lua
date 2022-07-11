workspace "OpenGLStudy"
	architecture "x64"
	startproject "OpenGLStudy"
	configurations {"Debug", "Release"}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

IncludeDirs = {}
IncludeDirs["GLFW"] = "OpenGLStudy/vendor/GLFW/include"
IncludeDirs["Glad"] = "OpenGLStudy/vendor/Glad/include"

include "OpenGLStudy/vendor/GLFW"
include "OpenGLStudy/vendor/Glad"

project "OpenGLStudy"
	location "OpenGLStudy"
	kind "ConsoleApp"
	language "C++"
	staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files {"%{prj.name}/src/**.h", "%{prj.name}/src/**.cpp"}
	
	defines
	{
		"_CRT_SECURE_NO_WARNINGS"
	}

	includedirs {
		"%{prj.name}/src",
		"%{IncludeDirs.GLFW}",
		"%{IncludeDirs.Glad}",
	}
	
	links
	{
	    "GLFW",
	    "Glad",
		"opengl32.lib"
	}
	
	filter "system:windows"
		cppdialect "C++17"
		systemversion "latest"
	filter "configurations:Debug"
		defines "OS_DEBUG"
		runtime "Debug"
		symbols "on"
	filter "configurations:Release"
		defines "OS_RELEASE"
		runtime "Release"
		optimize "on"