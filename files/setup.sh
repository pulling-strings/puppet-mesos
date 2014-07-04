echo "Hello World Bye World" > /tmp/file0
echo "Hello Hadoop Goodbye Hadoop" > /tmp/file1
sudo -u mapred hdfs dfs -mkdir -p /user/foo/data
sudo -u mapred hdfs dfs -copyFromLocal /tmp/file? /user/foo/data
