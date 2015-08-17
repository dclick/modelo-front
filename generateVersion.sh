echo "<html>" > version.html
echo "<script src="https://google-code-prettify.googlecode.com/svn/loader/run_prettify.js"></script>" >> version.html
echo "<body>" >> version.html
echo "<pre class=prettyprint>" >> version.html
echo "{" >> version.html
echo "\"branch\": \"${CIRCLE_BRANCH}\"," >> version.html
echo "\"circleci_build_num\": \"${CIRCLE_BUILD_NUM}\"," >> version.html
echo "\"version\": \"${NUM_VERSION}\"," >> version.html
echo "\"git_hash\": \"$(git log --pretty=format:'%h' -n 1)\"," >> version.html
echo "}" >> version.html
echo "</body>" >> version.html
echo "</pre>" >> version.html
echo "</html>" >> version.html
mv version.html ../sesc-motofrete-server/src/main/resources/static