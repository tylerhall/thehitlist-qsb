--  Send_To_THL.applescript
--  Send_To_THL

on Send_To_THL(results)
	using terms from application "Quick Search Box"
		repeat with x in results
			set theTask to name of x
			tell application "The Hit List"
				tell inbox to make new task with properties {title:theTask}
			end tell
		end repeat
		tell application "System Events" to set GrowlRun to (count of (every process whose name is "GrowlHelperApp")) > 0
		if GrowlRun then doGrowl(theTask)
	end using terms from
end Send_To_THL

on doGrowl(theTask)
	tell application "GrowlHelperApp"
		set the allNotificationsList to {"Task Added"}
		set the enabledNotificationsList to {"Task Added"}
		
		register as application "The Hit List (QSB)" all notifications allNotificationsList default notifications enabledNotificationsList icon of application "The Hit List"
		notify with name "Task Added" title "The Hit List" description "Task '" & theTask & "' Added in inbox" application name "The Hit List (QSB)"
	end tell
	
end doGrowl

property ASDScriptUniqueIdentifier : "Send_To_THL.applescript"