all: Program.cs
	mkdir -p build/
	nuget restore SteamAuth/SteamAuth/SteamAuth.sln
	mcs -target:library -out:build/SteamAuth.dll -r:SteamAuth/SteamAuth/packages/Newtonsoft.Json.7.0.1/lib/net45/Newtonsoft.Json.dll SteamAuth/SteamAuth/APIEndpoints.cs SteamAuth/SteamAuth/AuthenticatorLinker.cs SteamAuth/SteamAuth/Confirmation.cs SteamAuth/SteamAuth/SessionData.cs SteamAuth/SteamAuth/SteamGuardAccount.cs SteamAuth/SteamAuth/SteamWeb.cs SteamAuth/SteamAuth/TimeAligner.cs SteamAuth/SteamAuth/UserLogin.cs SteamAuth/SteamAuth/Util.cs SteamAuth/SteamAuth/Properties/AssemblyInfo.cs
	cp SteamAuth/SteamAuth/packages/Newtonsoft.Json.7.0.1/lib/net45/Newtonsoft.Json.dll build/
	mcs -out:build/sda -r:build/SteamAuth.dll -r:build/Newtonsoft.Json.dll -r:/usr/lib/mono/4.5/System.Security.dll Program.cs Manifest.cs AssemblyInfo.cs Utils.cs

run:
	build/sda -v

clean:
	rm -r build/

install:
	cp build/sda /usr/local/bin/
	cp build/Newtonsoft.Json.dll /usr/local/bin/
	cp build/SteamAuth.dll /usr/local/bin/
	cp bash-tab-completion /etc/bash_completion.d/sda

uninstall:
	rm -f /usr/local/bin/sda
	rm -f /usr/local/bin/Newtonsoft.Json.dll
	rm -f /usr/local/bin/SteamAuth.dll
	rm -f /etc/bash_completion.d/sda
