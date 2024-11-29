# Monitor Services

The OOM (Out of memory) killer frequently terminates services on my EC2 instance. Since upgrading the instance is not within my budget, I wrote this shell script to monitor these services. If any service goes down, the script attempts to recover it and sends an email notification to my personal email address.
