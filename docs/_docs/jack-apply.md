---
title: jack apply
---

#### Applying Changes

Now let's make some changes to the Elastic Beanstalk environment. Let's change the AutoScaling RollingUpdateEnabled from `true` to `false`.  Here is the line for that setting:

```yaml
    RollingUpdateEnabled: false
```


And then update it with the following command:

```sh
jack apply hi-web-stag
```

You should see similiar output:

<img src="/img/tutorials/jack-apply.png" class="doc-photo" />

#### Syncing Changes

Let's demonstrate one of the good reasons for using jack to manage your Elastic Beanstalk configurations. Let's say someone on the team updates one of the environment variables using the AWS Elastic Beanstalk Console.

<img src="/img/tutorials/eb-console-update.png" class="doc-photo" />

Now we decide to re-enable RollingUpdateEnabled to `true`.  We'll apply this change again:

```sh
jack apply hi-web-stag
```

Notice that this time when jack compares the configuration you see the changes that your other team member has made.

<img src="/img/tutorials/jack-apply-no.png" class="doc-photo" />

By allowing you to preview the changes and prompting for your confirmation, jack prevents you from accidentally overriding their change.  This saves later headaches and confusion when changes "suddenly" disappear.

You can now download the updated configuration first and then re-add your changes.

```
jack get hi-web-stag
# add back in your changes to `jack/cfg/hi-web-stag.cfg.yml
jack apply hi-web-stag
```

If you would like to use a different app name you can use the `--app` option.

```sh
jack apply hi-web-stag --app myapp
```

You are now set! Jack allows you codify the infrastructure code and then enables you to apply those changes safely.

<a id="prev" class="btn btn-basic" href="{% link _docs/jack-get.md %}">Back</a>
<a id="next" class="btn btn-primary" href="{% link _docs/jack-diff.md %}">Next Step</a>
<p class="keyboard-tip">Pro tip: Use the <- and -> arrow keys to move back and forward.</p>

