newaction {
    trigger     = "merge-compile-commands",
    description = "Merge all compile_commands/*.json into compile_commands.json",
    execute     = function ()
        print("Merging compile_commands JSON files...")

        local cmd = [[
powershell -ExecutionPolicy Bypass -Command "
$files = Get-ChildItem compile_commands -Filter *.json;
$all = @();
foreach ($f in $files) { $all += Get-Content $f.FullName | ConvertFrom-Json };
($all | ConvertTo-Json -Depth 10) | Set-Content -Encoding utf8 compile_commands.json
"
]]
        os.execute(cmd)
        print(" Merged compile_commands.json created!")
    end
}
