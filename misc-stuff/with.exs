result =
  with {:ok, file} = File.open("/etc/passwd"),
       content = IO.read(file, :all),
       :ok = File.close(file),
       [_, uid, gid] = Regex.run(~r/^_app.*?:(\d+):(\d+)/m, content) do
    "#{uid} : #{gid}"
  end

IO.puts(result)
