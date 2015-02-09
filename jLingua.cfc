<cfcomponent output="false">
	
	<cffunction name="init">
		<cfset this.version = "1.0.4,1.1.3,1.1.4,1.1.5,1.1.6">
		<cfreturn this>
	</cffunction>
		
	<cffunction name="readLangs" returntype="void" access="public">
		<cfargument name="path" required="false" default="">
		<cfset dirr = "">
		<cfif path neq "">
			<cfset dirr = path>
		<cfelse>
			<cfset dirr = application.wheels.rootPath>
		</cfif>
		<cfset langs = StructNew()>
		<cfif isDefined("session.language")>
			<cfset langToRead="#session.language#">
		<cfelse>
			<cfset langToRead="default">
		</cfif>
		<cfif DirectoryExists("#dirr#langs/#langToRead#")>
			<cfif FileExists("#dirr#langs/#langToRead#/globals.mo")>
				<cffile action="read" file="#dirr#langs/#langToRead#/globals.mo" variable="globalLang">
				<cfset langsArray = ListToArray(trim(globalLang), "|")>
				<cfloop index="i" from="1" to="#arrayLen(langsArray)#">
					<cfset langsPos = ListToArray(trim(langsArray[i]), ":")>
					<cfset "langs.#Replace(langsPos[1], '-', '', 'all')#" = langsPos[2]>
				</cfloop>
			</cfif>
		</cfif>
		<cfif DirectoryExists("#dirr#langs/#langToRead#/#params.Controller#")>
			<cfif FileExists("#dirr#langs/#langToRead#/#params.Controller#/#params.Action#.mo")>
				<cffile action="read" file="#dirr#langs/#langToRead#/#params.Controller#/#params.Action#.mo" variable="actionLang">
				<cfset langsArray = ListToArray(trim(actionLang), "|")>
				<cfloop index="i" from="1" to="#arrayLen(langsArray)#">
					<cfset langsPos = ListToArray(trim(langsArray[i]), ":")>
					<cfset "langs.#Replace(langsPos[1], '-', '', 'all')#" = langsPos[2]>
				</cfloop>
			</cfif>
		</cfif>
		<cfset application.langs = langs>
	</cffunction>
	
	<cffunction name="getLang" output="false" returntype="String" access="public">
		<cfargument name="key" required="true" hint="This argument provides a key from a structure `langs` which value will be returned">
		<cfif isDefined("application.langs.#key#")>
			<cfset lang = #Evaluate("application.langs.#Replace(key, '-', '', 'all')#")#>
		<cfelse>
			<cfset lang = "">
		</cfif>
		<cfreturn lang>
	</cffunction>
	
</cfcomponent>