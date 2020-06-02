ARG ZAP_VERSION=w2020-02-10
FROM owasp/zap2docker-weekly:$ZAP_VERSION

# The following addons are installed by ZAP, yet no addon URL can be found. Versions of these addons will not be pinned.
# accessControl:6.0.0, formhandler:3.0.0, plugnhack:12.0.0, portscan:9.0.0, sequence:6.0.0.

# Pin to specific versions of ZAP addons
RUN cd /zap/plugin && \
    rm -f alertFilters-* && wget https://github.com/zaproxy/zap-extensions/releases/download/alertFilters-v10/alertFilters-release-10.zap && \
    rm -f ascanrules-* && wget https://github.com/zaproxy/zap-extensions/releases/download/ascanrules-v34/ascanrules-release-34.zap && \
    rm -f ascanrulesBeta-* && wget https://github.com/zaproxy/zap-extensions/releases/download/ascanrulesBeta-v27/ascanrulesBeta-beta-27.zap && \
    rm -f bruteforce-* && wget https://github.com/zaproxy/zap-extensions/releases/download/bruteforce-v9/bruteforce-beta-9.zap && \
    rm -f diff-* && wget https://github.com/zaproxy/zap-extensions/releases/download/diff-v10/diff-beta-10.zap && \
    rm -f directorylistv1-* && wget https://github.com/zaproxy/zap-extensions/releases/download/directorylistv1-v4/directorylistv1-release-4.zap && \
    rm -f fuzz-* && wget https://github.com/zaproxy/zap-extensions/releases/download/fuzz-v12/fuzz-beta-12.zap && \
    rm -f fuzzdb-* && wget https://github.com/zaproxy/zap-extensions/releases/download/fuzzdb-v6/fuzzdb-release-6.zap && \
    rm -f gettingStarted-* && wget https://github.com/zaproxy/zap-extensions/releases/download/gettingStarted-v11/gettingStarted-release-11.zap && \
    rm -f help-* && wget https://github.com/zaproxy/zap-core-help/releases/download/help-v10/help-release-10.zap && \
    rm -f hud-* && wget https://github.com/zaproxy/zap-hud/releases/download/v0.10.0/hud-beta-0.10.0.zap && \
    rm -f importurls-* && wget https://github.com/zaproxy/zap-extensions/releases/download/importurls-v7/importurls-beta-7.zap && \
    rm -f invoke-* && wget https://github.com/zaproxy/zap-extensions/releases/download/invoke-v10/invoke-beta-10.zap && \
    rm -f onlineMenu-* && wget https://github.com/zaproxy/zap-extensions/releases/download/onlineMenu-v7/onlineMenu-release-7.zap && \
    rm -f openapi-* && wget https://github.com/zaproxy/zap-extensions/releases/download/openapi-v15/openapi-beta-15.zap && \
    rm -f pscanrules-* && wget https://github.com/zaproxy/zap-extensions/releases/download/pscanrules-v28/pscanrules-release-28.zap && \
    rm -f pscanrulesBeta-* && wget https://github.com/zaproxy/zap-extensions/releases/download/pscanrulesBeta-v21/pscanrulesBeta-beta-21.zap && \
    rm -f quickstart-* && wget https://github.com/zaproxy/zap-extensions/releases/download/quickstart-v28/quickstart-release-28.zap && \
    rm -f replacer-* && wget https://github.com/zaproxy/zap-extensions/releases/download/replacer-v8/replacer-beta-8.zap && \
    rm -f reveal-* && wget https://github.com/zaproxy/zap-extensions/releases/download/reveal-v3/reveal-release-3.zap && \
    rm -f saverawmessage-* && wget https://github.com/zaproxy/zap-extensions/releases/download/saverawmessage-v5/saverawmessage-release-5.zap && \
    rm -f savexmlmessage-* && wget https://github.com/zaproxy/zap-extensions/releases/download/savexmlmessage-v0.1.0/savexmlmessage-alpha-0.1.0.zap && \
    rm -f scripts-* && wget https://github.com/zaproxy/zap-extensions/releases/download/scripts-v26/scripts-beta-26.zap && \
    rm -f selenium-* && wget https://github.com/zaproxy/zap-extensions/releases/download/selenium-v15.2.0/selenium-release-15.2.0.zap && \
    rm -f spiderAjax-* && wget https://github.com/zaproxy/zap-extensions/releases/download/spiderAjax-v23.1.0/spiderAjax-release-23.1.0.zap && \
    rm -f tips-* && wget https://github.com/zaproxy/zap-extensions/releases/download/tips-v7/tips-beta-7.zap && \
    rm -f webdriverlinux-* && wget https://github.com/zaproxy/zap-extensions/releases/download/webdriverlinux-v17/webdriverlinux-release-17.zap && \
    rm -f webdrivermacos-* && wget https://github.com/zaproxy/zap-extensions/releases/download/webdrivermacos-v16/webdrivermacos-release-16.zap && \
    rm -f webdriverwindows-* && wget https://github.com/zaproxy/zap-extensions/releases/download/webdriverwindows-v17/webdriverwindows-release-17.zap && \
    rm -f websocket-* && wget https://github.com/zaproxy/zap-extensions/releases/download/websocket-v21/websocket-release-21.zap && \
    rm -f zest-* && wget https://github.com/zaproxy/zap-extensions/releases/download/zest-v32/zest-beta-32.zap

USER root

WORKDIR /output

ARG FIREFOX_VERSION=59.0.2
ARG GECKODRIVER_VERSION=0.19.1

# Install a Firefox version that is compatible with Selenium
RUN apt-get -y remove firefox && \
      cd /opt && \
      wget http://ftp.mozilla.org/pub/firefox/releases/$FIREFOX_VERSION/linux-x86_64/en-US/firefox-$FIREFOX_VERSION.tar.bz2 && \
      tar -xvjf firefox-$FIREFOX_VERSION.tar.bz2 && \
      rm firefox-$FIREFOX_VERSION.tar.bz2 && \
      ln -s /opt/firefox/firefox /usr/bin/firefox

# Install Selenium and Mozilla webdriver
RUN cd /opt && \
      wget https://github.com/mozilla/geckodriver/releases/download/v$GECKODRIVER_VERSION/geckodriver-v$GECKODRIVER_VERSION-linux64.tar.gz && \
      tar -xvzf geckodriver-v$GECKODRIVER_VERSION-linux64.tar.gz && \
      rm geckodriver-v$GECKODRIVER_VERSION-linux64.tar.gz && \
      chmod +x geckodriver && \
      ln -s /opt/geckodriver /usr/bin/geckodriver && \
      export PATH=$PATH:/usr/bin/geckodriver

# Use Python 3
RUN update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1 && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3.6 2 && \
    update-alternatives --set python /usr/bin/python3.6

# Install python dependencies
ADD requirements.txt /dast-requirements.txt
RUN pip install --no-cache -r /dast-requirements.txt

# Copy required ZAP scripts and policies now that we're running as root
RUN mkdir -p /root/.ZAP_D && \
    cp -R /home/zap/.ZAP_D/* /root/.ZAP_D

# Add custom ZAP hook that handles authentication
COPY src/hooks.py /home/zap/.zap_hooks.py

# Wrap zap-baseline.py and zap-full-scan.py to support cli parameters for authentication
# Remove auto add on update functionality
RUN mv /zap/zap-baseline.py /zap/zap_baseline_original.py && \
    sed "s/'-addonupdate',//g" /zap/zap_baseline_original.py > temp.file && mv temp.file /zap/zap_baseline_original.py && \
    sed "s/'-addoninstall', 'pscanrulesBeta'//g" /zap/zap_baseline_original.py > temp.file && mv temp.file /zap/zap_baseline_original.py && \
    mv /zap/zap-full-scan.py /zap/zap_full_scan_original.py && \
    sed "s/'-addonupdate',//g" /zap/zap_full_scan_original.py > temp.file && mv temp.file /zap/zap_full_scan_original.py && \
    sed "s/'-addoninstall', 'pscanrulesBeta',//g" /zap/zap_full_scan_original.py > temp.file && mv temp.file /zap/zap_full_scan_original.py && \
    sed "s/'-addoninstall', 'ascanrulesBeta'//g" /zap/zap_full_scan_original.py > temp.file && mv temp.file /zap/zap_full_scan_original.py && \
    mv /zap/zap-api-scan.py /zap/zap_api_scan_original.py && \
    sed "s/'-addonupdate',//g" /zap/zap_api_scan_original.py > temp.file && mv temp.file /zap/zap_api_scan_original.py && \
    sed "s/'-addoninstall', 'pscanrulesBeta'//g" /zap/zap_api_scan_original.py > temp.file && mv temp.file /zap/zap_api_scan_original.py && \
    sed "s/Imported URLs: ' + str(len(urls)))/Imported URLs: ' + str(len(urls)))\n        trigger_hook('urls_imported', zap, urls)/g" /zap/zap_api_scan_original.py > temp.file && mv temp.file /zap/zap_api_scan_original.py && \
    chown -R zap:zap /zap

COPY --chown=zap src/ /zap/

ADD analyze /analyze

ENTRYPOINT []
CMD ["/analyze"]
